import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/extensions/date_time_extensions.dart';
import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/domain/enum/blood_pressure_type.dart';
import 'package:bloodpressure/domain/model/blood_pressure_model.dart';
import 'package:bloodpressure/domain/usecase/blood_pressure_usecase.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/constants/app_route.dart';
import '../../../../../common/constants/enums.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../../domain/model/user_model.dart';
import '../../../../widget/app_dialog.dart';
import '../../../../widget/app_dialog_age_widget.dart';
import '../../../../widget/app_dialog_gender_widget.dart';
import '../../../../widget/snack_bar/app_snack_bar.dart';
import '../blood_pressure_controller.dart';
import 'widget/blood_pressure_info_widget.dart';

class AddBloodPressureController extends GetxController with DateTimeMixin {
  late BuildContext context;
  final BloodPressureUseCase _bloodPressureUseCase;

  RxString stringBloodPrDate = "".obs;
  RxString stringBloodPrTime = "".obs;
  Rx<BloodPressureType> bloodPressureType = BloodPressureType.normal.obs;
  RxInt systolic = 100.obs;
  RxInt diastolic = 70.obs;
  RxInt pulse = 40.obs;
  Rx<DateTime> bloodPressureDate = DateTime.now().obs;
  RxBool isLoading = false.obs;
  final _appController = Get.find<AppController>();
  RxInt age = (Get.find<AppController>().currentUser.value.age ?? 30).obs;
  RxMap gender = AppConstant.listGender
      .firstWhere((element) => element['id'] == Get.find<AppController>().currentUser.value.genderId,
      orElse: () => AppConstant.listGender[0])
      .obs;

  BloodPressureModel? _bloodPressure;

  AddBloodPressureController(this._bloodPressureUseCase);

  final analytics = FirebaseAnalytics.instance;

  @override
  void onInit() {
    _updateDateTimeString(bloodPressureDate.value);
    super.onInit();
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


  void onEdit(BloodPressureModel bloodPressureModel) {
    _bloodPressure = bloodPressureModel;
    bloodPressureDate.value = DateTime.fromMillisecondsSinceEpoch(_bloodPressure!.dateTime!);
    _updateDateTimeString(bloodPressureDate.value);
    systolic.value = _bloodPressure?.systolic ?? 0;
    diastolic.value = _bloodPressure?.diastolic ?? 0;
    bloodPressureType.value = _bloodPressure?.bloodType ?? BloodPressureType.normal;
    pulse.value = _bloodPressure?.pulse ?? 0;
  }

  _updateDateTimeString(DateTime? dateTime) {
    if (dateTime != null) {
      stringBloodPrTime.value = DateFormat(
        'h:mm a',
        _appController.currentLocale.languageCode,
      ).format(dateTime);
      stringBloodPrDate.value = DateFormat(
        'MMM dd, yyyy',
        _appController.currentLocale.languageCode,
      ).format(dateTime);
    }
  }

  void onShowBloodPressureInfo() {
    showAppDialog(context, TranslationConstants.bloodPressure.tr, '',
        widgetBody: const BloodPressureInfoWidget(), firstButtonText: TranslationConstants.ok.tr);
  }

  Future onSelectBloodPressureDate() async {
    final result = await onSelectDate(context: context, initialDate: bloodPressureDate.value);
    if (result != null) {
      bloodPressureDate.value = bloodPressureDate.value.update(year: result.year, month: result.month, day: result.day);
      _updateDateTimeString(bloodPressureDate.value);
    }
  }

  Future onSelectBloodPressureTime() async {
    final dateTime = bloodPressureDate.value;
    final result = await onSelectTime(
      context: context,
      initialTime: TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      ),
    );
    if (result != null) {
      bloodPressureDate.value = bloodPressureDate.value.update(
        hour: result.hour,
        minute: result.minute,
      );
      _updateDateTimeString(bloodPressureDate.value);
    }
  }

