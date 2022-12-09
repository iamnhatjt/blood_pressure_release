import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloodpressure/app/controller/app_controller.dart';
import 'package:bloodpressure/app/data/model/heart_rate_model.dart';
import 'package:bloodpressure/app/util/app_constant.dart';
import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/string/app_strings.dart';
import '../route/app_route.dart';
import '../ui/theme/app_color.dart';
import '../ui/widget/app_dialog.dart';
import '../ui/widget/app_dialog_heart_rate_widget.dart';
import '../util/app_util.dart';

class HeartBeatController extends GetxController {
  late BuildContext context;
  RxList<HeartRateModel> listHeartRateModel = RxList();
  List<HeartRateModel> listHeartRateModelAll = [];
  RxBool isLoading = false.obs;
  Rx<HeartRateModel> currentHeartRateModel = HeartRateModel().obs;
  RxInt hrAvg = 0.obs;
  RxInt hrMin = 0.obs;
  RxInt hrMax = 0.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  final AppController _appController = Get.find<AppController>();
  RxBool isExporting = false.obs;
  RxList<Map> chartListData = RxList();
  Rx<DateTime> chartMinDate = DateTime.now().obs;
  Rx<DateTime> chartMaxDate = DateTime.now().obs;
  RxDouble chartSelectedX = 0.0.obs;

  @override
  void onInit() {
    endDate.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
    DateTime temp = endDate.value.subtract(const Duration(days: 7));
    startDate.value = DateTime(temp.year, temp.month, temp.day);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  _initData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    isLoading.value = false;
    List<String>? heartRateDataString = prefs.getStringList('heartRateData');
    if ((heartRateDataString ?? []).isNotEmpty) {
      listHeartRateModelAll = heartRateDataString!.map((e) => HeartRateModel.fromJson(jsonDecode(e))).toList();
      _handleData();
    }
  }

