import 'package:bloodpressure/common/mixin/alarm_dialog_mixin.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmAddButtonController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  AlarmController alarmController = Get.find<AlarmController>();

  void onPressAdd(
      BuildContext context,
      AlarmType e) {
    if (animationController.isCompleted) {
      animationController.reverse();
    }
    alarmController.onPressAddAlarm(context: context, alarmType: e);
  }

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
    CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.onInit();
  }
}