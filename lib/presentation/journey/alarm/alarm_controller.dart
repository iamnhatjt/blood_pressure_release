import 'package:bloodpressure/common/injector/app_di.dart';
import 'package:bloodpressure/common/mixin/alarm_dialog_mixin.dart';
import 'package:bloodpressure/common/util/app_notification_local.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/data/local_repository.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmController extends GetxController with AlarmDialogMixin {
  final AlarmUseCase alarmUseCase;

  RxBool isPremiumFull = Get.find<AppController>().isPremiumFull;
  RxList<AlarmModel> alarmList = <AlarmModel>[].obs;

  AlarmController ({required this.alarmUseCase});

  void onSubScriblePremium() {}

  @override
  void onInit() {
    alarmList.value = getIt.get<LocalRepository>().getAlarms();
    super.onInit();
  }

  void onPressDeleteAlarm(AlarmModel alarmModel) async {
    final index =
        alarmList.indexWhere((element) => element.id == alarmModel.id);
    await alarmUseCase.removeAlarm(index);
    alarmList.value = await alarmUseCase.getAlarms();
  }

  void onPressAddAlarm({
    required BuildContext context,
    AlarmModel? alarmModel,
    AlarmType? alarmType,
  }) {
    showAddAlarm(
      context: context,
      alarmType: alarmType,
      alarmModel: alarmModel,
      onPressSave: _addAlarm,
      onPressCancel: null,
    );
  }

  void onEditAlarm({
    required BuildContext context,
    required AlarmModel alarmModel,
  }) {
    showEditAlarm(
      context: context,
      alarmModel: alarmModel,
      onPressSave: _updateAlarm,
    );
  }

  void _addAlarm(AlarmModel alarmModel) async {
    alarmUseCase.addAlarm(alarmModel);
    alarmList.value = await alarmUseCase.getAlarms();
    Get.back();
  }

  void _updateAlarm(AlarmModel alarmModel) {
    final index =
        alarmList.indexWhere((element) => element.id == alarmModel.id);
    alarmUseCase.updateAlarm(index, alarmModel);
    alarmList[index] = alarmModel;
    Get.back();
  }
}
