import 'dart:math';

import 'package:bloodpressure/common/extensions/string_extension.dart';
import 'package:bloodpressure/common/mixin/add_date_time_mixin.dart';
import 'package:bloodpressure/common/util/convert_utils.dart';
import 'package:bloodpressure/domain/enum/bmi_type.dart';
import 'package:bloodpressure/domain/enum/height_unit.dart';
import 'package:bloodpressure/domain/enum/weight_unit.dart';
import 'package:bloodpressure/domain/model/bmi_model.dart';
import 'package:bloodpressure/domain/usecase/bmi_usecase.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/add_weight_bmi/widget/bmi_info_widget.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/weight_bmi_controller.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/widget/app_dialog_age_widget.dart';
import 'package:bloodpressure/presentation/widget/app_dialog_gender_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/constants/app_constant.dart';
import '../../../../../common/mixin/date_time_mixin.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../../domain/model/user_model.dart';
import '../../../../widget/app_dialog.dart';

class AddWeightBMIController extends GetxController
    with AddDateTimeMixin, DateTimeMixin {
  late BuildContext context;
  final BMIUsecase _bmiUsecase;

  Rx<WeightUnit> weightUnit = WeightUnit.kg.obs;
  Rx<HeightUnit> heightUnit = HeightUnit.cm.obs;
  Rx<BMIType> bmiType = BMIType.normal.obs;
  final TextEditingController cmController =
      TextEditingController();
  final TextEditingController weightController =
      TextEditingController();
  final TextEditingController ftController =
      TextEditingController();
  final TextEditingController inchController =
      TextEditingController();
  final _appController = Get.find<AppController>();
  Rx<DateTime> bmiDate = DateTime.now().obs;
  RxBool isLoading = false.obs;
  RxInt bmi = 0.obs;
  final _weightBMIController =
      Get.find<WeightBMIController>();

  AddWeightBMIController(this._bmiUsecase);

  @override
  void onInit() {
    updateDateTimeString(DateTime.now());
    weightController.text = '65.00';
    cmController.text = "170.0";
    ftController.text = '5\'';
    inchController.text = '7\"';
    caculateBMI();
    weightUnit.value =
        _weightBMIController.weightUnit.value;
    heightUnit.value =
        _weightBMIController.heightUnit.value;
    super.onInit();
  }

  void onSelectBMIDate() async {
    final result = await onSelectDate(
        context: context,
        initialDate: bloodPressureDate,
        primaryColor: AppColor.green);
    onSelectAddDate(result);
  }

  void onSelectBMITime() async {
    final result = await onSelectTime(
      context: context,
      initialTime: TimeOfDay(
          hour: bloodPressureDate.hour,
          minute: bloodPressureDate.minute),
    );
    onSelectAddTime(result);
  }

  void onSelectWeightUnit() {
    if (weightUnit.value == WeightUnit.kg) {
      weightUnit.value = WeightUnit.lb;
    } else {
      weightUnit.value = WeightUnit.kg;
    }
  }

  void onSelectHeightUnit() {
    if (heightUnit.value == HeightUnit.cm) {
      heightUnit.value = HeightUnit.ftIn;
    } else {
      heightUnit.value = HeightUnit.cm;
    }
  }

  void onShowInfo() {
    showAppDialog(
      context,
      '',
      '',
      fullContentWidget: const BMIINfoWidget(),
    );
  }

  void onPressedAge() {
    int initialAge =
        _appController.currentUser.value.age ?? 30;
    initialAge = initialAge < 2
        ? 2
        : initialAge > 110
            ? 110
            : initialAge;
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogAgeWidget(
        initialAge: initialAge,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController.updateUser(UserModel(
              age: value,
              genderId: _appController
                      .currentUser.value.genderId ??
                  '0'));
        },
      ),
    );
  }

  void onPressGender() {
    Map? initialGender = AppConstant.listGender
        .firstWhereOrNull((element) =>
            element['id'] ==
            (_appController.currentUser.value.genderId ??
                '0'));
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogGenderWidget(
        initialGender: initialGender,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController.updateUser(UserModel(
              age: _appController.currentUser.value.age ??
                  30,
              genderId: value['id'] ?? '0'));
        },
      ),
    );
  }

  double _getWeight() {
    final weight = weightController.text;
    if (weight.isEmpty) {
      weightController.text = '0.0';
    }
    if (weightUnit.value == WeightUnit.kg) {
      return double.parse(weightController.text.isNotEmpty
          ? weightController.text
          : '0.0');
    } else {
      return ConvertUtils.convertLbToKg(
        double.parse(weightController.text.isNotEmpty
            ? weightController.text
            : '0.0'),
      );
    }
  }

  double _getHeight() {
    if (heightUnit.value == HeightUnit.cm) {
      if (cmController.text.isEmpty) {
        cmController.text = '0.0';
      }
      return ConvertUtils.convertCmToM(
        double.parse(cmController.text.isNotEmpty
            ? cmController.text
            : '0.0'),
      );
    } else {
      if (ftController.text.isEmpty) {
        ftController.text = '0\'';
      }
      if (inchController.text.isEmpty) {
        inchController.text = '0\"';
      }
      return ConvertUtils.convertFtAndInchToM(
          ftController.text.isNotEmpty
              ? ftController.text.toInt
              : 0,
          inchController.text.isNotEmpty
              ? inchController.text.toInt
              : 0);
    }
  }

  void caculateBMI() {
    double weight = _getWeight();
    double height = _getHeight();

    if (weight != 0 && height != 0) {
      bmi.value = (weight / pow(height, 2)).round();
    }
    bmiType.value =
        BMITypeEnum.getBMITypeByValue(bmi.value);
  }

  Future<void> saveBMI() async {
    isLoading.value = true;
    _weightBMIController.weightUnit.value =
        weightUnit.value;
    _weightBMIController.heightUnit.value =
        heightUnit.value;
    _setHeightUnit();
    _setWeightUnit();
    Map? initialGender = AppConstant.listGender
        .firstWhereOrNull((element) =>
            element['id'] ==
            (_appController.currentUser.value.genderId ??
                '0'));
    final bmiDateTime = DateTime(
        bloodPressureDate.year,
        bloodPressureDate.month,
        bloodPressureDate.day,
        bloodPressureDate.hour,
        bloodPressureDate.minute);
    final bmiModel = BMIModel(
      key: bmiDateTime.toIso8601String(),
      weight: _getWeight(),
      weightUnit: weightUnit.value.id,
      type: bmiType.value.id,
      dateTime: bmiDateTime.millisecondsSinceEpoch,
      age: _appController.currentUser.value.age,
      height: _getHeight(),
      heightUnit: heightUnit.value.id,
      gender: initialGender!['id'] ?? '0',
      bmi: bmi.value,
    );
    await _bmiUsecase.saveBMI(bmiModel);
    isLoading.value = false;
    Get.back(result: true);
  }

  Future<void> _setWeightUnit() async {
    await _bmiUsecase.setWeightUnitId(weightUnit.value.id);
  }

  Future<void> _setHeightUnit() async {
    await _bmiUsecase.setHeightUnitId(heightUnit.value.id);
  }
}
