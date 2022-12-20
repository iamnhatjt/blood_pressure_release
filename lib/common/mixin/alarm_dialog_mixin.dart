import 'package:bloodpressure/common/injector/app_di.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

mixin AlarmDialogMixin {
  RxList<bool> selectedWeekDays = List<bool>.generate(7, (_) => false).obs;
  Rx<DateTime> selectedTime = DateTime.now().obs;

  Future<void> showEditAlarm({
    required BuildContext context,
    required AlarmModel alarmModel,
    void Function()? onPressCancel,
    void Function(AlarmModel)? onPressSave,
  }) async {
    showAppDialog(
        context,
        "%s %s %s".trArgs([
          TranslationConstants.alarm.tr,
          TranslationConstants.forSomething.tr,
          alarmModel.type!.tr
        ]),
        "",
        hideGroupButton: true,
        widgetBody: AlarmDialog(
          alarmModel: alarmModel,
          onPressCancel: onPressCancel,
          onPressSave: onPressSave,
        ));
  }

  Future<void> showAddAlarm({
    required BuildContext context,
    AlarmModel? alarmModel,
    AlarmType? alarmType = AlarmType.heartRate,
    void Function()? onPressCancel,
    void Function(AlarmModel)? onPressSave,
  }) {
    return showAppDialog(
      context,
      "%s %s %s".trArgs([
        TranslationConstants.alarm.tr,
        TranslationConstants.forSomething.tr,
        alarmType?.tr ?? alarmModel?.type?.tr ?? "Unknown",
      ]),
      "",
      hideGroupButton: true,
      widgetBody: AlarmDialog(
        alarmModel: alarmModel,
        alarmType: alarmType,
        onPressSave: onPressSave,
        onPressCancel: onPressCancel,
      ),
    );
  }
}
