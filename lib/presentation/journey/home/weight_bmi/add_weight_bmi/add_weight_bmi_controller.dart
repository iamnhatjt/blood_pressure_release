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
import 'package:bloodpressure/presentation/widget/snack_bar/app_snack_bar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/constants/app_constant.dart';
import '../../../../../common/constants/app_route.dart';
import '../../../../../common/constants/enums.dart';
import '../../../../../common/mixin/date_time_mixin.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../../domain/model/user_model.dart';
import '../../../../widget/app_dialog.dart';

class AddWeightBMIController extends GetxController with AddDateTimeMixin, DateTimeMixin {
  late BuildContext context;
  final BMIUsecase _bmiUsecase;
  final analytics = FirebaseAnalytics.instance;

  Rx<WeightUnit> weightUnit = WeightUnit.kg.obs;
  Rx<HeightUnit> heightUnit = HeightUnit.cm.obs;
  Rx<BMIType> bmiType = BMIType.normal.obs;
  final TextEditingController cmController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ftController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final _appController = Get.find<AppController>();
  Rx<DateTime> bmiDate = DateTime.now().obs;
  RxBool isLoading = false.obs;
  RxInt bmi = 0.obs;
  final _weightBMIController = Get.find<WeightBMIController>();
  BMIModel currentBMI = BMIModel();
  RxInt age = (Get.find<AppController>().currentUser.value.age ?? 30).obs;
  RxMap gender = AppConstant.listGender
      .firstWhere((element) => element['id'] == Get.find<AppController>().currentUser.value.genderId,
          orElse: () => AppConstant.listGender[0])
      .obs;

  AddWeightBMIController(this._bmiUsecase);

  @override
  void onInit() {
    updateDateTimeString(DateTime.now());
    weightController.text = '65.00';
    cmController.text = "170.0";
    ftController.text = '5\'';
    inchController.text = '7\'';
    caculateBMI();
    weightUnit.value = _weightBMIController.weightUnit.value;
    heightUnit.value = _weightBMIController.heightUnit.value;
    super.onInit();
  }

  void onSelectBMIDate() async {
    final result = await onSelectDate(context: context, initialDate: bloodPressureDate, primaryColor: AppColor.green);
    onSelectAddDate(result);
  }

  void onSelectBMITime() async {
    final result = await onSelectTime(
      context: context,
      initialTime: TimeOfDay(hour: bloodPressureDate.hour, minute: bloodPressureDate.minute),
    );
    onSelectAddTime(result);
  }

  void onSelectWeightUnit() {
    final double weight = weightController.text.toDouble;
    if (weightUnit.value == WeightUnit.kg) {
      weightUnit.value = WeightUnit.lb;
      weightController.text = ConvertUtils.convertKgToLb(weight).toStringAsFixed(2);
    } else {
      weightUnit.value = WeightUnit.kg;
      weightController.text = ConvertUtils.convertLbToKg(weight).toStringAsFixed(2);
    }
  }

