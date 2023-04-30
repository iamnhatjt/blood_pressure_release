import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/extensions/int_extension.dart';
import 'package:bloodpressure/common/mixin/alarm_dialog_mixin.dart';
import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/model/bar_chart_data_model.dart';
import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:bloodpressure/domain/usecase/blood_pressure_usecase.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/add_blood_pressure/add_blood_pressure_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants/app_route.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/model/blood_pressure_model.dart';
import '../../../widget/snack_bar/app_snack_bar.dart';

class BloodPressureController extends GetxController with DateTimeMixin, AlarmDialogMixin {
  late BuildContext context;
  final BloodPressureUseCase _bloodPressureUseCase;
  final AlarmUseCase _alarmUseCase;

  final RxList<BloodPressureModel> bloodPressures = <BloodPressureModel>[].obs;
  final RxList<Map> bloodPressureChartData = <Map>[].obs;
  final RxInt sysMin = 0.obs;
  final RxInt sysMax = 0.obs;
  final RxInt diaMin = 0.obs;
  final RxInt diaMax = 0.obs;
  final RxInt chartGroupIndexSelected = 0.obs;
  final RxInt chartXValueSelected = 0.obs;
  final Rx<DateTime> chartMinDate = DateTime.now().obs;
  final Rx<DateTime> chartMaxDate = DateTime.now().obs;
  final Rx<BloodPressureModel> bloodPressSelected = BloodPressureModel().obs;
  RxBool isExporting = false.obs;

  final analytics = FirebaseAnalytics.instance;
  final appController = Get.find<AppController>();

  BloodPressureController(this._bloodPressureUseCase, this._alarmUseCase);

  @override
  void onInit() {
    filterEndDate.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
    DateTime temp = filterEndDate.value.subtract(const Duration(days: 7));
    filterStartDate.value = DateTime(temp.year, temp.month, temp.day);
    filterBloodPressure();
    super.onInit();
  }

  void onSetAlarm() {
    // if (Platform.isIOS) {
    //   showInterstitialAds(() {
    //     showAddAlarm(
    //         context: context,
    //         alarmType: AlarmType.bloodPressure,
    //         onPressCancel: Get.back,
    //         onPressSave: _onSaveAlarm);
    //   });
    // } else {
    //   showAddAlarm(
    //       context: context,
    //       alarmType: AlarmType.bloodPressure,
    //       onPressCancel: Get.back,
    //       onPressSave: _onSaveAlarm);
    // }

    showAddAlarm(context: context, alarmType: AlarmType.bloodPressure, onPressCancel: Get.back, onPressSave: _onSaveAlarm);
  }

  Future<void> _onSaveAlarm(AlarmModel alarm) async {
    _alarmUseCase.addAlarm(alarm);
    Get.find<AlarmController>().refresh();
    Get.back();
  }

  Future onAddData() async {
    analytics.logEvent(name: AppLogEvent.addDataButtonBloodPressure);
    debugPrint("Logged ${AppLogEvent.addDataButtonBloodPressure} at ${DateTime.now()}");

    _addData();
    appController.setAllowBloodPressureFirstTime(false);
  }

  void _addData() async {
    final result = await showAppDialog(context, "", "", builder: (ctx) => const AddBloodPressureDialog());
    if (result != null && result) {
      filterBloodPressure();
    }
  }

