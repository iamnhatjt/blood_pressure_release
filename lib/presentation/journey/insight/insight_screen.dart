import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/insight/insight_controller.dart';
import 'package:bloodpressure/presentation/journey/insight/insight_details_screen.dart';
import 'package:bloodpressure/presentation/journey/main/widgets/subscribe_button.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_container.dart';
import 'package:bloodpressure/presentation/widget/app_header.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:bloodpressure/presentation/widget/app_touchable.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:bloodpressure/presentation/widget/native_ads_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InsightScreen extends GetView<InsightController> {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      isShowBanner: false,
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.insights.tr,
            leftWidget: const IosLeftHeaderWidget(),
            rightWidget: const IosRightHeaderWidget(),
            titleStyle: IosTextStyle.StyleHeaderApp,
          ),
          NativeAdsWidget(
            factoryId: NativeFactoryId.appNativeAdFactorySmall,
            isPremium: Get.find<AppController>().isPremiumFull.value,
            height: 120.0.sp,
          ),
          Obx(() {
            return Get.find<AppController>().isPremiumFull.value
                ? const SizedBox.shrink()
                : NativeAdsWidget(
              factoryId: NativeFactoryId.appNativeAdFactorySmall,
              isPremium: Get.find<AppController>().isPremiumFull.value,
              height: 120.0.sp,
            );
          }),
          Expanded(
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero.copyWith(bottom: 16.0.sp),
                  itemCount: controller.insightList.value.length,
                  itemBuilder: (context, index) {
                    final content = controller.insightList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.0.sp, vertical: 16.0.sp)
                          .copyWith(bottom: 0),
                      child: ButtonIos3D(
                        onPress: () {
                          Get.to(
                            () => InsightDetails(
                              title: content["title"],
                              iconPath: content["icon"],
                              contents:
                                  (content["content"] as List).cast<String>(),
                            ),
                          );
                        },

                        width: Get.width,
                        child: Container(

                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0.sp, vertical: 28.0.sp),
                          child: Row(
                            children: [
                              AppImageWidget.asset(
                                  path: content["icon"], width: 50.0.sp),
                              SizedBox(
                                width: 14.0.sp,
                              ),
                              Expanded(
                                child: Text(
                                  content["title"],
                                  style: textStyle20700().copyWith(
                                    color: const Color(0xFF606060),
                                  ),
                                  maxLines: null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
