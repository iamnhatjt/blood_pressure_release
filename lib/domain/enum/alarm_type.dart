import 'package:bloodpressure/common/config/hive_config/hive_constants.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
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

  String get trNotiDes {
    switch (this) {
      case AlarmType.heartRate:
        return TranslationConstants.checkYourHeartRate.tr;
      case AlarmType.bloodPressure:
        return TranslationConstants.checkYourBloodPressure.tr;
      case AlarmType.bloodSugar:
        return TranslationConstants.checkYourBloodSugar.tr;
      case AlarmType.weightAndBMI:
        return TranslationConstants.checkYourWeightAndBMI.tr;
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

  String get androidIcon {
    switch (this) {
      case AlarmType.heartRate:
        return "@mipmap/ic_heart_rate";
      case AlarmType.bloodPressure:
        return "@mipmap/ic_blood_pressure";
      case AlarmType.bloodSugar:
        return "@mipmap/ic_blood_sugar";
      case AlarmType.weightAndBMI:
        return "@mipmap/ic_weight_and_bmi";
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