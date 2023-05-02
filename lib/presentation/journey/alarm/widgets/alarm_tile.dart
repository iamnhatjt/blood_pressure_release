import 'package:bloodpressure/common/extensions/string_extension.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import "package:bloodpressure/presentation/theme/theme_text.dart";
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/app_week_days_picker.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../domain/model/alarm_model.dart';
import '../../../../../common/constants/app_image.dart';
import '../../../theme/app_color.dart';
import 'alarm_dialog_controller.dart';
//
// class AlarmTile extends StatelessWidget {
//   const AlarmTile({
//     Key? key,
//     required this.alarmModel,
//     this.onTap,
//     this.onDeleteTap,
//   }) : super(key: key);
//
//   final void Function(AlarmModel)? onTap;
//   final void Function(AlarmModel)? onDeleteTap;
//   final AlarmModel alarmModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppTouchable.common(
//       margin: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 17.0.sp),
//       onPressed: () {
//         if (onTap != null) onTap!(alarmModel);
//       },
//       padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
//       width: Get.width,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     TranslationConstants.remindToRecord.tr,
//                     style: textStyle12400(),
//                   ),
//                   SizedBox(
//                     height: 4.sp,
//                   ),
//                   Text(
//                     alarmModel.type == null
//                         ? "Unknown"
//                         : alarmModel.type.toString().split(".")[1].tr,
//                     style: textStyle16500(),
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     DateFormat(DateFormat.HOUR24_MINUTE).format(alarmModel.time!),
//                     style: textStyle30600(),
//                   ),
//                   SizedBox(height: 20.sp),
//                   AppTouchable(
//                     onPressed: () {
//                       if (onDeleteTap != null) onDeleteTap!(alarmModel);
//                     },
//                     child: SvgPicture.asset(AppImage.ic_del),
//                   )
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 14.sp,
//           ),
//           AppWeekdaysPicker(
//             enableSelection: false,
//             initialWeekDays: alarmModel.alarmDays,
//           ),
//         ],
//       ),
//     );
//   }
// }


class AlarmTile extends StatelessWidget {
  const AlarmTile({
    Key? key,
    required this.alarmModel,
    this.onTap,
    this.onDeleteTap,
  }) : super(key: key);

  final void Function(AlarmModel)? onTap;
  final void Function(AlarmModel)? onDeleteTap;
  final AlarmModel alarmModel;

  @override
  Widget build(BuildContext context) {
    AlarmDialogController controllerAlarm = Get.find<AlarmDialogController>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 17.0.sp),

      child: ButtonIos3D(
        radius: 10,
        onPress: () {
          if (onTap != null) onTap!(alarmModel);
        },
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),

          child: Stack(children: [
            Positioned(
              top: 12.0.sp,
              right: 8.0.sp,
              child: AppTouchable(
                onPressed: () {
                  if (onDeleteTap != null) onDeleteTap!(alarmModel);
                },
                child: Icon(CupertinoIcons.delete_solid, color: Colors.red, size: 30,),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 4.0.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TranslationConstants.remindToRecord.tr,
                          style: textStyle12400().copyWith(color: const Color(0xFF646464)),
                        ),
                        SizedBox(
                          height: 4.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        alarmModel.type == null
                            ? "Unknown"
                            : alarmModel.type.toString().split(".")[1].tr,
                        style: textStyle16500().copyWith(color: const Color(0xFF646464)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.0.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ButtonIos3D(
                      width: 32.0.sp,
                      height: 32.0.sp,

                      radius: 10.0.sp,
                      backgroundColor:  DateFormat('HH').format(alarmModel.time!).toInt < 12
                          ? const Color(0xFF40A4FF)
                          : Colors.white,
                      innerColor:
                      const Color(0xFF3FA2FC).withOpacity(0.5),
                      // onPressed: () => controller.onPressPM(),
                      child: Center(
                        child: Text(
                          "AM",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                              color:  DateFormat('HH').format(alarmModel.time!).toInt < 12
                                  ?Colors.white
                                  :  const Color(0xFF40A4FF)),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0.sp,),


                    Text(
                      DateFormat('hh:mm').format(alarmModel.time!) ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.grayText, fontSize: 40.0.sp),
                    ),
                    SizedBox(width: 12.0.sp,),
                    ButtonIos3D(
                      width: 34.0.sp,
                      height: 32.0.sp,
                      radius: 10.0.sp,
                      backgroundColor:  DateFormat('HH').format(alarmModel.time!).toInt >12
                          ? const Color(0xFF40A4FF)
                          : Colors.white,

                      innerColor:
                      const Color(0xFF3FA2FC).withOpacity(0.5),
                      // onPressed: () => controller.onPressPM(),
                      child: Center(
                        child: Text(
                          "PM",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                              color:  DateFormat('HH').format(alarmModel.time!).toInt >12
                                  ? Colors.white
                                  : const Color(0xFF40A4FF)),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 8.0.sp,
                ),
                AppWeekdaysPicker(
                  enableSelection: false,
                  initialWeekDays: alarmModel.alarmDays,
                ),
                SizedBox(
                  height: 8.0.sp,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
