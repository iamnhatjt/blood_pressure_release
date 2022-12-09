import 'dart:convert';

import 'package:bloodpressure/app/controller/app_controller.dart';
import 'package:bloodpressure/app/data/model/heart_rate_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../route/app_route.dart';
import '../ui/theme/app_color.dart';

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
  }

  updateHeartRateData(HeartRateModel heartRateModel) async {
    listHeartRateModel.add(heartRateModel);
    listHeartRateModelAll = [...listHeartRateModel];
    _handleData();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('heartRateData', listHeartRateModel.map((element) => jsonEncode(element.toJson())).toList());
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
}
