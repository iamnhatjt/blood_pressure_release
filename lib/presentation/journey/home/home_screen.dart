import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/home_controller.dart';
import 'package:bloodpressure/presentation/journey/main/widgets/subscribe_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/disable_glow_behavior.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../theme/app_color.dart';
import '../../theme/theme_text.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import '../../widget/native_ads_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      isShowBanner: false,
      child: Column(children: [
        AppHeader(
          title: TranslationConstants.bloodHealth.tr,
          leftWidget: SizedBox(width: 40.0.sp),
          titleStyle: const TextStyle(fontWeight: FontWeight.w500),
          rightWidget: Obx(
            () => SubscribeButton(isPremiumFull: Get.find<AppController>().isPremiumFull.value),
          ),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(17.0.sp),
              child: Column(
                children: [
                  // AppTouchable.common(
                  //   onPressed: controller.onPressHeartBeat,
                  //   height: 128.0.sp,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       AppImageWidget.asset(
                  //         path: AppImage.ic_heart_rate,
                  //         width: 60.0.sp,
                  //       ),
                  //       SizedBox(width: 13.0.sp),
                  //       Text(
                  //         TranslationConstants.heartRate.tr,
                  //         style: textStyle20500(),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.2,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          colors: [Color(0xFFFC8D8D), Color(0xFFC53535)],
                          begin: Alignment(-1.0, -4.0),
                          end: Alignment(1.0, 4.0),
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
                            child: Stack(
                              children: [
                                LottieBuilder.asset(AppImage.heartScan),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: LottieBuilder.asset(AppImage.heartRate, width: 80.0.sp, height: 70.0.sp))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  TranslationConstants.heartRate.tr,
                                  style: TextStyle(
                                    fontSize: 20.0.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.white,
                                  ),
                                ),
                                SizedBox(height: 12.0.sp),
                                Text(
                                  TranslationConstants.descriptionHeartRate.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppColor.white,
                                  ),
                                ),
                                SizedBox(height: 12.0.sp),
                                AppTouchable.common(
                                  onPressed: controller.onPressHeartBeat,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.0.sp, horizontal: 30.0.sp),
                                    child: Text(
                                      TranslationConstants.heartRateButton.tr,
                                      style: TextStyle(
                                        fontSize: 20.0.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFC73838),
                                        height: 25 / 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0.sp),
                  Obx(() {
                    return Get.find<AppController>().isPremiumFull.value
                        ? const SizedBox.shrink()
                        : NativeAdsWidget(
                            factoryId: NativeFactoryId.appNativeAdFactorySmall,
                            isPremium: Get.find<AppController>().isPremiumFull.value,
                            height: 120.0.sp,
                          );
                  }),
                  SizedBox(height: 16.0.sp),
                  Row(
                    children: [
                      Expanded(
                        child: AppTouchable.common(
                          backgroundColor: const Color(0xFF97C7FF),
                          onPressed: controller.onPressBloodPressure,
                          height: 128.0.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.ic_blood_pressure,
                                width: 60.0.sp,
                              ),
                              SizedBox(height: 4.0.sp),
                              Text(
                                TranslationConstants.bloodPressure.tr,
                                style: textStyle18500(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0.sp),
                      Expanded(
                        child: AppTouchable.common(
                          backgroundColor: const Color(0xFFBA8FFF),
                          onPressed: controller.onPressBloodSugar,
                          height: 128.0.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.ic_blood_sugar,
                                width: 60.0.sp,
                              ),
                              SizedBox(height: 4.0.sp),
                              Text(
                                TranslationConstants.bloodSugar.tr,
                                style: textStyle18500(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0.sp),
                  Row(
                    children: [
                      Expanded(
                        child: AppTouchable.common(
                          backgroundColor: const Color(0xFF6DB80D),
                          onPressed: controller.onPressWeightAndBMI,
                          height: 128.0.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.ic_weight_and_bmi,
                                width: 60.0.sp,
                              ),
                              SizedBox(height: 4.0.sp),
                              Text(
                                TranslationConstants.weightAndBMI.tr,
                                style: textStyle18500(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0.sp),
                      Expanded(
                        child: AppTouchable.common(
                          backgroundColor: const Color(0xFFFFEFC6),
                          onPressed: controller.onPressFoodScanner,
                          height: 128.0.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.ic_qr_code,
                                width: 60.0.sp,
                              ),
                              SizedBox(height: 4.0.sp),
                              Text(
                                TranslationConstants.foodScanner.tr,
                                style: textStyle18500(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
