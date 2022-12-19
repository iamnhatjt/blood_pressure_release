import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_dialog_controller.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_button.dart';
import 'package:bloodpressure/presentation/widget/app_week_days_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AlarmDialog extends GetView<AlarmDialogController> {
  AlarmDialog({
    Key? key,
    this.alarmModel,
    this.onPressCancel,
    this.onPressSave,
    this.alarmType,
  }) : super(key: key) {
    if (alarmModel != null) {
      controller.alarmModel.value = alarmModel!;
    } else {
      controller.alarmModel.value = controller.alarmModel.value.copyWith(type: alarmType);
    }
  }

  final AlarmModel? alarmModel;
  final void Function()? onPressCancel;
  final void Function(AlarmModel)? onPressSave;
  final AlarmType? alarmType;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 69.0.sp,
            ),
            AppWeekdaysPicker(
                initialWeekDays: controller.alarmModel.value.alarmDays,
                enableSelection: true,
                onSelectedWeekdaysChanged:
                    controller.onSelectedWeekDaysChanged),
            SizedBox(
              height: 52.0.sp,
            ),
            SizedBox(
              height: 160.0.sp,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime(
                    0,
                    0,
                    0,
                    controller.alarmModel.value.time!.hour,
                    controller.alarmModel.value.time!.minute),
                use24hFormat: true,
                onDateTimeChanged: controller.onTimeChange,
              ),
            ),
            SizedBox(
              height: 52.0.sp,
            ),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: onPressCancel ?? () => Get.back(),
                    height: 60.0.sp,
                    width: Get.width,
                    color: AppColor.red,
                    radius: 10.0.sp,
                    child: Text(
                      TranslationConstants.cancel.tr,
                      textAlign: TextAlign.center,
                      style: textStyle24700(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0.sp),
                Expanded(
                  child: AppButton(
                    height: 60.0.sp,
                    width: Get.width,
                    onPressed: controller.isValid.value
                        ? () {
                            if (onPressSave != null)
                              onPressSave!(controller.alarmModel.value);
                              controller.alarmModel.value = AlarmModel(id: const Uuid().v4(), type: AlarmType.heartRate, time: DateTime.now(), alarmDays: List.generate(7, (index) => false,),);
                          }
                        : null,
                    color: controller.isValid.value
                        ? AppColor.primaryColor
                        : AppColor.gray,
                    radius: 10.0.sp,
                    child: Text(
                      TranslationConstants.save.tr,
                      textAlign: TextAlign.center,
                      style: textStyle24700(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
