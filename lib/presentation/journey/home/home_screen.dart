import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/home/home_controller.dart';
import 'package:bloodpressure/presentation/journey/main/widgets/subscribe_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/disable_ glow_behavior.dart';
import '../../../common/util/translation/app_translation.dart';
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
      child: Column(children: [
        AppHeader(
          title: TranslationConstants.bloodHealth.tr,
          leftWidget: SizedBox(width: 40.0.sp),
          titleStyle: const TextStyle(fontWeight: FontWeight.w500),
          rightWidget: Obx(
            () => SubscribeButton(
                isPremiumFull: Get.find<AppController>().isPremiumFull.value),
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
                  Obx(() => NativeAdsWidget(
                      height: 240,
                      factoryId: NativeFactoryId.appNativeAdFactoryMedium,
                      isPremium: Get.find<AppController>().isPremiumFull.value
                  ),),
                  AppTouchable.common(
                    onPressed: controller.onPressHeartBeat,
                    height: 128.0.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImageWidget.asset(
                          path: AppImage.ic_heart_rate,
                          width: 60.0.sp,
                        ),
                        SizedBox(width: 13.0.sp),
                        Text(
                          TranslationConstants.heartRate.tr,
                          style: textStyle20500(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0.sp),
                  Row(
                    children: [
                      Expanded(
                        child: AppTouchable.common(
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
