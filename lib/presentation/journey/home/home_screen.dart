import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_screen.dart';
import 'package:bloodpressure/presentation/journey/home/home_controller.dart';
import 'package:bloodpressure/presentation/journey/main/widgets/subscribe_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/disable_glow_behavior.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../theme/app_color.dart';
import '../../theme/theme_text.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/ios_cofig_widget/app_header_component_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget eachItemHomePage({
      required Function() onPress,
      required List<Color> listColor,
      required String pathIcon,
      required text,
    }) {
      return GestureDetector(
        onTap: onPress,
        child: Container(
          height: 100.0.sp,
          margin: EdgeInsets.only(bottom: 20.0.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: listColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0.sp),
                child: AppImageWidget.asset(
                  path: pathIcon,
                  height: 80.0.sp,
                ),
              ),
              Expanded(
                  child: Center(
                child: Text(
                  text,
                  style: IosTextStyle.f18w700w,
                ),
              ))
            ],
          ),
        ),
      );
    }

    Widget RowItemHomePage({
      required Function() onPress,
      List<Color> listColor = AppColorIOS.gradientbottomHomPage,
      required String pathIcon,
      required text,
    }) {
      return GestureDetector(
        onTap: onPress,
        child: Container(
          height: 120.0.sp,
          width: 108.0.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: listColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 12.0.sp,
              ),
              AppImageWidget.asset(
                path: pathIcon,
                height: 56.0.sp,
              ),
              // SizedBox(height: 8.0.sp,),

              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: IosTextStyle.f18w700w,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return AppContainer(
      isShowBanner: true,
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AppImage.iosBackgroundHomePage),
          fit: BoxFit.cover,
        )),
        child: AppContainer(
          backgroundColor: Colors.transparent,
          isShowBanner: false,
          child: Column(children: [
            AppHeader(
              title: 'Blood & Health',
              leftWidget: const IosLeftHeaderWidget(isHome: true),
              titleStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              rightWidget: const IosRightHeaderWidget(),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: DisableGlowBehavior(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 28.0.sp, vertical: 12.0.sp),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: controller.onPressHeartBeat,
                        child: Container(
                          margin: EdgeInsets.only(top: 12.0.sp, bottom: 28.0.sp),
                          height: 148.0.sp,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: AppColorIOS.gradientHeartRate,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.iosHeartBeat,
                                height: 80.0.sp,
                              ),
                              SizedBox(
                                height: 12.0.sp,
                              ),
                              Text(
                                TranslationConstants.heartRate.tr,
                                style: IosTextStyle.f18w700w,
                              )
                            ],
                          ),
                        ),
                      ),

                      eachItemHomePage(
                          text: TranslationConstants.weightAndBMI.tr,
                          listColor: AppColorIOS.gradientWeightBMI,
                          onPress: controller.onPressWeightAndBMI,
                          pathIcon: AppImage.iosWeightBMI),

                      eachItemHomePage(
                          text: TranslationConstants.bloodSugar.tr,
                          listColor: AppColorIOS.gradientBloodSugar,
                          onPress: controller.onPressBloodSugar,
                          pathIcon: AppImage.iosBloodSugar),

                      eachItemHomePage(
                          text: TranslationConstants.bloodPressure.tr,
                          listColor: AppColorIOS.gradientBloodPressure,
                          onPress: controller.onPressBloodPressure,
                          pathIcon: AppImage.iosBloodPressure),

                      SizedBox(
                        height: 30.0.sp,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowItemHomePage(
                              onPress: controller.onPressFoodScanner,
                              pathIcon: AppImage.iosQR,
                              text: TranslationConstants.foodScanner.tr),
                          RowItemHomePage(
                              onPress: () {
                                Get.toNamed(AppRoute.insight);
                              },
                              pathIcon: AppImage.iosInsight,
                              text: TranslationConstants.insights.tr),
                          RowItemHomePage(
                              onPress: () {
                                Get.to(const AlarmScreen());
                              },
                              pathIcon: AppImage.iosAlarm,
                              text: TranslationConstants.alarm.tr)
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
