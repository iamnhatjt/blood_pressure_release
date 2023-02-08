import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/domain/model/blood_sugar_model.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/add_blood_sugar_dialog/add_blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_screen.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/widgets/blood_sugar_info_color_listview.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/widgets/blood_sugar_information_dialog.dart';
import 'package:bloodpressure/presentation/journey/home/widget/add_data_widget.dart';
import 'package:bloodpressure/presentation/journey/home/widget/blood_text_field_widget.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_button.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_loading.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/constants/app_route.dart';
import '../../../../controller/app_controller.dart';

class BloodSugarAddDataDialog extends GetView<AddBloodSugarController> {
  final BloodSugarModel? currentBloodSugar;

  const BloodSugarAddDataDialog({super.key, this.currentBloodSugar});

  Widget _buildStateButtonWidget(BuildContext context) {
    return AppTouchable(
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
            "${TranslationConstants.bloodSugarState.tr}: ${bloodSugarStateDisplayMap[controller.rxSelectedState.value]}",
            style: textStyle18500(),
          ),
        ));
  }

  Widget _buildChangeUnitButton() {
    return AppTouchable(
        width: Get.width / 3,
        onPressed: () => controller.onPressed(controller.onChangedUnit),
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
        ));
  }

  Widget _buildCurrentInfoWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.sp),
      child: Obx(
        () => AppButton(
          onPressed: null,
          width: double.infinity,
          padding: EdgeInsets.zero,
          height: 40.sp,
          color: bloodSugarInfoColorMap[controller.rxInfoCode.value],
          text: controller.rxInformation.value,
          textSize: 20.sp,
          textColor: Colors.white,
          fontWeight: FontWeight.w600,
          radius: 10.sp,
        ),
      ),
    );
  }

  Widget _buildInfoContentWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.sp),
      height: 32.sp,
      decoration: BoxDecoration(
          color: AppColor.lightGray, borderRadius: BorderRadius.circular(9.sp)),
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
            onPressed: () => controller.onPressed(() {
              showAppDialog(
                  context,
                  "${TranslationConstants.bloodSugar.tr} ${controller.rxUnit.value}",
                  "",
                  builder: (ctx) => BloodSugarInformationDialog(
                      state: bloodSugarStateDisplayMap[
                          controller.rxSelectedState.value]!,
                      unit: controller.rxUnit.value));
            }),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    if (!isNullEmpty(currentBloodSugar)) {
      controller.onInitialData(model: currentBloodSugar);
    }
    return Stack(
      children: [
        AddDataDialog(
          rxStrDate: controller.stringBloodPrDate,
          rxStrTime: controller.stringBloodPrTime,
          onSelectDate: () =>
              controller.onPressed(controller.onSelectBloodSugarDate),
          onSelectTime: () =>
              controller.onPressed(controller.onSelectBloodSugarTime),
          isEdit: !isNullEmpty(currentBloodSugar),
          firstButtonOnPressed: () => controller.onPressed(() async {
            final appController = Get.find<AppController>();

            if (appController.isPremiumFull.value) {
              await controller.onSaved(model: currentBloodSugar);
              Get.back();
            } else {
              if (appController.userLocation.compareTo("Other") != 0) {
                final prefs = await SharedPreferences.getInstance();
                int cntAddData = prefs.getInt("cnt_add_data_blood_sugar") ?? 0;

                if (cntAddData < 2) {
                  await controller.onSaved(model: currentBloodSugar);
                  Get.back();
                  prefs.setInt("cnt_add_data_blood_sugar", cntAddData + 1);
                } else {
                  Get.toNamed(AppRoute.iosSub);
                }
              } else {
                await controller.onSaved(model: currentBloodSugar);
                Get.back();
              }
            }

            // await controller.onSaved(model: currentBloodSugar);
            // Get.back();
          }),
          secondButtonOnPressed: () => controller.onPressed(Get.back),
          child: Column(
            children: [
              SizedBox(height: 12.sp),
              _buildStateButtonWidget(context),
              SizedBox(height: 16.sp),
              SizedBox(
                width: Get.width / 3,
                height: 68.sp,
                child: Center(
                  child: BloodTextFieldWidget(
                    controller: controller.textEditController.value,
                    onChanged: () =>
                        controller.onPressed(controller.onChangedInformation),
                  ),
                ),
              ),
              SizedBox(height: 8.sp),
              _buildChangeUnitButton(),
              SizedBox(height: 60.sp),
              _buildCurrentInfoWidget(),
              SizedBox(height: 16.sp),
              _buildInfoContentWidget(context),
              SizedBox(height: 20.sp),
              const BloodSugarInfoListView(),
              SizedBox(height: 16.sp),
            ],
          ),
        ),
        Obx(() {
          if (controller.rxLoadedType.value == LoadedType.start) {
            return Container(
              color: AppColor.transparent,
              child: const AppLoading(),
            );
          } else {
            return const SizedBox();
          }
        })
      ],
    );
  }
}
