import 'dart:developer';

import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/common/mixin/alarm_dialog_mixin.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:bloodpressure/presentation/widget/snack_bar/app_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AlarmController extends GetxController with AlarmDialogMixin {
  final AlarmUseCase alarmUseCase;

  RxList<AlarmModel> alarmList = <AlarmModel>[].obs;

  AlarmController({required this.alarmUseCase});

  @override
  void onInit() {
    alarmUseCase.getAlarms().then((value) => alarmList.value = value);
    super.onInit();
  }

  void onPressDeleteAlarm(AlarmModel alarmModel) async {
    showConfirmDeleteAlarmDialog(Get.context!, alarmModel: alarmModel, onPressConfirm: (alarmModel) async {
      deleteAlarm(alarmModel);
      Get.back();
    });
  }

  void deleteAlarm(AlarmModel alarmModel) async {
    try {
      // final index = alarmList.indexWhere((element) => element.id == alarmModel.id);
      await alarmUseCase.removeAlarm(alarmModel);
      refresh();
      showTopSnackBar(Get.context!, message: TranslationConstants.deleteAlarmSuccess.tr, type: SnackBarType.done);
    } on Exception catch (_) {
      showTopSnackBar(Get.context!, message: TranslationConstants.deleteAlarmFailed.tr, type: SnackBarType.error);
    }
  }

  @override
  void refresh() async {
    alarmList.value = await alarmUseCase.getAlarms();
  }

  void addAlarm(AlarmModel alarmModel) async {
    try {
      alarmUseCase.addAlarm(alarmModel);
      refresh();
      showTopSnackBar(Get.context!, message: TranslationConstants.addAlarmSuccess.tr, type: SnackBarType.done);
    } on Exception catch (_) {
      showTopSnackBar(Get.context!, message: TranslationConstants.addAlarmFailed.tr, type: SnackBarType.error);
    }
  }

  void updateAlarm(AlarmModel alarmModel) {
    log("updateAlarm.alarmModel.id: ${alarmModel.id}");
    for (final AlarmModel model in alarmList) {
      log("updateAlarm.model: ${model.id}");
    }
    try {
      alarmUseCase.updateAlarm(alarmModel);
      refresh();
      showTopSnackBar(Get.context!, message: TranslationConstants.updateAlarmSuccess.tr, type: SnackBarType.done);
    } on Exception catch (_) {
      showTopSnackBar(Get.context!, message: TranslationConstants.updateAlarmFailed.tr, type: SnackBarType.error);
    }
  }

  void onPressEditAlarm(BuildContext context, AlarmModel alarmModel) {
    showEditAlarm(
        context: context,
        alarmModel: alarmModel,
        onPressSave: (alarmModel) {
          updateAlarm(alarmModel);
          Get.back();
        });
  }
}
