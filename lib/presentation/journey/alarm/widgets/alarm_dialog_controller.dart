import 'package:bloodpressure/common/extensions/string_extension.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
//
// class AlarmDialogController extends GetxController {
//   static final analytics = FirebaseAnalytics.instance;
//   static final AlarmModel defaultModel = AlarmModel(
//       id: const Uuid().v4(),
//       type: AlarmType.heartRate,
//       time: DateTime.now(),
//       alarmDays: List<bool>.generate(7, (index) => false));
//
//   Rx<AlarmModel> alarmModel = defaultModel
//       .copyWith(id: Uuid().v4())
//       .obs;
//   RxBool isValid = false.obs;
//
//   @override
//   void onInit() {
//     validate();
//     super.onInit();
//   }
//
//   void onSelectedWeekDaysChanged(List<bool> days) {
//     alarmModel.value = alarmModel.value.copyWith(alarmDays: days);
//     validate();
//   }
//
//   void onTimeChange(DateTime value) {
//     alarmModel.value = alarmModel.value.copyWith(time: value);
//     validate();
//   }
//
//   void validate() {
//     final days = alarmModel.value.alarmDays!;
//     final length = days.where((element) => element).length;
//     if (length == 0) {
//       isValid.value = false;
//     } else {
//       isValid.value = true;
//     }
//   }
//
//   void reset() {
//     alarmModel.value = defaultModel.copyWith(time: DateTime.now(), id: const Uuid().v4());
//     validate();
//   }
//
//   void sendAnalyticsEvent(String analyticsEvent) {
//     analytics.logEvent(name: analyticsEvent);
//     debugPrint("Logged '$analyticsEvent' at ${DateTime.now()}");
//   }
// }


formatTime(DateTime time) {
  int hour = time.hour;
  int minute = time.minute;

  return "${hour >= 10 ? hour : '0$hour'}:${minute >= 10 ? minute : '0$minute'}";
}


class AlarmDialogController extends GetxController {

  RxBool isAM = DateFormat('h').format(DateTime.now()).toInt > 12 ? true.obs : false.obs;
  RxString timeDisplay = "".obs;

  void formatTimeDisplayAMOrPMWithSet(){
    isAM.value = DateFormat('h').format(DateTime.now()).toInt > 12 ? true : false;
  }

  void formatTimeDisplayAMOrPMWithEdit(){
    print('timeDisplay.value : ${alarmModel.value.time}');
    isAM.value = DateFormat('HH').format(alarmModel.value.time!).toInt < 12 ? true: false;
  }

  // static final analytics = FirebaseAnalytics.instance;
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
      DateTime temp = alarmModel.value.time!.subtract(const Duration(hours: 12));

      timeDisplay.value = formatTime(temp);

    } else {
      isValid.value = true;
      timeDisplay.value = formatTime(alarmModel.value.time!);

    }
  }


  void onPressAdd() {
    debugPrint("Add 1 minutes");

    alarmModel.value =
        alarmModel.value.copyWith(time: alarmModel.value.time!.add(const Duration(minutes: 1)));

    timeDisplay.value = formatTime(alarmModel.value.time!);
  }

  void onPressSub() {
    debugPrint("Sub 1 minutes");

    alarmModel.value = alarmModel.value
        .copyWith(time: alarmModel.value.time!.subtract(const Duration(minutes: 1)));

    timeDisplay.value = formatTime(alarmModel.value.time!);
  }



  void onPressAM() {

    debugPrint("On press AM");
    isAM.value = true;

    if (alarmModel.value.time!.hour > 12) {
      alarmModel.value = alarmModel.value
          .copyWith(time: alarmModel.value.time!.subtract(const Duration(hours: 12)));
    }

    timeDisplay.value = formatTime(alarmModel.value.time!);
    print(timeDisplay.value);

  }

  void onPressPM() {

    debugPrint("On press PM");
    isAM.value = false;

    if (alarmModel.value.time!.hour < 12) {
      alarmModel.value =
          alarmModel.value.copyWith(time: alarmModel.value.time!.add(const Duration(hours: 12)));
    }

    timeDisplay.value = formatTime(alarmModel.value.time!);
    print(timeDisplay.value);

  }

  void reset() {
    alarmModel.value = defaultModel.copyWith(time: DateTime.now(), id: const Uuid().v4());
    validate();
  }

  void sendAnalyticsEvent(String analyticsEvent) {
    // analytics.logEvent(name: analyticsEvent);
    debugPrint("Logged '$analyticsEvent' at ${DateTime.now()}");
  }
}
