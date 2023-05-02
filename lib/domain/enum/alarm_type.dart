import 'dart:math';

import 'package:bloodpressure/common/config/hive_config/hive_constants.dart';
import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';


part 'alarm_type.g.dart';

class AlarmTypeEnum {
  static AlarmType getBloodPressureTypeById(int? id) {
    if (id == null) {
      return AlarmType.heartRate;
    } else {
      return AlarmType.values.firstWhere((type) => type.id == id,
          orElse: () => AlarmType.heartRate);
    }
  }
}

@HiveType(typeId: HiveTypeConstants.alarmType)
enum AlarmType {
  @HiveField(0)
  heartRate,
  @HiveField(1)
  bloodPressure,
  @HiveField(2)
  bloodSugar,
  @HiveField(3)
  weightAndBMI,
}

extension AlarmTypeExtension on AlarmType {
  Color get color {
    switch (this) {
      case AlarmType.heartRate:
        return AppColor.red;
      case AlarmType.bloodPressure:
        return AppColor.primaryColor;
      case AlarmType.bloodSugar:
        return AppColor.violet;
      case AlarmType.weightAndBMI:
        return AppColor.green;
    }
  }

  String get tr {
    switch (this) {
      case AlarmType.heartRate:
          return TranslationConstants.heartRate.tr;
      case AlarmType.bloodPressure:
          return TranslationConstants.bloodPressure.tr;
      case AlarmType.bloodSugar:
          return TranslationConstants.bloodSugar.tr;
      case AlarmType.weightAndBMI:
          return TranslationConstants.weightAndBMI.tr;
    }
  }

  String getAnalyticsEventName(String route) {
    switch (this) {
      case AlarmType.heartRate:
        if (route.contains(AppRoute.heartBeatScreen)) {
          return AppLogEvent.setAlarmHeartRateSet;
        }
        return AppLogEvent.alarmHeartRateSet;
      case AlarmType.bloodPressure:
        if (route.contains(AppRoute.bloodPressureScreen)) {
          return AppLogEvent.setAlarmBloodPressure;
        }
        return AppLogEvent.alarmBloodPressure;
      case AlarmType.bloodSugar:
        if (route.contains(AppRoute.bloodSugar)) {
          return AppLogEvent.setAlarmBloodSugar;
        }
        return AppLogEvent.alarmBloodSugar;
      case AlarmType.weightAndBMI:
        if (route.contains(AppRoute.weightBMI)) {
          return AppLogEvent.setAlarmWeightBMI;
        }
        return AppLogEvent.alarmWeightBMI;
    }
  }

  String get trNotiDes {
    final int randomIndex = Random(DateTime.now().microsecondsSinceEpoch).nextInt(9);
    switch (this) {
      case AlarmType.heartRate:
        return TranslationConstants.heartRateNotiMsgs[randomIndex].tr;
      case AlarmType.bloodPressure:
        return TranslationConstants.bloodPressureNotiMsgs[randomIndex].tr;
      case AlarmType.bloodSugar:
        return TranslationConstants.bloodSugarNotiMsgs[randomIndex].tr;
      case AlarmType.weightAndBMI:
        return TranslationConstants.weightAndBMINotiMsgs[randomIndex].tr;
    }
  }

  String get notificationRoute {
    switch (this) {
      case AlarmType.heartRate:
        return AppRoute.heartBeatScreen;
      case AlarmType.bloodPressure:
        return AppRoute.bloodPressureScreen;
      case AlarmType.bloodSugar:
        return AppRoute.bloodSugar;
      case AlarmType.weightAndBMI:
        return AppRoute.weightBMI;
    }
  }

  static AlarmType fromString(String str) {
    try {
      return AlarmType.values.where((element) => element.toString() == "AlarmType.$str").first;
    } on StateError catch (_) {
      return AlarmType.heartRate;
    }
  }

  int get id {
    switch (this) {
      case AlarmType.heartRate:
        return 0;
      case AlarmType.bloodPressure:
        return 1;
      case AlarmType.bloodSugar:
        return 2;
      case AlarmType.weightAndBMI:
        return 3;
    }
  }


  String get icon {
    switch(this) {
      case AlarmType.heartRate:
        return AppImage.ic_heart_rate;
      case AlarmType.bloodPressure:
        return AppImage.ic_blood_pressure;
      case AlarmType.bloodSugar:
        return AppImage.ic_blood_sugar;
      case AlarmType.weightAndBMI:
        return AppImage.ic_weight_and_bmi;
    }
  }
}