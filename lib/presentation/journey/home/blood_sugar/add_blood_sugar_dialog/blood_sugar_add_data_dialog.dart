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
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.sp),
      child: ButtonIos3D.WhiteButtonUsal(
          radius: 10,
          width: double.infinity,
          onPress: () => showStateDialog(
              context,
              (stateCode) => controller.onSelectState(stateCode),
              controller.rxSelectedState),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.sp,
            ),
            child: Center(
              child: Obx(
                () => Text(
                  "${TranslationConstants.bloodSugarState.tr}: ${bloodSugarStateDisplayMap[controller.rxSelectedState.value]}",
                  style: textStyle16500().copyWith(color: const Color(0xFF646464)),
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildChangeUnitButton() {
    return ButtonIos3D.WhiteButtonUsal(
        radius: 10,
        width: Get.width / 3,
        onPress: () => controller.onPressed(controller.onChangedUnit),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 8.0.sp),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImageWidget.asset(
                    path: AppImage.iosUpAge,
                    height: 10.sp,
                  ),
                  SizedBox(
                    height: 2.0.sp,
                  ),
                  AppImageWidget.asset(
                    path: AppImage.iosDownAge,
                    height: 10.sp,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildCurrentInfoWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Obx(
          () => ButtonIos3D.onlyInner(
            innerColor: Colors.black.withOpacity(0.15),
              offsetInner: Offset.zero,
              width: double.infinity,
              backgroundColor:
                  bloodSugarInfoColorMap[controller.rxInfoCode.value],
              // text: controller.rxInformation.value,
              radius: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0.sp),
                  child: Center(
                    child: Text(
                controller.rxInfoCode.value,
                style: TextStyle(
                      color: bloodSugarInfoColorTextMap[controller.rxInfoCode.value],
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
              ),
                  ))),
        ));
  }

  Widget _buildInfoContentWidget(BuildContext context) {
    return ButtonIos3D.WhiteButtonUsal(
      radius: 10,
      width: 252.0.sp,
      // height: 32.sp,
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
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xFF656565)),
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
              Stack(
                children: [
                  ButtonIos3D.onlyInner(
                    backgroundColor: Colors.white,
                    innerColor: const Color(0xFF89C7FF),
                    radius: 16,
                    offsetInner: const Offset(0, 0),
                    height: 128.0.sp,
                    width: 150.0.sp,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0.sp),
                          child: _buildChangeUnitButton(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 128.0.sp,
                    width: 150.0.sp,
                    child: Container(
                      margin: EdgeInsets.only(top: 50.0.sp),
                      child: BloodTextFieldWidget(
                        controller: controller.textEditController.value,
                        onChanged: () => controller
                            .onPressed(controller.onChangedInformation),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.sp),
              SizedBox(height: 60.sp),
              _buildCurrentInfoWidget(),
              SizedBox(height: 16.sp),
              _buildInfoContentWidget(context),
              SizedBox(height: 20.sp),
              // const BloodSugarInfoListView(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTouchable(
                    onPressed: controller.onPressedAge,
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0.sp, horizontal: 12.0.sp),
                    child: Obx(() => Text(
                      '${TranslationConstants.age.tr}: ${controller.age.value}',
                      style: textStyle18400().merge(const TextStyle(
                        shadows: [
                          Shadow(
                              color: AppColor.grayText2,
                              offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.grayText2,
                      )),
                    )),
                  ),
                  SizedBox(width: 12.0.sp),
                  AppTouchable(
                    onPressed: controller.onPressGender,
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0.sp, horizontal: 12.0.sp),
                    child: Obx(() {
                      return Text(
                        chooseContentByLanguage(controller.gender['nameEN'],
                            controller.gender['nameVN']),
                        style: textStyle18400().merge(const TextStyle(
                          shadows: [
                            Shadow(
                                color: AppColor.grayText2,
                                offset: Offset(0, -5))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.grayText2,
                        )),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 40.0.sp ,)
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
