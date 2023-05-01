import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/common/extensions/date_time_extensions.dart';
import 'package:bloodpressure/common/mixin/add_date_time_mixin.dart';
import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/common/util/convert_utils.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/model/blood_sugar_model.dart';
import 'package:bloodpressure/domain/usecase/blood_sugar_usecase.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/select_state_mixin.dart';
import 'package:bloodpressure/presentation/widget/snack_bar/app_snack_bar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../../domain/model/user_model.dart';
import '../../../../controller/app_base_controller.dart';
import '../../../../controller/app_controller.dart';
import '../../../../widget/app_dialog.dart';
import '../../../../widget/app_dialog_age_widget.dart';
import '../../../../widget/app_dialog_gender_widget.dart';
import '../blood_sugar_controller.dart';

class AddBloodSugarController extends AppBaseController with DateTimeMixin, AddDateTimeMixin, SelectStateMixin {
  final BloodSugarUseCase useCase;

  RxString rxUnit = BloodSugarUnit.mgdLUnit.obs;
  RxString rxInformation = TranslationConstants.bloodSugarInforNormal.tr.obs;
  RxString rxInfoCode = BloodSugarInformationCode.normalCode.obs;
  Rx<String?> rxInfoContent = bloodSugarInformationMgMap[BloodSugarInformationCode.lowCode].obs;
  Rx<TextEditingController> textEditController = TextEditingController(text: '80.0').obs;

  RxMap gender = AppConstant.listGender
      .firstWhere((element) => element['id'] == Get.find<AppController>().currentUser.value.genderId,
      orElse: () => AppConstant.listGender[0])
      .obs;
  RxInt age = (Get.find<AppController>().currentUser.value.age ?? 30).obs;

  AddBloodSugarController(this.useCase);

  final analytics = FirebaseAnalytics.instance;

  void onInitialData({BloodSugarModel? model}) {
    if (!isNullEmpty(model)) {
      rxUnit.value = model!.unit ?? BloodSugarUnit.mgdLUnit;
      rxInfoCode.value = model.infoCode ?? BloodSugarInformationCode.normalCode;
      rxInformation.value = bloodSugarInfoDisplayMap[rxInfoCode.value]!;
      rxInfoContent.value = bloodSugarInformationMgMap[rxInfoCode.value];
      textEditController.value.text = !isNullEmptyFalseOrZero(model.measure) ? model.measure.toString() : '80.0';
      bloodPressureDate = DateTime.fromMillisecondsSinceEpoch(model.dateTime!);
    } else {
      rxUnit.value = BloodSugarUnit.mgdLUnit;
      rxInfoCode.value = BloodSugarInformationCode.normalCode;
      rxInformation.value = TranslationConstants.bloodSugarInforNormal.tr;
      rxInfoContent.value = bloodSugarInformationMgMap[BloodSugarInformationCode.lowCode];
      textEditController.value = TextEditingController(text: '80.0');
      bloodPressureDate = DateTime.now();
    }
    updateDateTimeString(bloodPressureDate);
  }

  @override
  void onInit() {
    onInitialData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    onChangedInformation();
  }

  void onChangedUnit() {
    String value = textEditController.value.text;
    if (rxUnit.value == BloodSugarUnit.mgdLUnit) {
      rxUnit.value = BloodSugarUnit.mmollUnit;
      textEditController.value.text = ConvertUtils.convertMg2MmolL(value).toString();
    } else {
      rxUnit.value = BloodSugarUnit.mgdLUnit;
      textEditController.value.text = ConvertUtils.convertMmolL2MgDl(value).toString();
    }
    onChangedInformation();
  }

  void onChangedInformation() {
    double value = 0;
    Map<String, String> bloodSugarInfoMap = bloodSugarInformationMgMap;
    if (rxUnit.value == BloodSugarUnit.mgdLUnit) {
      value = ConvertUtils.convertMg2MmolL(textEditController.value.text);
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
    final result = await onSelectDate(context: context, initialDate: bloodPressureDate);
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

  Future<void> onSaved({BloodSugarModel? model}) async {
    analytics.logEvent(name: AppLogEvent.addDataBloodSugar);
    debugPrint("Logged ${AppLogEvent.addDataBloodSugar} at ${DateTime.now()}");
    rxLoadedType.value = LoadedType.start;
    onChangedInformation();
    DateTime now = DateTime.now();
    DateTime dateTime = bloodPressureDate;
    dateTime.update(second: now.second, millisecond: now.millisecond);
    if (!isNullEmpty(model)) {
      model!.stateCode = rxSelectedState.value;
      model.measure = double.parse(textEditController.value.text);
      model.unit = rxUnit.value;
      model.infoCode = rxInfoCode.value;
      model.dateTime = dateTime.millisecondsSinceEpoch;
      await useCase.saveBloodSugarData(model);
      showTopSnackBar(context, message: TranslationConstants.editDataSuccess.tr, type: SnackBarType.done);
    } else {
      model = BloodSugarModel(
        key: const Uuid().v4(),
        stateCode: rxSelectedState.value,
        measure: double.parse(textEditController.value.text),
        unit: rxUnit.value,
        infoCode: rxInfoCode.value,
        dateTime: dateTime.millisecondsSinceEpoch,
      );
      await useCase.saveBloodSugarData(model);
      showTopSnackBar(context, message: TranslationConstants.addDataSuccess.tr, type: SnackBarType.done);
    }

    rxLoadedType.value = LoadedType.finish;
  }

  void onPressed(Function() callback) {
    if (rxLoadedType.value == LoadedType.finish) {
      callback();
    }
  }


  void onPressedAge() {

    age.value = age.value < 2
        ? 2
        : age.value > 110
        ? 110
        : age.value;
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogAgeWidget(
        initialAge: age.value,
        onPressCancel:(){
          Get.back();
        },
        onPressSave: (value) {
          Get.back();

          _appController.updateUser(UserModel(age: value, genderId: _appController.currentUser.value.genderId ?? '0'));
          age.value = value;
        },
      ),
    );
  }

  final _appController = Get.find<AppController>();
  void onPressGender() {
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogGenderWidget(
        initialGender: gender,
        onPressCancel: (){
          Get.back();
        },
        onPressSave: (value) {
          Get.back();
          if (value == gender.value) {
            return;
          }
          _appController
              .updateUser(UserModel(age: _appController.currentUser.value.age ?? 30, genderId: value['id'] ?? '0'));
          gender.value = value;
        },
      ),
    );
  }

}
