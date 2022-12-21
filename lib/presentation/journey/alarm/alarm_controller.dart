import 'package:bloodpressure/common/mixin/alarm_dialog_mixin.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AlarmController extends GetxController with AlarmDialogMixin {
  final AlarmUseCase alarmUseCase;

  RxList<AlarmModel> alarmList = <AlarmModel>[].obs;

  AlarmController ({required this.alarmUseCase});

  @override
  void onInit() {
    alarmUseCase.getAlarms().then((value) => alarmList.value = value);
    super.onInit();
  }

  void onPressDeleteAlarm(AlarmModel alarmModel) async {
    final index =
        alarmList.indexWhere((element) => element.id == alarmModel.id);
    await alarmUseCase.removeAlarm(index);
    alarmList.value = await alarmUseCase.getAlarms();
  }


  @override
  void refresh() async {
    alarmList.value = await alarmUseCase.getAlarms();
  }

  void addAlarm(AlarmModel alarmModel) async {
    alarmUseCase.addAlarm(alarmModel);
    refresh();
  }

  void updateAlarm(AlarmModel alarmModel) {
    final index =
        alarmList.indexWhere((element) => element.id == alarmModel.id);
    alarmUseCase.updateAlarm(index, alarmModel);
    refresh();
  }

  void onPressEditAlarm(BuildContext context, AlarmModel alarmModel) {
    showEditAlarm(context: context, alarmModel: alarmModel, onPressSave: (alarmModel) {
      updateAlarm(alarmModel);
      Get.back();
    });
  }
}
