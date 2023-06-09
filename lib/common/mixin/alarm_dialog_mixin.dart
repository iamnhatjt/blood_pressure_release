import 'package:bloodpressure/common/extensions/string_extension.dart';
import 'package:bloodpressure/common/injector/app_di.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_dialog.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_button.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../presentation/controller/app_controller.dart';
import '../../presentation/widget/ios_cofig_widget/Button_ios_3d.dart';


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
    Function(AlarmModel)? onPressSave,
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



  void showConfirmDeleteAlarmDialog(
      BuildContext context, {
        required AlarmModel alarmModel,
        void Function()? onPressCancel,
        void Function(AlarmModel)? onPressConfirm,
      }) async {
    return showAppDialog(
        context
        // "%s %s %s".trArgs([
        //   TranslationConstants.delete.tr.toCapitalized(),
        //   TranslationConstants.alarm.tr.toLowerCase(),
        //   alarmModel.type?.tr ?? "Unknown",
        // ]),
        ,' ',
        "",
        hideGroupButton: true,
        widgetBody: Column(
          children: [

            Text(
              TranslationConstants.deleteAlarmConfirmMsg.tr,
              style: textStyle20700().copyWith(color: const Color(0xFF7A7A7A)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32.0.sp,
            ),
      Row(
        children: [
          Expanded(
            child: ButtonIos3D(
              onPress: onPressCancel ?? Get.back,

              height: 60.0.sp,
              width: Get.width,
              // text: firstButtonText,
              backgroundColor: const Color(0xFF5298EB),
              dropRadius: 10,
              offsetDrop: Offset.zero,
              dropColor: Colors.black.withOpacity(0.25),
              innerColor: Colors.black.withOpacity(0.25),
              innerRadius: 4,
              offsetInner: const Offset(0, -4),
              radius: 20.0.sp,

              child: Center(
                child: Text(
                  TranslationConstants.cancel.tr,
                  textAlign: TextAlign.center,
                  style: textStyle24700(),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0.sp),
          Expanded(
            child: ButtonIos3D(
              onPress: onPressConfirm != null ? () => onPressConfirm(alarmModel) : null,

              height: 60.0.sp,
              width: Get.width,
              // text: firstButtonText,
              backgroundColor: const Color(0xFFFF6464),
              dropRadius: 10,
              offsetDrop: Offset.zero,
              dropColor: Colors.black.withOpacity(0.25),
              innerColor: Colors.black.withOpacity(0.25),
              innerRadius: 4,
              offsetInner: const Offset(0, -4),
              radius: 20.0.sp,



              child: Center(
                child: Text(
                  TranslationConstants.delete.tr,
                  textAlign: TextAlign.center,
                  style: textStyle24700(),
                ),
              ),
            ),
          ),
        ],
      ),
          ],
        ));
  }
}
