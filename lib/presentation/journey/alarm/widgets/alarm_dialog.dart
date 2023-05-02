import 'package:bloodpressure/common/util/app_util.dart';
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
import 'package:intl/intl.dart';

import '../../../../common/constants/app_image.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/ios_cofig_widget/Button_ios_3d.dart';
//
// class AlarmDialog extends GetView<AlarmDialogController> {
//   AlarmDialog({
//     Key? key,
//     this.alarmModel,
//     this.onPressCancel,
//     this.onPressSave,
//     this.alarmType,
//   }) : super(key: key) {
//     if (alarmModel != null) {
//       log("AlarmDialog.alarmModel.id: ${alarmModel!.id}");
//       controller.alarmModel.value = alarmModel!;
//     } else {
//       controller.alarmModel.value = controller.alarmModel.value
//           .copyWith(type: alarmType, time: DateTime.now());
//     }
//     controller.validate();
//   }
//
//   final AlarmModel? alarmModel;
//   final void Function()? onPressCancel;
//   final void Function(AlarmModel)? onPressSave;
//   final AlarmType? alarmType;
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             height: 69.0.sp,
//           ),
//           AppWeekdaysPicker(
//               initialWeekDays: controller.alarmModel.value.alarmDays,
//               enableSelection: true,
//               onSelectedWeekdaysChanged: controller.onSelectedWeekDaysChanged),
//           SizedBox(
//             height: 52.0.sp,
//           ),
//           SizedBox(
//             height: 160.0.sp,
//             child: CupertinoDatePicker(
//               mode: CupertinoDatePickerMode.time,
//               initialDateTime: DateTime(
//                   0,
//                   0,
//                   0,
//                   controller.alarmModel.value.time!.hour,
//                   controller.alarmModel.value.time!.minute),
//               use24hFormat: true,
//               onDateTimeChanged: controller.onTimeChange,
//             ),
//           ),
//           SizedBox(
//             height: 52.0.sp,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: ButtonIos3D(
//                   onPress: () {
//                     controller.reset();
//                     if (onPressCancel != null) {
//                       onPressCancel!();
//                     } else {
//                       Get.back();
//                     }
//                   },
//                   dropRadius: 10,
//                   offsetDrop: Offset.zero,
//                   dropColor: Colors.black.withOpacity(0.25),
//                   innerColor: Colors.black.withOpacity(0.25),
//                   innerRadius: 4,
//                   offsetInner: const Offset(0,-4),
//
//
//                   height: 60.0.sp,
//                   width: Get.width,
//                   backgroundColor: const Color(0xFFFF6464),
//                   radius: 20.0.sp,
//                   child: Center(
//                     child: Text(
//                       TranslationConstants.cancel.tr,
//                       textAlign: TextAlign.center,
//                       style: textStyle24700(),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8.0.sp),
//               Expanded(
//                 child: ButtonIos3D(
//                   width: Get.width,
//                   onPress: controller.isValid.value
//                       ? () {
//                           final alarmModel = controller.alarmModel.value;
//                           controller.reset();
//                           controller.sendAnalyticsEvent(alarmModel.type!
//                               .getAnalyticsEventName(Get.currentRoute));
//                           if (onPressSave != null) {
//                             log("AlarmDialog.alarmModel.id: ${alarmModel.id}");
//                             onPressSave!(alarmModel);
//                           }
//                         }
//                       : null,
//                   backgroundColor: controller.isValid.value
//                       ? const Color(0xFF5298EB)
//                       : AppColor.gray,
//                   height: 60.0.sp,
//                   dropRadius: 10,
//                   offsetDrop: Offset.zero,
//                   dropColor: Colors.black.withOpacity(0.25),
//                   innerColor: Colors.black.withOpacity(0.25),
//                   innerRadius: 4,
//                   offsetInner: const Offset(0,-4),
//                   radius: 20.0.sp,
//                   child: Center(
//                     child: Text(
//                       TranslationConstants.save.tr,
//                       textAlign: TextAlign.center,
//                       style: textStyle24700(),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       );
//     });
//   }
// }



class AlarmDialog extends GetView<AlarmDialogController> {
  AlarmDialog({
    Key? key,
    this.alarmModel,
    this.onPressCancel,
    this.onPressSave,
    this.alarmType,
  }) : super(key: key) {
    if (alarmModel != null) {
      log("AlarmDialog.alarmModel.id: ${alarmModel!.id}");
      controller.alarmModel.value = alarmModel!;
      controller.formatTimeDisplayAMOrPMWithEdit();
      print('run here edit');

    } else {
      controller.alarmModel.value = controller.alarmModel.value
          .copyWith(type: alarmType, time: DateTime.now());
      controller.formatTimeDisplayAMOrPMWithSet();
      print('run here set');

    }
    controller.validate();
  }

