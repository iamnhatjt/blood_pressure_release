import 'dart:io';

import 'package:bloodpressure/common/ads/add_interstitial_ad_manager.dart';
import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/common/extensions/int_extension.dart';
import 'package:bloodpressure/common/mixin/alarm_dialog_mixin.dart';
import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/common/util/convert_utils.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/model/blood_sugar_model.dart';
import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:bloodpressure/domain/usecase/blood_sugar_usecase.dart';
import 'package:bloodpressure/presentation/controller/app_base_controller.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/add_blood_sugar_dialog/add_blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/select_state_mixin.dart';
import 'package:bloodpressure/presentation/journey/main/main_controller.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/snack_bar/app_snack_bar.dart';
import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants/app_route.dart';
import '../../../../domain/model/bar_chart_data_model.dart';
import 'add_blood_sugar_dialog/blood_sugar_add_data_dialog.dart';

class BloodSugarController extends AppBaseController
    with DateTimeMixin, SelectStateMixin, AlarmDialogMixin {
  final BloodSugarUseCase useCase;
  final AlarmUseCase alarmUseCase;

  List<BloodSugarModel> bloodSugarDataList = [];

  RxDouble rxAverage = 0.0.obs;
  RxDouble rxMin = 0.0.obs;
  RxDouble rxMax = 0.0.obs;
  RxBool rxIsEmptyList = true.obs;
  Rx<BloodSugarModel> selectedBloodSugar = BloodSugarModel().obs;
  RxList<Map> chartListData = <Map>[].obs;
  Rx<DateTime> chartMinDate = DateTime.now().obs;
  Rx<DateTime> chartMaxDate = DateTime.now().obs;
  RxInt chartGroupIndexSelected = 0.obs;
  RxInt chartXSelected = 0.obs;
  RxDouble chartMaxValue = 110.0.obs;
  RxDouble chartMinValue = 30.0.obs;
  RxList<double> chartLeftTitleList = <double>[].obs;

  Rx<LoadedType> exportLoaded = LoadedType.finish.obs;

  final analytics = FirebaseAnalytics.instance;
  final appController = Get.find<AppController>();

  BloodSugarController(
    this.useCase,
    this.alarmUseCase,
  );

  Future<void> onSelectedDateTime() async {
    await onPressDateRange(context);
    _onRefreshData();
  }

  void onDeleted(String key) async {
    await useCase.deleteBloodSugar(key);
    showTopSnackBar(context,
        message: TranslationConstants.deleteDataSuccess.tr,
        type: SnackBarType.done);
    _onRefreshData();
  }

  void onSetAlarm() {
    // if (Platform.isIOS) {
    //   showInterstitialAds(() {
    //     showAddAlarm(
    //         context: context,
    //         alarmType: AlarmType.bloodSugar,
    //         onPressCancel: Get.back,
    //         onPressSave: _onSaveAlarm);
    //   });
    // }
    // else {
    //   showAddAlarm(
    //     context: context,
    //     alarmType: AlarmType.bloodSugar,
    //     onPressCancel: Get.back,
    //     onPressSave: _onSaveAlarm);
    // }

    showAddAlarm(
        context: context,
        alarmType: AlarmType.bloodSugar,
        onPressCancel: Get.back,
        onPressSave: _onSaveAlarm);
  }

  Future<void> _onSaveAlarm(AlarmModel alarm) async {
    alarmUseCase.addAlarm(alarm);
    Get.find<AlarmController>().refresh();
    Get.back();
  }

  Future<void> onEdited(BloodSugarModel value) async {
    await showAppDialog(context, "", "",
        builder: (ctx) => BloodSugarAddDataDialog(currentBloodSugar: value));

    // final result = await showAppDialog(context, "", "",
    //     builder: (ctx) => BloodSugarAddDataDialog(currentBloodSugar: value));

    await _onRefreshData();
  }

  Future onAddData() async {
    analytics.logEvent(name: AppLogEvent.addDataButtonBloodPressure);
    debugPrint("Logged ${AppLogEvent.addDataButtonBloodPressure} at ${DateTime.now()}");

    _addData();

    // if(appController.isPremiumFull.value) {
    //   _addData();
    // } else {
    //   if(appController.userLocation.compareTo("Other") != 0) {
    //     final prefs = await SharedPreferences.getInstance();
    //     int cntAddData = prefs.getInt("cnt_add_data_blood_sugar") ?? 0;
    //
    //     if (cntAddData < 2) {
    //       _addData();
    //       prefs.setInt("cnt_add_data_blood_sugar", cntAddData + 1);
    //     } else {
    //       Get.toNamed(AppRoute.iosSub);
    //     }
    //   } else {
    //     _addData();
    //   }
    // }

    appController.setAllowBloodSugarFirstTime(false);
  }

  void _addData() async {
    Get.find<AddBloodSugarController>().onInitialData();

    // final result = await showAppDialog(context, "", "",
    //     builder: (ctx) => const BloodSugarAddDataDialog());

    await showAppDialog(context, "", "",
        builder: (ctx) => const BloodSugarAddDataDialog());

    await _onRefreshData();
  }

  Future<void> _getAllBloodSugarByFilter() async {
    bloodSugarDataList = <BloodSugarModel>[];
    var stateCode = '';
    if (rxSelectedState.value != BloodSugarStateCode.defaultCode) {
      stateCode = rxSelectedState.value;
    }
    bloodSugarDataList = useCase.getBloodSugarListByFilter(
        startDate: filterStartDate.value,
        endDate: filterEndDate.value,
        stateCode: stateCode);
    rxIsEmptyList.value = isNullEmptyList(bloodSugarDataList);
  }

  void _setAverage() {
    double sum = 0;
    for (final BloodSugarModel value in bloodSugarDataList) {
      if (value.unit == 'mmol') {
        sum += ConvertUtils.convertMmolL2MgDl((value.measure ?? 0).toString());
      } else {
        sum += value.measure ?? 0;
      }
    }
    rxAverage.value = ((sum / bloodSugarDataList.length) * 10).ceil() / 10;
  }

  void _setChartData(List<BloodSugarModel> bloodSugarList) {
    chartListData.clear();
    final mapGroupData = groupBy(
        bloodSugarList,
        (p0) => DateFormat('dd/MM/yyyy')
            .format(DateTime.fromMillisecondsSinceEpoch(p0.dateTime ?? 0)));
    if (mapGroupData.isNotEmpty) {
      final lastKey = mapGroupData.keys.last;
      final lastValue = mapGroupData[lastKey];
      if (lastValue != null && lastValue.isNotEmpty) {
        chartGroupIndexSelected.value = (lastValue.length) - 1;
      }
    }
    mapGroupData.forEach((key, value) {
      final handleDate = DateFormat('dd/MM/yyyy').parse(key);
      final dataList = <BarChartDataModel>[];
      if (value.isNotEmpty) {
        for (final item in value) {
          dataList.add(BarChartDataModel(
            fromY: 40.0,
            toY: _getBloodSugarMeasureDisplay(item),
          ));
        }
        chartListData.add({
          "dateTime": handleDate.millisecondsSinceEpoch,
          "values": dataList
        });
      }
    });
    chartMinDate.value =
        DateTime.fromMillisecondsSinceEpoch(bloodSugarDataList.first.dateTime!);
    chartMaxDate.value =
        DateTime.fromMillisecondsSinceEpoch(bloodSugarDataList.last.dateTime!);
  }

  double _getBloodSugarMeasureDisplay(BloodSugarModel value) {
    double measure = value.measure!;
    if (value.unit == BloodSugarUnit.mmollUnit) {
      measure = ConvertUtils.convertMmolL2MgDl(value.measure!.toString());
    } else {
      measure = value.measure!;
    }
    return measure;
  }

  void _setStatisticalData() {
    if (rxIsEmptyList.value == false) {
      var bloodSugarList = bloodSugarDataList;
      bloodSugarList.sort((a, b) => a.measure!.compareTo(b.measure!));
      // Lay max
      rxMax.value = _getBloodSugarMeasureDisplay(bloodSugarDataList.last);
      // Lay min
      rxMin.value = _getBloodSugarMeasureDisplay(bloodSugarDataList.first);
      _getCharMaxMin();
      // Lay trung binh
      _setAverage();
      // Lay detail moi nhat
      bloodSugarList.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
      _getLeftTitleListValue();
      _setChartData(bloodSugarList);

      selectedBloodSugar.value = bloodSugarList.last;
      chartXSelected.value = selectedBloodSugar.value.dateTime!
          .getMillisecondDateFormat('dd/MM/yyyy');
    }
  }

  void onSelectedBloodPress(int dateTime, int groupIndex) {
    chartGroupIndexSelected.value = groupIndex;
    chartXSelected.value = dateTime;
    final tempData = bloodSugarDataList
        .where((element) =>
            element.dateTime!.getMillisecondDateFormat('dd/MM/yyyy') ==
            dateTime)
        .toList();
    if (tempData.isNotEmpty && tempData.length > groupIndex) {
      selectedBloodSugar.value = tempData[groupIndex];
    }
  }

  Future<void> _onRefreshData() async {
    await _getAllBloodSugarByFilter();
    _setStatisticalData();
  }

  Future<void> onSelectedState(String value) async {
    onSelectState(value);
    await _onRefreshData();
  }

  Future<void> onExportData() async {
    analytics.logEvent(name: AppLogEvent.exportBloodSugar);
    debugPrint("Logged ${AppLogEvent.exportBloodSugar} at ${DateTime.now()}");

    // _exportData();

    if (appController.isPremiumFull.value) {
      _exportData();
    } else {
      if(appController.userLocation.compareTo("Other") != 0) {
        final prefs = await SharedPreferences.getInstance();
        int cntPressExport = prefs.getInt("cnt_export_blood_sugar") ?? 0;

        if (cntPressExport < 2) {
          _exportData();
          prefs.setInt("cnt_export_blood_sugar", cntPressExport + 1);
        } else {
          Get.toNamed(AppRoute.iosSub);
        }
      } else {
        _exportData();
      }
    }
  }

  void _exportData() async {
    exportLoaded.value = LoadedType.start;
    List<String> header = [];
    List<List<String>> listOfData = [];
    header.add(TranslationConstants.date.tr);
    header.add(TranslationConstants.time.tr);
    header.add(TranslationConstants.bloodSugar.tr);
    header
        .add('${TranslationConstants.measure.tr} (${BloodSugarUnit.mgdLUnit})');
    header.add(
        '${TranslationConstants.bloodSugar.tr} (${BloodSugarUnit.mgdLUnit})');
    header.add(TranslationConstants.bloodSugarState.tr);
    header.add(TranslationConstants.bloodSugarInfo.tr);

    var bloodSugarList = bloodSugarDataList;
    bloodSugarList.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
    for (final BloodSugarModel element in bloodSugarList) {
      var dateTime = DateTime.fromMillisecondsSinceEpoch(element.dateTime!);
      listOfData.add([
        DateFormat('MMM dd, yyyy').format(dateTime),
        DateFormat('h:mm a').format(dateTime),
        element.measure.toString(),
        bloodSugarStateDisplayMap[element.stateCode]!,
        bloodSugarInfoDisplayMap[element.infoCode]!,
      ]);
    }
    await exportFile(header, listOfData);
    exportLoaded.value = LoadedType.finish;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _onRefreshData();
  }

  void _getCharMaxMin() {
    chartMinValue.value = rxMin.value - 10.0;
    chartMaxValue.value = rxMax.value + 10.0;
  }

  void _getLeftTitleListValue() {
    chartLeftTitleList.clear();
    final minValue = chartMinValue.value + 10;
    final maxValue = chartMaxValue.value - 10;
    final spaceValue = maxValue - minValue;
    final itemSpace = (spaceValue / 6).round();
    final tempList = <double>[];
    var item = minValue + itemSpace;
    while (item < maxValue) {
      tempList.add(item);
      item += itemSpace;
    }
    if (tempList.length == 4) {
      chartLeftTitleList.add(minValue);
      chartLeftTitleList.addAll(tempList);
      chartLeftTitleList.add(maxValue);
    } else {
      chartLeftTitleList.add(minValue);
      chartLeftTitleList.addAll(tempList);
      // chartMaxValue.value =
      //     chartLeftTitleList.last += itemSpace;
    }
  }
}
