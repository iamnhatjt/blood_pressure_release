import 'package:bloodpressure/common/mixin/alarm_dialog_mixin.dart';
import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:bloodpressure/domain/usecase/blood_pressure_usecase.dart';
import 'package:bloodpressure/presentation/journey/home/blood_pressure/add_blood_pressure/add_blood_pressure_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/model/blood_pressure_model.dart';

class BloodPressureController extends GetxController
    with DateTimeMixin, AlarmDialogMixin {
  late BuildContext context;
  final BloodPressureUseCase _bloodPressureUseCase;
  final AlarmUseCase _alarmUseCase;

  final RxList<BloodPressureModel> bloodPressures =
      <BloodPressureModel>[].obs;
  final RxList<Map> bloodPressureChartData = <Map>[].obs;
  final RxInt sysMin = 0.obs;
  final RxInt sysMax = 0.obs;
  final RxInt diaMin = 0.obs;
  final RxInt diaMax = 0.obs;
  final Rx<DateTime> chartMinDate = DateTime.now().obs;
  final Rx<DateTime> chartMaxDate = DateTime.now().obs;
  final Rx<BloodPressureModel> bloodPressSelected =
      BloodPressureModel().obs;
  RxBool isExporting = false.obs;

  BloodPressureController(
      this._bloodPressureUseCase, this._alarmUseCase);

  @override
  void onInit() {
    filterEndDate.value = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
        59);
    DateTime temp = filterEndDate.value
        .subtract(const Duration(days: 7));
    filterStartDate.value =
        DateTime(temp.year, temp.month, temp.day);
    filterBloodPressure();
    super.onInit();
  }

  void onSetAlarm() {
    showAddAlarm(
        context: context,
        alarmType: AlarmType.bloodPressure,
        onPressCancel: Get.back,
        onPressSave: _onSaveAlarm);
  }

  Future<void> _onSaveAlarm(AlarmModel alarm) async {
    _alarmUseCase.addAlarm(alarm);
    Get.back();
  }

  Future onAddData() async {
    final result = await showAppDialog(context, "", "",
        builder: (ctx) => const AddBloodPressureDialog());
    if (result != null && result) {
      filterBloodPressure();
    }
  }

  Future filterBloodPressure() async {
    bloodPressureChartData.clear();
    final result =
        _bloodPressureUseCase.filterBloodPressureDate(
      filterStartDate.value.millisecondsSinceEpoch,
      filterEndDate.value.millisecondsSinceEpoch,
    );
    result
        .sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    bloodPressures.value = result;
    bloodPressSelected.value = bloodPressures.last;
    DateTime? minDate;
    DateTime? maxDate;
    if (bloodPressures.isNotEmpty) {
      final bloodPresFirst = bloodPressures.first;
      sysMin.value = bloodPresFirst.systolic ?? 0;
      sysMax.value = bloodPresFirst.systolic ?? 0;
      diaMin.value = bloodPresFirst.diastolic ?? 0;
      diaMax.value = bloodPresFirst.diastolic ?? 0;
      bloodPressureChartData.add({
        "fromY": bloodPresFirst.diastolic,
        "toY": bloodPresFirst.systolic,
        "dateTime": bloodPresFirst.dateTime
      });
      final date = DateTime.fromMillisecondsSinceEpoch(
          bloodPresFirst.dateTime!);
      DateTime handleDate =
          DateTime(date.year, date.month, date.day);
      if (minDate == null || minDate.isAfter(handleDate)) {
        minDate = handleDate;
      }
      if (maxDate == null || maxDate.isBefore(handleDate)) {
        maxDate = handleDate;
      }
      final length = bloodPressures.length;
      if (length > 1) {
        for (int index = 1; index < length; index++) {
          final bloodPress = bloodPressures[index];
          if (sysMin.value > (bloodPress.systolic ?? 0)) {
            sysMin.value = bloodPress.systolic ?? 0;
          }
          if (sysMax.value < (bloodPress.systolic ?? 0)) {
            sysMax.value = bloodPress.systolic ?? 0;
          }
          if (diaMin.value > (bloodPress.diastolic ?? 0)) {
            diaMin.value = bloodPress.diastolic ?? 0;
          }
          if (diaMax.value < (bloodPress.diastolic ?? 0)) {
            diaMax.value = bloodPress.diastolic ?? 0;
          }
          bloodPressureChartData.add({
            "fromY": bloodPress.diastolic,
            "toY": bloodPress.systolic,
            "dateTime": bloodPress.dateTime
          });
          final date = DateTime.fromMillisecondsSinceEpoch(
              bloodPresFirst.dateTime!);
          DateTime handleDate =
              DateTime(date.year, date.month, date.day);
          if (minDate == null ||
              minDate.isAfter(handleDate)) {
            minDate = handleDate;
          }
          if (maxDate == null ||
              maxDate.isBefore(handleDate)) {
            maxDate = handleDate;
          }
        }
      }
    }
    if (minDate != null) {
      chartMinDate.value = minDate;
    }
    if (maxDate != null) {
      chartMaxDate.value = maxDate;
    }
  }

  void onSelectedBloodPress(int dateTime) {
    bloodPressSelected.value = bloodPressures.firstWhere(
        (element) => element.dateTime == dateTime,
        orElse: () => bloodPressures.last);
  }

  void onPressDeleteData() {
    _bloodPressureUseCase
        .deleteBloodPressure(bloodPressSelected.value.key!);
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

  Future<void> exportData() async {
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
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(
              item.dateTime ?? 0);
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
