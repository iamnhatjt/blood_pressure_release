import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AlarmDialogController extends GetxController {
  static final analytics = FirebaseAnalytics.instance;
  static final AlarmModel defaultModel = AlarmModel(
      id: const Uuid().v4(),
      type: AlarmType.heartRate,
      time: DateTime.now(),
      alarmDays: List<bool>.generate(7, (index) => false));

  Rx<AlarmModel> alarmModel = defaultModel
      .copyWith(id: Uuid().v4())
      .obs;
  RxBool isValid = false.obs;

  @override
  void onInit() {
    validate();
    super.onInit();
  }

  void onSelectedWeekDaysChanged(List<bool> days) {
    alarmModel.value = alarmModel.value.copyWith(alarmDays: days);
    validate();
  }

  void onTimeChange(DateTime value) {
    alarmModel.value = alarmModel.value.copyWith(time: value);
    validate();
  }

  void validate() {
    final days = alarmModel.value.alarmDays!;
    final length = days.where((element) => element).length;
    if (length == 0) {
      isValid.value = false;
    } else {
      isValid.value = true;
    }
  }

  void reset() {
    alarmModel.value = defaultModel.copyWith(time: DateTime.now(), id: const Uuid().v4());
    validate();
  }

  void sendAnalyticsEvent(String analyticsEvent) {
    analytics.logEvent(name: analyticsEvent);
    debugPrint("Logged '$analyticsEvent' at ${DateTime.now()}");
  }
}