  _handleData() {
    List<HeartRateModel> listHeartRateModelTemp = [];
    for (final item in listHeartRateModelAll) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.timeStamp ?? 0);
      if (dateTime.isAfter(startDate.value) && dateTime.isBefore(endDate.value)) {
        listHeartRateModelTemp.add(item);
      }
    }
    listHeartRateModel.value = [...listHeartRateModelTemp];
    _generateDataChart();

    if (listHeartRateModel.isNotEmpty) {
      currentHeartRateModel.value = listHeartRateModel.last;
      int t = 0;
      int min = listHeartRateModel.first.value ?? 0;
      int max = listHeartRateModel.first.value ?? 0;
      for (final item in listHeartRateModel) {
        t += (item.value ?? 0);
        if ((item.value ?? 0) < min) {
          min = item.value ?? 0;
        }
        if ((item.value ?? 0) > max) {
          max = item.value ?? 0;
        }
      }
      hrAvg.value = t ~/ listHeartRateModel.length;
      hrMin.value = min;
      hrMax.value = max;
    }
    chartSelectedX.value = 0.0;
  }

  addHeartRateData(HeartRateModel heartRateModel) async {
    listHeartRateModelAll.add(heartRateModel);
    _handleData();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('heartRateData', listHeartRateModelAll.map((element) => jsonEncode(element.toJson())).toList());
  }

  deleteHeartRateData(HeartRateModel heartRateModel) async {
    HeartRateModel? heartRateModelTemp =
        listHeartRateModelAll.firstWhereOrNull((element) => element.timeStamp == heartRateModel.timeStamp);
    if (heartRateModelTemp != null) {
      listHeartRateModelAll.remove(heartRateModelTemp);
    }
    _handleData();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('heartRateData', listHeartRateModelAll.map((element) => jsonEncode(element.toJson())).toList());
  }

  onPressMeasureNow() {
    Get.toNamed(AppRoute.measureScreen);
  }

  onPressDateRange() async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: startDate.value,
        end: endDate.value,
      ),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Get.find<AppController>().currentLocale,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(colorScheme: const ColorScheme.light(onPrimary: AppColor.white, primary: AppColor.red)),
        child: child!,
      ),
    );
    if (result != null) {
      startDate.value = DateTime(result.start.year, result.start.month, result.start.day);
      endDate.value = DateTime(result.end.year, result.end.month, result.end.day, 23, 59, 59);
      _handleData();
    }
  }

  onPressAddData() {
    showAppDialog(
      context,
      '',
      '',
      hideGroupButton: true,
      widgetBody: AppDialogHeartRateWidget(
        allowChange: true,
        inputDateTime: DateTime.now(),
        inputValue: 70,
        onPressCancel: () {
          Get.back();
          // _recentBPM = 0;
        },
        onPressAdd: (dateTime, value) {
          if (Get.isRegistered<HeartBeatController>()) {
            Get.find<HeartBeatController>().addHeartRateData(HeartRateModel(
              timeStamp: dateTime.millisecondsSinceEpoch,
              value: value,
              age: _appController.currentUser.value.age ?? 30,
              genderId: _appController.currentUser.value.genderId ?? '0',
            ));
          }
          Get.back();
          showToast(StringConstants.addSuccess.tr);
          // _recentBPM = 0;
        },
      ),
    );
  }

  onPressExport() async {
    isExporting.value = true;
    List<String> header = [];
    List<List<String>> listOfData = [];
    header.add(StringConstants.date.tr);
    header.add(StringConstants.time.tr);
    header.add(StringConstants.age.tr);
    header.add(StringConstants.gender.tr);
    header.add('BPM');
    Map gender = AppConstant.listGender.firstWhere(
        (element) => element['id'] == _appController.currentUser.value.genderId,
        orElse: () => AppConstant.listGender[0]);
    for (final item in listHeartRateModel) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.timeStamp ?? 0);
      listOfData.add([
        formatWithLocale('MMM dd, yyyy', dateTime),
        formatWithLocale('h:mm a', dateTime),
        '${_appController.currentUser.value.age ?? 0}',
        chooseContentByLanguage(gender['nameEN'], gender['nameVN']),
        '${item.value}'
      ]);
    }
    String csvData = const ListToCsvConverter().convert([header, ...listOfData]);
    Directory? directoryTemp = await getTemporaryDirectory();
    String? path = '${directoryTemp.path}/${DateTime.now().millisecondsSinceEpoch}.csv';
    final bytes = utf8.encode(csvData);
    Uint8List bytes2 = Uint8List.fromList(bytes);
    await File(path).writeAsBytes(bytes2);
    Share.shareXFiles([XFile(path)]);
    await Future.delayed(const Duration(seconds: 1));
    isExporting.value = false;
  }

  _generateDataChart() {
    List<Map> listDataChart = [];
    Map mapGroupData = groupBy(listHeartRateModel,
        (p0) => DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(p0.timeStamp ?? 0)));
    DateTime? minDate;
    DateTime? maxDate;
    mapGroupData.forEach((key, value) {
      DateTime handleDate = DateFormat('dd/MM/yyyy').parse(key);
      if (minDate == null || minDate!.isAfter(handleDate)) {
        minDate = handleDate;
      }
      if (maxDate == null || maxDate!.isBefore(handleDate)) {
        maxDate = handleDate;
      }
      if (((value ?? []) as List).isNotEmpty) {
        HeartRateModel heartRateModelData = value[0];
        for (HeartRateModel item in value) {
          if ((item.timeStamp ?? 0) > (heartRateModelData.timeStamp ?? 0)) {
            heartRateModelData = item;
          }
        }
        listDataChart
            .add({'date': handleDate, 'value': heartRateModelData.value, 'timeStamp': heartRateModelData.timeStamp});
      }
    });
    chartListData.value = listDataChart;
    if (minDate != null) {
      chartMinDate.value = minDate!;
    }
    if (maxDate != null) {
      chartMaxDate.value = maxDate!;
    }
  }

  onPressDeleteData() {
    showAppDialog(
      context,
      StringConstants.deleteData.tr,
      StringConstants.deleteDataConfirm.tr,
      firstButtonText: StringConstants.delete.tr,
      firstButtonCallback: () {
        Get.back();
        deleteHeartRateData(currentHeartRateModel.value);
      },
      secondButtonText: StringConstants.cancel.tr,
      secondButtonCallback: Get.back,
    );
  }
}
