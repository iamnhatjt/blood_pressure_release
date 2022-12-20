import 'dart:ui';

import 'package:intl/intl.dart';

class AppConstant {
  static final availableLocales = [const Locale('vi', 'VN'), const Locale('en', 'US')];
  static final dateTimeFormatCommon = DateFormat('HH:mm dd/MM/yyyy');
  static const int minHeartRate = 40;
  static const int maxHeartRate = 220;
  static final List<Map> listGender = [
    {'id': '0', 'nameEN': 'Male', 'nameVN': 'Nam'},
    {'id': '1', 'nameEN': 'Female', 'nameVN': 'Nữ'},
    {'id': '2', 'nameEN': 'Other', 'nameVN': 'Khác'},
  ];
}

class BloodSugarStateCode {
  static const String defaultCode = "DEFAULT";
  static const String duringFastingCode = "DURING_FASTING";
  static const String beforeEatingCode = "BEFORE_EATING";
  static const String afterEating1hCode = "AFTER_EATING_1H";
  static const String afterEating2hCode = "AFTER_EATING_2H";
  static const String beforeBedtimeCode = "BEFORE_BEDTIME";
  static const String beforeWorkoutCode = "BEFORE_WORKOUT";
  static const String afterWorkoutCode = "AFTER_WORKOUT";
}

final List<String> bloodSugarStateCodeList = [
  BloodSugarStateCode.defaultCode,
  BloodSugarStateCode.duringFastingCode,
  BloodSugarStateCode.beforeEatingCode,
  BloodSugarStateCode.afterEating1hCode,
  BloodSugarStateCode.afterEating2hCode,
  BloodSugarStateCode.beforeBedtimeCode,
  BloodSugarStateCode.beforeWorkoutCode,
  BloodSugarStateCode.afterWorkoutCode,
];

class BloodSugarInformationCode {
  static const String lowCode = "LOW";
  static const String normalCode = "NORMAL";
  static const String preDiabetesCode = "PRE-DIABETES";
  static const String diabetesCode = "DIABETES";
}

final List<String> bloodSugarInformationCodeList = [
  BloodSugarInformationCode.lowCode,
  BloodSugarInformationCode.normalCode,
  BloodSugarInformationCode.preDiabetesCode,
  BloodSugarInformationCode.diabetesCode,
];

final Map<String, String> bloodSugarInformationMmolMap = {
  BloodSugarInformationCode.lowCode: "<4.0",
  BloodSugarInformationCode.normalCode: "4.0 - 5.5",
  BloodSugarInformationCode.preDiabetesCode: "5.5 - 7.0",
  BloodSugarInformationCode.diabetesCode: ">7.0",
};

final Map<String, String> bloodSugarInformationMgMap = {
  BloodSugarInformationCode.lowCode: "<72",
  BloodSugarInformationCode.normalCode: "72 - 99",
  BloodSugarInformationCode.preDiabetesCode: "99 - 126",
  BloodSugarInformationCode.diabetesCode: ">126",
};