  Future filterBloodPressure() async {
    bloodPressureChartData.clear();
    final result = _bloodPressureUseCase.filterBloodPressureDate(
      filterStartDate.value.millisecondsSinceEpoch,
      filterEndDate.value.millisecondsSinceEpoch,
    );
    result.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    bloodPressures.value = result;

    if (bloodPressures.isNotEmpty) {
      bloodPressSelected.value = bloodPressures.last;
      chartXValueSelected.value = bloodPressSelected.value.dateTime!.getMillisecondDateFormat('dd/MM/yyyy');
      chartMinDate.value = DateTime.fromMillisecondsSinceEpoch(result.first.dateTime!);
      chartMaxDate.value = DateTime.fromMillisecondsSinceEpoch(result.last.dateTime!);
      final mapGroupData = groupBy(
          bloodPressures, (p0) => DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(p0.dateTime ?? 0)));
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
            sysMin.value = item.systolic ?? 0;
            sysMax.value = item.systolic ?? 0;
            diaMax.value = item.diastolic ?? 0;
            diaMin.value = item.diastolic ?? 0;
            dataList.add(BarChartDataModel(
              fromY: item.diastolic?.toDouble() ?? 0.0,
              toY: item.systolic?.toDouble() ?? 0.0,
            ));
          }
          bloodPressureChartData.add({"dateTime": handleDate.millisecondsSinceEpoch, "values": dataList});
        }
      });
    }
  }

  void onSelectedBloodPress(int dateTime, int groupIndex) {
    chartGroupIndexSelected.value = groupIndex;
    chartXValueSelected.value = dateTime;
    final tempData =
        bloodPressures.where((element) => element.dateTime!.getMillisecondDateFormat('dd/MM/yyyy') == dateTime).toList();
    if (tempData.isNotEmpty && tempData.length > groupIndex) {
      bloodPressSelected.value = tempData[groupIndex];
    }
  }

  onPressDeleteData() {
    showAppDialog(
      context,
      TranslationConstants.deleteData.tr,
      TranslationConstants.deleteDataConfirm.tr,
      firstButtonText: TranslationConstants.delete.tr,
      firstButtonCallback: () {
        Get.back();
        deleteData();
      },
      secondButtonText: TranslationConstants.cancel.tr,
      secondButtonCallback: Get.back,
    );
  }

  void deleteData() {
    _bloodPressureUseCase.deleteBloodPressure(bloodPressSelected.value.key!);
    showTopSnackBar(context, message: TranslationConstants.deleteDataSuccess.tr, type: SnackBarType.done);
    filterBloodPressure();
  }

  Future onEdit() async {
    final result = await showAppDialog(context, "", "",
        builder: (ctx) => AddBloodPressureDialog(
              bloodPressureModel: bloodPressSelected.value,
            ));
    if (result != null && result) {
      filterBloodPressure();
    }
  }

  Future<void> onExportData() async {
    analytics.logEvent(name: AppLogEvent.exportBloodPressure);
    debugPrint("Logged ${AppLogEvent.exportBloodPressure} at ${DateTime.now()}");

    if (appController.isPremiumFull.value) {
      _exportData();
    } else {
      if(appController.userLocation.compareTo("Other") != 0) {
        final prefs = await SharedPreferences.getInstance();
        int cntPressExport = prefs.getInt("cnt_export_blood_pressure") ?? 0;

        if (cntPressExport < 2) {
          _exportData();
          prefs.setInt("cnt_export_blood_pressure", cntPressExport + 1);
        } else {
          Get.toNamed(AppRoute.iosSub);
        }
      } else {
        _exportData();
      }
    }
  }

  void _exportData() async {
    analytics.logEvent(name: AppLogEvent.exportBloodPressure);
    debugPrint("Logged ${AppLogEvent.exportBloodPressure} at ${DateTime.now()}");
    isExporting.value = true;
    List<String> header = [];
    List<List<String>> listOfData = [];
    header.add(TranslationConstants.date.tr);
    header.add(TranslationConstants.time.tr);
    header.add(TranslationConstants.systolic.tr);
    header.add(TranslationConstants.diastolic.tr);
    header.add(TranslationConstants.pulse.tr);
    header.add(TranslationConstants.type.tr);
    for (final item in bloodPressures) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.dateTime ?? 0);
      listOfData.add([
        DateFormat('MMM dd, yyyy').format(dateTime),
        DateFormat('h:mm a').format(dateTime),
        '${item.systolic ?? 0}',
        '${item.diastolic ?? 0}',
        '${item.pulse ?? 0}',
        item.bloodType.name
      ]);
    }
    await exportFile(header, listOfData);
    isExporting.value = false;
  }
}
