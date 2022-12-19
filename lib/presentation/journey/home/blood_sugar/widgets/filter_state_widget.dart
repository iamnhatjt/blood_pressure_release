import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_screen.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/widgets/select_state_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/filter/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterStateWidget extends GetWidget<BloodSugarController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => FilterWidget(
        onPressed: () => showStateDialog(
            context,
            (stateCode) => controller.onSelectState(stateCode),
            controller.rxSelectedState),
        title:
            "${TranslationConstants.bloodSugarState.tr}: ${getState(controller.rxSelectedState.value)}"));
  }

  static String getState(String code) {
    switch (code) {
      case BloodSugarStateCode.duringFastingCode:
        return TranslationConstants.duringFastingCode.tr;
      case BloodSugarStateCode.beforeEatingCode:
        return TranslationConstants.beforeEatingCode.tr;
      case BloodSugarStateCode.afterEating1hCode:
        return TranslationConstants.afterEating1hCode.tr;
      case BloodSugarStateCode.afterEating2hCode:
        return TranslationConstants.afterEating2hCode.tr;
      case BloodSugarStateCode.beforeBedtimeCode:
        return TranslationConstants.beforeBedtimeCode.tr;
      case BloodSugarStateCode.beforeWorkoutCode:
        return TranslationConstants.beforeWorkoutCode.tr;
      case BloodSugarStateCode.afterWorkoutCode:
        return TranslationConstants.afterWorkoutCode.tr;
      default:
        return TranslationConstants.bloodSugarAllState.tr;
    }
  }
}