  final AlarmModel? alarmModel;
  final void Function()? onPressCancel;
  final void Function(AlarmModel)? onPressSave;
  final AlarmType? alarmType;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 80.0.sp,
          ),
          Container(
            width: Get.width,
            height: 140.0.sp,
            padding:
            EdgeInsets.symmetric(vertical: 20.0.sp, horizontal: 16.0.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0.sp)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF40A4FF).withOpacity(0.5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: -1.0.sp,
                    blurRadius: 4.0.sp,
                  ),
                ]),
            child: Row(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return ButtonIos3D(
                          width: 45.0.sp,
                          radius: 10.0.sp,
                          backgroundColor: controller.isAM.value
                              ? const Color(0xFF40A4FF)
                              : Colors.white,
                          innerColor: controller.isAM.value ?
                          const Color(0xFF000000).withOpacity(0.2) : const Color(0XFF40A4FF).withOpacity(0.25) ,
                          innerRadius: 4,
                          dropColor: controller.isAM.value ?
                          const Color(0xFF40A4FF).withOpacity(0.5) : const Color(0XFF40A4FF).withOpacity(0.25) ,

                          onPress: () => controller.onPressAM(),
                          child: Center(
                            child: Text(
                              "AM",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color:  controller.isAM.value
                                      ? Colors.white
                                      : const Color(0xFF40A4FF)),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10.0.sp,
                    ),
                    Expanded(
                      child: Obx(() => ButtonIos3D(
                        width: 45.0.sp,
                        radius: 10.0.sp,
                        backgroundColor: !controller.isAM.value
                            ? const Color(0xFF40A4FF)
                            : Colors.white,
                        innerColor: !controller.isAM.value ?
                        const Color(0xFF000000).withOpacity(0.2) : const Color(0XFF40A4FF).withOpacity(0.25) ,
                        innerRadius: 4,
                        dropColor: !controller.isAM.value ?
                        const Color(0xFF40A4FF).withOpacity(0.5) : const Color(0XFF40A4FF).withOpacity(0.25) ,

                        onPress: () => controller.onPressPM(),
                        child: Center(
                          child: Text(
                            "PM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                color:  controller.isAM.value
                                    ? const Color(0xFF40A4FF)
                                    : Colors.white),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      DateFormat('h:mm').format(DateTime.parse('2000-01-01 ${controller.timeDisplay.value}'))
                      ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color(0xFF646464), fontSize: 64.0.sp),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: ButtonIos3D(
                        width: 45.0.sp,
                        radius: 10.0.sp,
                        innerColor: const Color(0xFF40A4FF).withOpacity(0.25),
                        dropColor: const Color(0xFF40A4FF).withOpacity(0.25),
                        offsetInner: const Offset(0,-2),
                        offsetDrop: const Offset(0,1),
                        onPress: () => controller.onPressAdd(),
                        child: Container(
                          padding: EdgeInsets.all(12.0.sp),
                          child: AppImageWidget.asset(
                            path: AppImage.iosUpAge,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0.sp,
                    ),
                    Expanded(
                      child: ButtonIos3D(
                        width: 45.0.sp,
                        radius: 10.0.sp,
                        innerColor: const Color(0xFF40A4FF).withOpacity(0.25),
                        dropColor: const Color(0xFF40A4FF).withOpacity(0.25),
                        offsetInner: const Offset(0,-2),
                        offsetDrop: const Offset(0,1),
                        onPress: () => controller.onPressSub(),
                        child: Container(
                          padding: EdgeInsets.all(12.0.sp),
                          child: AppImageWidget.asset(
                            path: AppImage.iosDownAge,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 28.0.sp),
          AppWeekdaysPicker(
              initialWeekDays: controller.alarmModel.value.alarmDays,
              enableSelection: true,
              onSelectedWeekdaysChanged: controller.onSelectedWeekDaysChanged),


          SizedBox(
            height: 52.0.sp,
          ),

          SizedBox(
            height: 52.0.sp,
          ),
          Row(
            children: [
              Expanded(
                child: ButtonIos3D(
                  innerColor: const Color(0xFF00288F).withOpacity(0.45),
                  dropColor: const Color(0xFF000000).withOpacity(0.35),
                  radius: 20,
                  onPress: () {
                    controller.reset();
                    if (onPressCancel != null) {
                      onPressCancel!();
                    } else {
                      Get.back();
                    }
                  },

                  height: 60.0.sp,
                  width: Get.width,
                  backgroundColor: const Color(0xFFFF6464) ,
                  child: Center(
                    child: Text(
                      TranslationConstants.cancel.tr,
                      textAlign: TextAlign.center,
                      style: textStyle24700().copyWith(fontSize: 23),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0.sp),
              Expanded(
                child: ButtonIos3D(

                  height: 60.0.sp,
                  width: Get.width,
                  onPress: controller.isValid.value
                      ? () {
                    final alarmModel = controller.alarmModel.value;
                    controller.reset();
                    controller.sendAnalyticsEvent(alarmModel.type!
                        .getAnalyticsEventName(Get.currentRoute));
                    if (onPressSave != null) {
                      log("AlarmDialog.alarmModel.id: ${alarmModel.id}");
                      onPressSave!(alarmModel);
                    }
                  }
                      : null,
                  innerColor: const Color(0xFF000000).withOpacity(0.35),
                  backgroundColor: controller.isValid.value
                      ? const Color(0xFF5298EB)
                      : const Color(0XFFC8C8C8),
                  dropColor: controller.isValid.value
                      ? const Color(0xFF00288F).withOpacity(0.25)
                      : const Color(0xFF000000).withOpacity(0.25),


                  radius: 20.0.sp,
                  child: Center(
                    child: Text(
                      TranslationConstants.save.tr,
                      textAlign: TextAlign.center,
                      style: textStyle24700(),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
