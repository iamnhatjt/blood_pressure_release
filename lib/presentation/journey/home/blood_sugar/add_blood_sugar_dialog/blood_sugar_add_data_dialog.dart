import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/add_blood_sugar_dialog/add_blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_screen.dart';
import 'package:bloodpressure/presentation/journey/home/widget/add_data_widget.dart';
import 'package:bloodpressure/presentation/journey/home/widget/blood_text_field_widget.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_button.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BloodSugarAddDataDialog extends GetView<AddBloodSugarController> {
  const BloodSugarAddDataDialog({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AddDataDialog(
      rxStrDate: controller.stringBloodPrDate,
      rxStrTime: controller.stringBloodPrTime,
      onSelectDate: controller.onSelectBloodSugarDate,
      onSelectTime: controller.onSelectBloodSugarTime,
      child: Column(
        children: [
          SizedBox(
            height: 12.sp,
          ),
          AppTouchable(
              width: double.infinity,
              onPressed: () => showStateDialog(
                  context,
                  (stateCode) => controller.onSelectState(stateCode),
                  controller.rxSelectedState),
              backgroundColor: AppColor.lightGray,
              padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
              child: Obx(
                () => Text(
                  "${TranslationConstants.bloodSugarState.tr}: ${getState(controller.rxSelectedState.value)}",
                  style: textStyle18500(),
                ),
              )),
          SizedBox(
            height: 16.sp,
          ),
          SizedBox(
            width: Get.width / 3,
            height: 68.sp,
            child: Center(
              child: BloodTextFieldWidget(
                controller: controller.textEditController.value,
                onChanged: controller.onChangedInformation,
              ),
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          AppTouchable(
              width: Get.width / 3,
              onPressed: controller.onChangedUnit,
              backgroundColor: AppColor.lightGray,
              padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Obx(
                        () => Text(
                          controller.rxUnit.value,
                          style: textStyle18500(),
                        ),
                      ),
                    ),
                  ),
                  AppImageWidget.asset(
                    path: AppImage.ic_arrow_2,
                    height: 20.sp,
                  )
                ],
              )),
          SizedBox(
            height: 60.sp,
          ),
          Obx(
            () => AppButton(
              onPressed: () {},
              width: double.infinity,
              padding: EdgeInsets.zero,
              height: 40.sp,
              color: AppColor.green,
              text: controller.rxInformation.value,
              textSize: 20.sp,
              textColor: Colors.white,
              fontWeight: FontWeight.w600,
              radius: 10.sp,
            ),
          )
        ],
      ),
    );
  }

  String getState(String code) {
    switch (code) {
      case BloodSugarStateCode.duringFastingCode:
        return TranslationConstants.duringFastingCode.tr;
      case BloodSugarStateCode.beforeEatingCode:
        return TranslationConstants.beforeEatingCode.tr;
      case BloodSugarStateCode.afterEating1hCode:
        return TranslationConstants.afterEating1hCode.tr;
      case BloodSugarStateCode.afterEating2hCode:
        return TranslationConstants.afterEating2hCode.tr;
      case BloodSugarStateCode.beforeBedtimeCode:
        return TranslationConstants.beforeBedtimeCode.tr;
      case BloodSugarStateCode.beforeWorkoutCode:
        return TranslationConstants.beforeWorkoutCode.tr;
      case BloodSugarStateCode.afterWorkoutCode:
        return TranslationConstants.afterWorkoutCode.tr;
      default:
        return TranslationConstants.bloodSugarDefaultState.tr;
    }
  }
}
