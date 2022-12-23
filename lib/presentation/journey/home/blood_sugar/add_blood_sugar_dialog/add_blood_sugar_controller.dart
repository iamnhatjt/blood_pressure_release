import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/common/mixin/add_date_time_mixin.dart';
import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/model/blood_sugar_model.dart';
import 'package:bloodpressure/domain/usecase/blood_sugar_usecase.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/select_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../controller/app_base_controller.dart';

class AddBloodSugarController extends AppBaseController
    with DateTimeMixin, AddDateTimeMixin, SelectStateMixin {
  final BloodSugarUseCase useCase;

  RxString rxUnit = 'mg/dL'.obs;
  RxString rxInformation = TranslationConstants.bloodSugarInforNormal.tr.obs;
  RxString rxInfoCode = BloodSugarInformationCode.normalCode.obs;
  Rx<String?> rxInfoContent =
      bloodSugarInformationMgMap[BloodSugarInformationCode.lowCode].obs;
  Rx<TextEditingController> textEditController =
      TextEditingController(text: '80.0').obs;

  AddBloodSugarController(this.useCase);

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
    onChangedInformation();
  }

  void onChangedInformation() {
    double value = 0;
    Map<String, String> bloodSugarInfoMap = bloodSugarInformationMgMap;
    if (rxUnit.value == 'mg/dL') {
      value = double.parse(_convertMgToMmolL(textEditController.value.text));
    } else {
      value = double.parse(textEditController.value.text);
      bloodSugarInfoMap = bloodSugarInformationMmolMap;
    }

    if (value < 4.0) {
      rxInfoCode.value = BloodSugarInformationCode.lowCode;
    } else if (value >= 4.0 && value < 5.5) {
      rxInfoCode.value = BloodSugarInformationCode.normalCode;
    } else if (value >= 5.5 && value < 7.0) {
      rxInfoCode.value = BloodSugarInformationCode.preDiabetesCode;
    } else {
      rxInfoCode.value = BloodSugarInformationCode.diabetesCode;
    }

    rxInformation.value = bloodSugarInfoDisplayMap[rxInfoCode.value]!;
    rxInfoContent.value = bloodSugarInfoMap[rxInfoCode.value];
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
    onSelectAddTime(result);
  }

  Future<void> onSaved() async {
    rxLoadedType.value = LoadedType.start;
    BloodSugarModel model = BloodSugarModel(
      key: Uuid().v4(),
      stateCode: rxSelectedState.value,
      measure: double.parse(textEditController.value.text),
      unit: rxUnit.value,
      infoCode: rxInfoCode.value,
      dateTime: bloodPressureDate.millisecondsSinceEpoch,
    );
    await useCase.addBloodSugarData(model);
    rxLoadedType.value = LoadedType.finish;
  }

  void onPressed(Function() callback) {
    if (rxLoadedType.value == LoadedType.finish) {
      callback();
    }
  }
}