  void onSelectHeightUnit() {
    if (heightUnit.value == HeightUnit.cm) {
      heightUnit.value = HeightUnit.ftIn;
      final heightCm = cmController.text.toDouble;
      ftController.text = '${ConvertUtils.convertCmToFeet(heightCm)}\'';
      inchController.text = '${ConvertUtils.convertCmToInches(heightCm)}\"';
    } else {
      heightUnit.value = HeightUnit.cm;
      final feet = ftController.text.toInt;
      final inches = inchController.text.toInt;
      cmController.text = ConvertUtils.convertFtAndInToCm(feet, inches).toStringAsFixed(2);
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
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController.updateUser(UserModel(age: value, genderId: _appController.currentUser.value.genderId ?? '0'));
          age.value = value;
        },
      ),
    );
  }

  void onPressGender() {
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogGenderWidget(
        initialGender: gender,
        onPressCancel: Get.back,
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

  double _getWeight() {
    final weight = weightController.text;
    if (weight.isEmpty) {
      weightController.text = '0.0';
    }
    if (weightUnit.value == WeightUnit.kg) {
      return double.parse(weightController.text.isNotEmpty ? weightController.text : '0.0');
    } else {
      return ConvertUtils.convertLbToKg(
        double.parse(weightController.text.isNotEmpty ? weightController.text : '0.0'),
      );
    }
  }

  double _getHeight() {
    if (heightUnit.value == HeightUnit.cm) {
      if (cmController.text.isEmpty) {
        cmController.text = '0.0';
      }
      return ConvertUtils.convertCmToM(
        double.parse(cmController.text.isNotEmpty ? cmController.text : '0.0'),
      );
    } else {
      if (ftController.text.isEmpty) {
        ftController.text = '0\'';
      }
      if (inchController.text.isEmpty) {
        inchController.text = '0\'';
      }
      return ConvertUtils.convertFtAndInchToM(ftController.text.isNotEmpty ? ftController.text.toInt : 0,
          inchController.text.isNotEmpty ? inchController.text.toInt : 0);
    }
  }

  void caculateBMI() {
    double weight = _getWeight();
    double height = _getHeight();

    if (weight != 0 && height != 0) {
      bmi.value = (weight / pow(height, 2)).round();
    }
    bmiType.value = BMITypeEnum.getBMITypeByValue(bmi.value);
  }

  Future<void> addBMI() async {
    analytics.logEvent(name: AppLogEvent.addDataWeightBMI);
    debugPrint("Logged ${AppLogEvent.addDataWeightBMI} at ${DateTime.now()}");

    if(_appController.isPremiumFull.value) {
      _onAddBMI();
    } else {
      if(_appController.userLocation.compareTo("Other") != 0) {
        final prefs = await SharedPreferences.getInstance();
        int cntAddData = prefs.getInt("cnt_add_data_weight_bmi") ?? 0;

        if(cntAddData < 2) {
          _onAddBMI();
          prefs.setInt("cnt_add_data_weight_bmi", cntAddData + 1);
        } else {
          Get.toNamed(AppRoute.iosSub);
        }
      } else {
        _onAddBMI();
      }
    }
  }

  _onAddBMI() async {
    isLoading.value = true;
    _weightBMIController.weightUnit.value = weightUnit.value;
    _weightBMIController.heightUnit.value = heightUnit.value;
    _setHeightUnit();
    _setWeightUnit();
    Map? initialGender = AppConstant.listGender
        .firstWhereOrNull((element) => element['id'] == (_appController.currentUser.value.genderId ?? '0'));
    final bmiDateTime = DateTime(bloodPressureDate.year, bloodPressureDate.month, bloodPressureDate.day,
        bloodPressureDate.hour, bloodPressureDate.minute);
    final bmiModel = BMIModel(
      key: bmiDateTime.toIso8601String(),
      weight: _getWeight(),
      weightUnitId: weightUnit.value.id,
      typeId: bmiType.value.id,
      dateTime: bmiDateTime.millisecondsSinceEpoch,
      age: age.value,
      height: _getHeight(),
      heightUnitId: heightUnit.value.id,
      gender: initialGender!['id'] ?? '0',
      bmi: bmi.value,
    );
    await _bmiUsecase.saveBMI(bmiModel);
    isLoading.value = false;
    showTopSnackBar(context, message: TranslationConstants.addDataSuccess.tr, type: SnackBarType.done);
    Get.back(result: true);
  }

  Future<void> _setWeightUnit() async {
    await _bmiUsecase.setWeightUnitId(weightUnit.value.id);
  }

  Future<void> _setHeightUnit() async {
    await _bmiUsecase.setHeightUnitId(heightUnit.value.id);
  }

  void onEdit(BMIModel bmiModel) {
    currentBMI = bmiModel;
    bloodPressureDate = DateTime.fromMillisecondsSinceEpoch(bmiModel.dateTime!);
    updateDateTimeString(bloodPressureDate);
    weightUnit.value = bmiModel.weightUnit;
    if (bmiModel.weightUnit == WeightUnit.kg) {
      weightController.text = '${bmiModel.weightKg}';
    } else {
      weightController.text = '${bmiModel.weightLb}';
    }
    if (bmiModel.heightUnit == HeightUnit.cm) {
      final height = bmiModel.heightCm;
      cmController.text = '$height';
    } else {
      ftController.text = '${bmiModel.heightFT} \'';
      inchController.text = '${bmiModel.heightInches} \"';
    }
    bmiType.value = bmiModel.type;
    age.value = bmiModel.age ?? 30;
    gender.value = AppConstant.listGender
        .firstWhere((element) => element['id'] == bmiModel.gender, orElse: () => AppConstant.listGender[0]);
    bmi.value = bmiModel.bmi ?? 0;
  }

  void onSave() async {
    isLoading.value = true;

    currentBMI.weight = _getWeight();
    currentBMI.weightUnitId = weightUnit.value.id;
    currentBMI.typeId = bmiType.value.id;
    final bmiDateTime = DateTime(bloodPressureDate.year, bloodPressureDate.month, bloodPressureDate.day,
        bloodPressureDate.hour, bloodPressureDate.minute);
    currentBMI.dateTime = bmiDateTime.millisecondsSinceEpoch;
    currentBMI.age = age.value;
    currentBMI.height = _getHeight();
    currentBMI.heightUnitId = heightUnit.value.id;
    currentBMI.gender = gender['id'];
    currentBMI.bmi = bmi.value;
    await _bmiUsecase.updateBMI(currentBMI);
    isLoading.value = false;
    showTopSnackBar(context, message: TranslationConstants.editDataSuccess.tr, type: SnackBarType.done);
    Get.back(result: true);
  }
}
