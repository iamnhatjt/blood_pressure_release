import 'dart:io';

import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/home/heart_beat/heart_beat_controller.dart';
import 'package:bloodpressure/presentation/journey/home/heart_beat/measure/measure_controller.dart';
import 'package:bloodpressure/presentation/journey/home/home_binding.dart';
import 'package:bloodpressure/presentation/journey/home/home_controller.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:bloodpressure/presentation/widget/native_ads_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../common/constants/app_image.dart';
import '../../../../../common/util/app_util.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/app_container.dart';
import '../../../../widget/app_header.dart';
import '../../../../widget/app_image_widget.dart';
import '../../../../widget/app_touchable.dart';
import '../../../../widget/heart_bpm.dart';

class MeasureScreen extends GetView<MeasureController> {
  const MeasureScreen({Key? key}) : super(key: key);

  Widget _buildStateIdle() {
    String tutorialPath = AppImage.heart_rate_tutorial_android;
    if (Platform.isIOS) {
      tutorialPath = AppImage.heart_rate_tutorial_ios;
    }
    return Column(
      key: const ValueKey<int>(1),
      children: [
        Expanded(
          child: Column(
            children: [
              Obx(
                () {
                  if (Get.find<AppController>().isPremiumFull.value) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox.shrink();
                  // return NativeAdsWidget(
                  //     factoryId: NativeFactoryId.appNativeAdFactorySmall,
                  //     isPremium: Get.find<AppController>().isPremiumFull.value);
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
                  child: Center(
                    child: AppImageWidget.asset(
                      path: AppImage.iosGuide,
                    ),
                  ),
                ),
              ),
              Obx(
                () {
                  if (Get.find<AppController>().isPremiumFull.value) {
                    return const SizedBox.shrink();
                  }
                  return  const SizedBox.shrink();
                  // return NativeAdsWidget(
                  //     factoryId: NativeFactoryId.appNativeAdFactorySmall,
                  //     isPremium: Get.find<AppController>().isPremiumFull.value);
                },
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ButtonIos3D(
                  radius: 20,
                  onPress: controller.onPressStartMeasure,
                  height: 70.0.sp,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColorIOS.gradientWeightBMI,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    height: double.infinity,
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 50,
                          width: 50,
                        ),
                        Expanded(
                            child: Center(
                          child: Text(TranslationConstants.measureNow.tr,
                              style: IosTextStyle.f18w700w.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 24)),
                        ))
                      ],
                    ),
                  )),
            ),
            Positioned(
              top: 8.0.sp,
              left: 30.0.sp,
              child: AppImageWidget.asset(
                path: AppImage.iosHeartBeat,
                height: 52.0.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStateMeasure2(BuildContext context) {
    double sizeCircle = Get.width / 1.725;
    return Column(
      key: const ValueKey<int>(0),
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => CircularPercentIndicator(
                    animation: true,
                    animationDuration: 200,
                    radius: sizeCircle / 2,
                    lineWidth: 10.0.sp,
                    percent: controller.progress.value < 0.0
                        ? 0.0
                        : controller.progress.value > 1.0
                            ? 1.0
                            : controller.progress.value,
                    circularStrokeCap: CircularStrokeCap.round,
                    animateFromLastPercent: true,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
                          child: AppImageWidget.asset(
                            path: AppImage.heart_rate_lottie,
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: AppColor.gray,
                    progressColor: AppColor.red,
                  )),
              SizedBox(height: 30.0.sp),
              Obx(() => Text(
                    '${TranslationConstants.measuring.tr} (${(controller.progress.value * 100).toInt()}%)',
                    style: textStyle20500(),
                  )),
              SizedBox(height: 2.0.sp),
              Text(
                TranslationConstants.placeYourFinger.tr,
                style: textStyle18400(),
              ),
              SizedBox(height: 27.0.sp),
              HeartBPMDialog(
                context: context,
                onBPM: controller.onBPM,
                onRawData: controller.onRawData,
                alpha: 0.5,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
          child: ButtonIos3D(
            onPress: controller.onPressStopMeasure,
            height: 70.0.sp,
            width: Get.width,
            backgroundColor: const Color(0xFFFF6464),
            innerColor: Colors.black.withOpacity(0.15),
            child: Center(
              child: Text(
                TranslationConstants.stop.tr,
                style: textStyle24700(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStateMeasure(BuildContext context) {
    double sizeCircle = Get.width / 1.725;
    return Column(
      key: const ValueKey<int>(0),
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 20.0.sp,
                          color: Color(0xFFFFDBDB),
                        ),
                      ),
                      child: InnerShadow(
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(2, -6)),
                        ],
                        child: Container(
                          margin: EdgeInsets.all(2.0.sp),

                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.2),
                                    blurRadius: 10.0,
                                    spreadRadius: -1),
                              ],
                              border: Border.all(
                                  width: 20.0.sp, color: Colors.white)),
                          child: CircularPercentIndicator(
                            animation: true,
                            animationDuration: 200,
                            radius: sizeCircle / 2,
                            lineWidth: 10.0.sp,
                            percent: controller.progress.value < 0.0
                                ? 0.0
                                : controller.progress.value > 1.0
                                    ? 1.0
                                    : controller.progress.value,
                            circularStrokeCap: CircularStrokeCap.round,
                            animateFromLastPercent: true,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      17.0.sp, 0, 17.0.sp, 0),
                                  child: Obx(() => Column(children: [
                                        Text(
                                          ' ${(controller.progress.value * 100).toInt()}%',
                                          style: textStyle20500().copyWith(
                                              fontSize: 50,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFFFF6464)),
                                        ),
                                        Text(
                                          '${TranslationConstants.measuring.tr}. . .',
                                          style: const TextStyle(
                                            color: Color(0xFFFF6464),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ])),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            progressColor: const Color(0xFFFF6464),
                          ),
                        ),
                      ),
                    )),
                Transform.translate(
                  offset: Offset(0.0, -12.0.sp),
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 8.0.sp,
                        left: 8.0.sp,
                        bottom: 8.0.sp,
                        top: 32.0.sp),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDBDB),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0.sp),
                        bottomLeft: Radius.circular(40.0.sp),
                      ),
                    ),
                    child: HeartBPMDialog(
                      context: context,
                      onBPM: controller.onBPM,
                      onRawData: controller.onRawData,
                      alpha: 0.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0.sp,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.0.sp),
                  child: Text(
                    chooseContentByLanguage(
                        'Place your finger on camera \n to measure your heart rate',
                        'Đặt ngón tay của bạn trên máy \n ảnh để đo nhịp tim của bạn'),
                    style: textStyle18400().copyWith(
                        color: const Color(0xFF6C6C6C), height: 22 / 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 27.0.sp),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
          child: ButtonIos3D(
            onPress: controller.onPressStopMeasure,
            height: 70.0.sp,
            width: Get.width,
            backgroundColor: const Color(0xFFFF6464),
            innerColor: Colors.black.withOpacity(0.15),
            child: Center(
              child: Text(
                TranslationConstants.stop.tr,
                style: textStyle24700(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      isShowBanner: false,
      child: Column(children: [
        AppHeader(
          titleStyle: IosTextStyle.StyleHeaderApp,
          title: TranslationConstants.heartRate.tr,
          leftWidget: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.heartBeatScreen);
              },
              child: AppImageWidget.asset(
                path: AppImage.iosBack,
                height: 40.0.sp,
              )),
        ),
        Expanded(
          child: Obx(() {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: controller.currentMeasureScreenState.value ==
                      MeasureScreenState.measuring
                  ? _buildStateMeasure(context)
                  : _buildStateIdle(),
            );
          }),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 17.0.sp),
      ]),
    );
  }
}
