import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/add_blood_sugar_dialog/add_blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_screen.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/widgets/blood_sugar_information_dialog.dart';
import 'package:bloodpressure/presentation/journey/home/widget/add_data_widget.dart';
import 'package:bloodpressure/presentation/journey/home/widget/blood_text_field_widget.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_button.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
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
              margin: EdgeInsets.symmetric(horizontal: 6.sp),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.sp),
            child: Obx(
              () => AppButton(
                onPressed: null,
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
            ),
          ),
          SizedBox(
            height: 16.sp,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 22.sp),
            height: 32.sp,
            decoration: BoxDecoration(
                color: AppColor.lightGray,
                borderRadius: BorderRadius.circular(9.sp)),
            child: Row(
              children: [
                SizedBox(
                  width: 32.sp,
                ),
                Expanded(
                    child: Center(
                        child: Obx(
                  () => Text(
                    "${controller.rxInfoContent.value ?? ''} ${controller.rxUnit.value}",
                    style: ThemeText.bodyText1,
                  ),
                ))),
                AppTouchable(
                  onPressed: () {
                    showAppDialog(
                        context,
                        "${TranslationConstants.bloodSugar.tr} ${controller.rxUnit.value}",
                        "",
                        builder: (ctx) => BloodSugarInformationDialog(
                            state: getState(controller.rxSelectedState.value),
                            unit: controller.rxUnit.value));
                  },
                  width: 32.sp,
                  height: 32.sp,
                  child: Icon(
                    Icons.info_outline,
                    size: 18.0.sp,
                    color: AppColor.black,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
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
