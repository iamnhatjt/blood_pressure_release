import 'package:bloodpressure/presentation/journey/home/heart_beat/measure/measure_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../common/constants/app_image.dart';
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
    return Column(
      key: const ValueKey<int>(1),
      children: [
        Expanded(
          child: Center(
            child: AppImageWidget.asset(
              path: AppImage.heart_rate_lottie,
              width: Get.width / 3,
              height: Get.width / 3,
            ),
          ),
        ),
        AppTouchable.common(
          onPressed: controller.onPressStartMeasure,
          height: 70.0.sp,
          backgroundColor: AppColor.green,
          margin: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImageWidget.asset(
                path: AppImage.ic_heart_rate,
                width: 60.0.sp,
              ),
              SizedBox(width: 8.0.sp),
              Text(
                TranslationConstants.measureNow.tr,
                style: textStyle24700(),
              ),
            ],
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
                        // Obx(
                        //   () => Text(
                        //     '${controller.bpmAverage.value}',
                        //     style: TextStyle(
                        //       color: AppColor.red,
                        //       fontSize: sizeCircle / 3,
                        //       fontWeight: FontWeight.w700,
                        //       height: 5 / 4,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 7.0.sp),
                        // Text(
                        //   'BPM',
                        //   style: TextStyle(
                        //     color: AppColor.red,
                        //     fontSize: 30.0.sp,
                        //     fontWeight: FontWeight.w500,
                        //     height: 37.5 / 30,
                        //   ),
                        // ),
                        AppImageWidget.asset(
                          path: AppImage.heart_rate_lottie,
                          width: sizeCircle / 3 * 2,
                          height: sizeCircle / 3 * 2,
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
        AppTouchable.common(
          onPressed: controller.onPressStopMeasure,
          height: 70.0.sp,
          width: Get.width,
          backgroundColor: AppColor.red,
          margin: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
          child: Text(
            TranslationConstants.stop.tr,
            style: textStyle24700(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      child: Column(children: [
        AppHeader(title: TranslationConstants.measure.tr),
        Expanded(
          child: Obx(() {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: controller.currentMeasureScreenState.value == MeasureScreenState.measuring
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
