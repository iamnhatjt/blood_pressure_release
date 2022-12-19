import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/mixin/add_date_time_mixin.dart';
import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/select_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/app_base_controller.dart';

class AddBloodSugarController extends AppBaseController
    with DateTimeMixin, AddDateTimeMixin, SelectStateMixin {
  RxString rxUnit = 'mg/dL'.obs;
  RxString rxInformation = 'Normal'.obs;
  Rx<TextEditingController> textEditController =
      TextEditingController(text: '80.0').obs;

  @override
  void onInit() {
    updateDateTimeString(bloodPressureDate);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    onChangedInformation();
  }

  String _convertMmolLtoMgDl(String value) {
    double mmollValue = double.parse(value);
    return (mmollValue * 18).ceilToDouble().toString();
  }

  String _convertMgToMmolL(String value) {
    double mgValue = double.parse(value);
    return (((mgValue / 18) * 10).ceil() / 10).toString();
  }

  void onChangedUnit() {
    String value = textEditController.value.text;
    if (rxUnit.value == 'mg/dL') {
      rxUnit.value = 'mmol/l';
      textEditController.value.text = _convertMgToMmolL(value);
    } else {
      rxUnit.value = 'mg/dL';
      textEditController.value.text = _convertMmolLtoMgDl(value);
    }
  }

  void onChangedInformation() {
    double value = 0;
    if (rxUnit.value == 'mg/dL') {
      value = double.parse(_convertMgToMmolL(textEditController.value.text));
    }
    if (value < 4.0) {
      rxInformation.value = TranslationConstants.bloodSugarInforLow.tr;
    } else if (value >= 4.0 && value < 5.5) {
      rxInformation.value = TranslationConstants.bloodSugarInforNormal.tr;
    } else if (value >= 5.5 && value < 7.0) {
      rxInformation.value = TranslationConstants.bloodSugarInforPreDiabetes.tr;
    } else {
      rxInformation.value = TranslationConstants.bloodSugarInforDiabetes.tr;
    }
  }

  Future<void> onSelectBloodSugarDate() async {
    final result =
        await onSelectDate(context: context, initialDate: bloodPressureDate);
    onSelectAddDate(result);
  }

  Future<void> onSelectBloodSugarTime() async {
    final dateTime = bloodPressureDate;
    final result = await onSelectTime(
      context: context,
      initialTime: TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      ),
    );
  }
}
