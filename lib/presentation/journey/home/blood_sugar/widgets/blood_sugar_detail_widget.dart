import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BloodSugarDetailWidget extends GetWidget<BloodSugarController> {
  const BloodSugarDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appController = Get.find<AppController>();
    return AppTouchable(
      onPressed: () => controller.onEdited(controller.selectedBloodSugar.value),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(14.sp).copyWith(top: 24.sp),
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(AppImage.ic_box)),
        ),
        child: Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat(
                        'MMM dd, yyyy',
                        appController.currentLocale.languageCode,
                      ).format(
                        DateTime.fromMillisecondsSinceEpoch(
                            controller.selectedBloodSugar.value.dateTime!),
                      ),
                      style: ThemeText.subtitle2.copyWith(
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Text(
                      DateFormat('hh:mm a',
                              appController.currentLocale.languageCode)
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              controller.selectedBloodSugar.value.dateTime!)),
                      style: ThemeText.subtitle2.copyWith(
                        color: AppColor.black,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${controller.selectedBloodSugar.value.measure}',
                      style: ThemeText.headline4.copyWith(
                          fontSize: 36.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${controller.selectedBloodSugar.value.unit}',
                      style: ThemeText.subtitle2.copyWith(
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),
                    Text(
                      "${TranslationConstants.bloodSugarState.tr}: ${bloodSugarStateDisplayMap[controller.selectedBloodSugar.value.stateCode]!}",
                      style: ThemeText.subtitle2.copyWith(
                        color: AppColor.black,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: bloodSugarInfoColorMap[
                            controller.selectedBloodSugar.value.infoCode],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: EdgeInsets.all(6.sp),
                      child: Text(
                        bloodSugarInfoDisplayMap[
                            controller.selectedBloodSugar.value.infoCode]!,
                        style: textStyle20600().copyWith(
                          color: AppColor.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    AppTouchable(
                      width: 40.0.sp,
                      height: 40.0.sp,
                      onPressed: () => controller
                          .onDeleted(controller.selectedBloodSugar.value.key!),
                      child: AppImageWidget.asset(
                        path: AppImage.ic_del,
                      ),
                    ),
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
