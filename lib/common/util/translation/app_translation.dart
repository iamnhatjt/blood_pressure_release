import 'dart:math';

import 'package:bloodpressure/common/util/translation/vi_strings.dart';
import 'package:get/get.dart';

import 'en_strings.dart';

class AppTranslation extends Translations {
  static const String localeCodeVi = 'vi_VN';
  static const String localeCodeEn = 'en_US';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeVi: viStrings,
        localeCodeEn: enStrings,
      };

  static String getString(String key) {
    Map<String, String> selectedLanguage =
        Get.locale.toString() == localeCodeEn
            ? enStrings
            : viStrings;
    String text = key;
    if (selectedLanguage.containsKey(key) &&
        selectedLanguage[key] != null) {
      text = selectedLanguage[key] ?? key;
    }
    return text;
  }
}

class TranslationConstants {
  static String unknownError = 'unknownError';
  static String notice = 'notice';
  static String close = 'close';
  static String continues = 'continues';
  static String setting = 'setting';
  static String cancel = 'cancel';
  static String noNetTitle = 'noNetTitle';
  static String noNetContent = 'noNetContent';
  static String retry = 'retry';
  static String allow = 'allow';
  static String removeAds = 'removeAds';
  static String privacy = 'privacy';
  static String termOfCondition = 'termOfCondition';
  static String contactUs = 'contactUs';
  static String shareApp = 'shareApp';
  static String language = 'language';
  static String chooseLanguage = 'chooseLanguage';
  static String restore = 'restore';
  static String moreApp = 'moreApp';
  static String errorLoadAds = 'errorLoadAds';
  static String shareMessage = 'shareMessage';
  static String bloodHealth = 'bloodHealth';
  static String heartRate = 'heartRate';
  static String bloodPressure = 'bloodPressure';
  static String bloodSugar = 'bloodSugar';
  static String weightAndBMI = 'weightAndBMI';
  static String foodScanner = 'foodScanner';
  static String scanFood = "scanFood";
  static String home = 'home';
  static String insights = 'insights';
  static String alarm = 'alarm';
  static String export = 'export';
  static String average = 'average';
  static String min = 'min';
  static String max = 'max';
  static String measureNow = 'measureNow';
  static String setAlarm = 'setAlarm';
  static String addData = 'addData';
  static String stop = 'stop';
  static String add = 'add';
  static String measuring = 'measuring';
  static String placeYourFinger = 'placeYourFinger';
  static String measureNowOrAdd = 'measureNowOrAdd';
  static String measure = 'measure';
  static String permissionCameraDenied01 =
      'permissionCameraDenied01';
  static String permissionCameraSetting01 =
      'permissionCameraSetting01';
  static String permissionCameraDenied02 =
      'permissionCameraDenied02';
  static String permissionCameraSetting02 =
      'permissionCameraSetting02';
  static String restingHeartRate = 'restingHeartRate';
  static String slow = 'slow';
  static String normal = 'normal';
  static String fast = 'fast';
  static String age = 'age';
  static String choseYourAge = 'choseYourAge';
  static String choseYourGender = 'choseYourGender';
  static String save = 'save';
  static String rhSlowMessage = 'rhSlowMessage';
  static String rhNormalMessage = 'rhNormalMessage';
  static String rhFastMessage = 'rhFastMessage';
  static String addSuccess = 'addSuccess';
  static String date = 'date';
  static String time = 'time';
  static String gender = 'gender';
  static String delete = 'delete';
  static String deleteData = 'deleteData';
  static String deleteDataConfirm = 'deleteDataConfirm';
  static String eng = "english";
  static String vi = "vietnamese";
  static String addYourRecordToSeeStatistics =
      "addYourRecordToSeeStatisitcs";
  static String systolic = "systolic";
  static String diastolic = "diastolic";
  static const String hypotension = "hypotension";
  static const String elevated = "elevated";
  static const String hypertensionStage1 =
      "hypertensionStage1";
  static const String hypertensionStage2 =
      "hypertensionStage2";
  static const String hypertensionCrisis =
      "hypertensionCrisis";
  static const String systolicRangeOrDiastolicRange =
      "systolicRangeOrDiastolicRange";
  static const String ok = "ok";
  static const String pulse = "pulse";
  static const String sysAndDIA = "sysAndDIA";
  static const String hypotensionMessage =
      "hypotensionMessage";
  static const String normalMessage = "normalMessage";
  static const String elevatedMessage = "elevatedMessage";
  static const String hypertensionStage1Message =
      "hypertensionStage1Message";
  static const String hypertensionStage2Message =
      "hypertensionStage2Message";
  static const String hypertensionCrisisMessage =
      "hypertensionCrisisMessage";
  static String edit = "edit";
  static String forSomething = "for";
  static String type = 'type';
  // Blood Sugar
  static String bloodSugarState = "bloodSugarState";
  static String bloodSugarAllState = "bloodSugarAllState";
  static String bloodSugarDefaultState =
      "bloodSugarDefaultState";
  static String duringFastingCode = "duringFastingCode";
  static String beforeEatingCode = "beforeEatingCode";
  static String afterEating1hCode = "afterEating1hCode";
  static String afterEating2hCode = "afterEating2hCode";
  static String beforeBedtimeCode = "beforeBedtimeCode";
  static String beforeWorkoutCode = "beforeWorkoutCode";
  static String afterWorkoutCode = "afterWorkoutCode";
  static String bloodSugarInforLow = "bloodSugarInforLow";
  static String bloodSugarInforNormal =
      "bloodSugarInforNormal";
  static String bloodSugarInforPreDiabetes =
      "bloodSugarInforPreDiabetes";
  static String bloodSugarInforDiabetes =
      "bloodSugarInforDiabetes";
  static String bloodSugarInfo = "bloodSugarInfo";

