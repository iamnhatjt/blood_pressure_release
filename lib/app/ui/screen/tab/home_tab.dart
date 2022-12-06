import 'package:bloodpressure/app/controller/home_controller.dart';
import 'package:bloodpressure/app/ui/widget/app_container.dart';
import 'package:bloodpressure/app/ui/widget/app_image_widget.dart';
import 'package:bloodpressure/app/ui/widget/app_touchable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/image/app_image.dart';
import '../../../res/string/app_strings.dart';
import '../../../util/disable_ glow_behavior.dart';
import '../../widget/app_header.dart';
import '../../widget/app_style.dart';

class HomeTab extends GetView<HomeController> {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(children: [
        AppHeader(
          title: StringConstants.bloodHealth.tr,
          leftWidget: SizedBox(width: 40.0.sp),
          titleStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(17.0.sp),
              child: Column(
                children: [
                  AppTouchable.common(
                    onPressed: null,
                    margin: EdgeInsets.only(bottom: 25.0.sp),
                    height: 200.0.sp,
                    width: Get.width,
                    child: Text(
                      'ads',
                      style: textStyle20500(),
                    ),
                  ),
                  AppTouchable.common(
                    onPressed: controller.onPressHeartBeat,
                    height: 100.0.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImageWidget.asset(
                          path: AppImage.ic_heart_rate,
                          width: 60.0.sp,
                        ),
                        SizedBox(width: 13.0.sp),
                        Text(
                          StringConstants.heartRate.tr,
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
                          onPressed: () {},
                          height: 100.0.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.ic_blood_pressure,
                                width: 60.0.sp,
                              ),
                              SizedBox(height: 4.0.sp),
                              Text(
                                StringConstants.bloodPressure.tr,
                                style: textStyle18500(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0.sp),
                      Expanded(
                        child: AppTouchable.common(
                          onPressed: () {},
                          height: 100.0.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.ic_blood_sugar,
                                width: 60.0.sp,
                              ),
                              SizedBox(height: 4.0.sp),
                              Text(
                                StringConstants.bloodSugar.tr,
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
                          onPressed: () {},
                          height: 100.0.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.ic_weight_and_bmi,
                                width: 60.0.sp,
                              ),
                              SizedBox(height: 4.0.sp),
                              Text(
                                StringConstants.weightAndBMI.tr,
                                style: textStyle18500(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0.sp),
                      Expanded(
                        child: AppTouchable.common(
                          onPressed: () {},
                          height: 100.0.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.ic_qr_code,
                                width: 60.0.sp,
                              ),
                              SizedBox(height: 4.0.sp),
                              Text(
                                StringConstants.foodScanner.tr,
                                style: textStyle18500(),
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
