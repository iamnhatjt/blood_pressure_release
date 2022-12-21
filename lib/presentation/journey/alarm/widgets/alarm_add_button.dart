import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_add_button_controller.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/widget/app_floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/enum/alarm_type.dart';

class AddAlarmButton extends GetView<AlarmAddButtonController> {
  const AddAlarmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      animation: controller.animation,
      onPress: () => controller.animationController.isCompleted
          ? controller.animationController.reverse()
          : controller.animationController.forward(),
      iconColor: AppColor.white,
      backgroundCloseColor: AppColor.primaryColor,
      items: AlarmType.values
          .map(
            (alarmType) => Bubble(
              title: alarmType.tr,
              bubbleColor: alarmType.color,
              onPress: () {
                controller.onPressAdd(context, alarmType);
              },
            ),
          )
          .toList(),
    );
  }
}