  static String trackYourHealth = "trackYourHealth";
  static String checkYourHeartRate = "checkYourHeartRate";
  static String checkYourWeightAndBMI =
      "checkYourWeightAndBMI";
  static String checkYourBloodSugar = "checkYourBloodSugar";
  static String checkYourBloodPressure =
      "checkYourBloodPressure";
  static String requestPermission = "requestPermission";
  static String noInformation = "noInformation";
  static String scanResult = "scanResult";
  static String qrCode = "qrCode";
  static String barcode = "barcode";


  static final List<String> _bloodPressureNotiMsgs =
      List<String>.generate(
          10, (index) => "bloodPressureNoti$index",
          growable: false);
  static final List<String> _heartRateNotiMsgs =
      List<String>.generate(
          10, (index) => "heartRateNoti$index",
          growable: false);
  static final List<String> _bloodSugarNotiMsgs =
      List<String>.generate(
          10, (index) => "bloodSugarNoti$index",
          growable: false);
  static final List<String> _weightAndBMINotiMsgs =
      List<String>.generate(
          10, (index) => "bloodSugarNoti$index",
          growable: false);




  static String get bloodPressureNotiMsg {
    final int randIndex =
        Random(DateTime.now().microsecondsSinceEpoch)
            .nextInt(_bloodPressureNotiMsgs.length - 1);
    return _bloodPressureNotiMsgs[randIndex];
  }

  static String get heartRateNotiMsg {
    final int randIndex =
        Random(DateTime.now().microsecondsSinceEpoch)
            .nextInt(_bloodPressureNotiMsgs.length - 1);
    return _heartRateNotiMsgs[randIndex];
  }

  static String get bloodSugarNotiMsg {
    final int randIndex =
        Random(DateTime.now().microsecondsSinceEpoch)
            .nextInt(_bloodPressureNotiMsgs.length - 1);
    return _bloodSugarNotiMsgs[randIndex];
  }

  static String get weightAndBMINotiMsg {
    final int randIndex =
        Random(DateTime.now().microsecondsSinceEpoch)
            .nextInt(_bloodPressureNotiMsgs.length - 1);
    return _weightAndBMINotiMsgs[randIndex];
  }

  static String weight = "weight";
  static String height = "height";
  static String verySeverelyUnderweight =
      "verySeverelyUnderweight";
  static String severelyUnderweight = "severelyUnderweight";
  static String underweight = "underweight";
  static String overweight = "overweight";
  static String obeseClassI = "obeseClassI";
  static String obeseClassII = "obeseClassII";
  static String obeseClassIII = "obeseClassIII";
  static String bmiMessage = "bmiMessage";
  static String bmi = "bmi";
}