  void onSelectSys(int newSys) {
    final sys = newSys + 20;
    systolic.value = sys;
    if (sys < 90) {
      bloodPressureType.value = BloodPressureType.hypotension;
    } else if ((sys >= 90 && sys <= 119)) {
      bloodPressureType.value = BloodPressureType.normal;
    } else if ((sys >= 120 && sys <= 129)) {
      bloodPressureType.value = BloodPressureType.elevated;
    } else if ((sys >= 130 && sys <= 139)) {
      bloodPressureType.value = BloodPressureType.hypertensionStage1;
    } else if ((sys >= 140 && sys <= 180)) {
      bloodPressureType.value = BloodPressureType.hypertensionStage2;
    } else {
      bloodPressureType.value = BloodPressureType.hypertensionCrisis;
    }
  }

  void onSelectDia(int newDia) {
    final dia = newDia + 20;
    diastolic.value = dia;
    if (dia < 60) {
      bloodPressureType.value = BloodPressureType.hypotension;
    } else if ((dia >= 60 && dia <= 79)) {
      final sys = systolic.value;
      if ((sys >= 90 && sys <= 119)) {
        bloodPressureType.value = BloodPressureType.normal;
      }
      if ((sys >= 120 && sys <= 129)) {
        bloodPressureType.value = BloodPressureType.elevated;
      }
    } else if ((dia >= 80 && dia <= 89)) {
      bloodPressureType.value = BloodPressureType.hypertensionStage1;
    } else if ((dia >= 90 && dia <= 120)) {
      bloodPressureType.value = BloodPressureType.hypertensionStage2;
    } else {
      bloodPressureType.value = BloodPressureType.hypertensionCrisis;
    }
  }

  void onSelectPules(int newPules) {
    pulse.value = newPules + 20;
  }

  Future addBloodPressure() async {
    analytics.logEvent(name: AppLogEvent.addDataBloodPressure);
    debugPrint("Logged ${AppLogEvent.addDataBloodPressure} at ${DateTime.now()}");

    final appController = Get.find<AppController>();

    if (appController.isPremiumFull.value) {
      _addData();
    } else {
      if (appController.userLocation.compareTo("Other") != 0) {
        final prefs = await SharedPreferences.getInstance();
        int cntAddData = prefs.getInt("cnt_add_data_blood_pressure") ?? 0;

        if(cntAddData < 2) {
          _addData();
          prefs.setInt("cnt_add_data_blood_pressure", cntAddData + 1);
        } else {
          Get.toNamed(AppRoute.iosSub);
        }
      } else {
        _addData();
      }
    }
  }

  _addData() async {
    isLoading.value = true;
    final bloodPres = BloodPressureModel(
        key: bloodPressureDate.value.toIso8601String(),
        systolic: systolic.value,
        diastolic: diastolic.value,
        pulse: pulse.value,
        type: bloodPressureType.value.id,
        dateTime: bloodPressureDate.value.millisecondsSinceEpoch);
    await _bloodPressureUseCase.saveBloodPressure(bloodPres);
    isLoading.value = false;
    showTopSnackBar(context, message: TranslationConstants.addDataSuccess.tr, type: SnackBarType.done);
    Get.back(result: true);
  }

  Future onSave() async {
    isLoading.value = true;
    _bloodPressure?.systolic = systolic.value;
    _bloodPressure?.diastolic = diastolic.value;
    _bloodPressure?.pulse = pulse.value;
    _bloodPressure?.type = bloodPressureType.value.id;
    _bloodPressure?.dateTime = bloodPressureDate.value.millisecondsSinceEpoch;
    await _bloodPressureUseCase.saveBloodPressure(_bloodPressure!);
    isLoading.value = false;
    showTopSnackBar(context, message: TranslationConstants.editDataSuccess.tr, type: SnackBarType.done);
    Get.back(result: true);
  }
}
