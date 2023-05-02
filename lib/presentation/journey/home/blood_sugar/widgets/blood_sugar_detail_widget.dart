import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BloodSugarDetailWidget extends GetWidget<BloodSugarController> {
  const BloodSugarDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appController = Get.find<AppController>();
    return ButtonIos3D.onlyInner(
      backgroundColor: Colors.white,
      innerColor: const Color(0xFF89C7FF),
      radius: 16,
      offsetInner: const Offset(0, 0),
      onPress: () => controller.onEdited(controller.selectedBloodSugar.value),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric( horizontal: 14.sp, vertical: 8.0.sp),

        child: Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat(
                        'MMM dd, yyyy',
                        appController.currentLocale.languageCode,
                      ).format(
                        DateTime.fromMillisecondsSinceEpoch(
                            controller.selectedBloodSugar.value.dateTime!),
                      ),
                      style: IosTextStyle.f16w500wb.copyWith(fontSize: 14)
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Text(
                      DateFormat('hh:mm a',
                              appController.currentLocale.languageCode)
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              controller.selectedBloodSugar.value.dateTime!)),
                        style: IosTextStyle.f16w500wb.copyWith(fontSize: 14)

                    ),

                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${controller.selectedBloodSugar.value.measure}',
                      style: ThemeText.headline4.copyWith(
                          fontSize: 36.sp,
                          color: const Color(0xFF606060),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${controller.selectedBloodSugar.value.unit}',
                      style: IosTextStyle.f14w400wb.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Text(
                      "${TranslationConstants.bloodSugarState.tr}: ${bloodSugarStateDisplayMap[controller.selectedBloodSugar.value.stateCode]!}",
                      style: IosTextStyle.f14w400wb.copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.heart_fill,
                      color: bloodSugarInfoColorMap[
                      controller.selectedBloodSugar.value.infoCode],
                    ),
                    Expanded(
                      child: Container(
                        width: 60.0.sp,
                        child: Text(
                          bloodSugarInfoDisplayMap[
                          controller.selectedBloodSugar.value.infoCode]!,
                          style: const TextStyle(
                              overflow: TextOverflow.visible,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF646464)),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap:  () => controller
                            .onPressDeleteData(controller.selectedBloodSugar.value.key!),

                        child: const Icon(
                          CupertinoIcons.delete_solid,
                          color: Color(0xFFFF7070),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
