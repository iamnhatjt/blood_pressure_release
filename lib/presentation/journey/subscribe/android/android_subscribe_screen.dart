import 'package:bloodpressure/common/config/app_config.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/subscribe/android/android_subscribe_controller.dart';
import 'package:bloodpressure/presentation/journey/subscribe/widgets/content_widget.dart';
import 'package:bloodpressure/presentation/journey/subscribe/widgets/subscribe_button.dart';
import 'package:bloodpressure/presentation/journey/subscribe/widgets/subscribe_screen.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AndroidSubscribeScreen extends GetView<AndroidSubscribeController> {
  const AndroidSubscribeScreen({super.key});

  Widget _groupButtonWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 100.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               Text("PAY ONCE FOR LIFETIME ACCESS",
                    style:ThemeText.headline6.copyWith(
                        color: AppColor.green,
                        fontWeight: FontWeight.w600
                    ),
                ),
                SizedBox(
                  height: 3.sp,
                ),
                Text(
                  "ONLY ${Get.find<AppController>().productDetailMap[AppConfig.premiumIdentifierAndroid]?.price ?? ''}",
                  style: ThemeText.headline4.copyWith(
                      color: AppColor.green,
                      fontWeight: FontWeight.w600),
                )],
          ),
        ),
        SizedBox(
          height: 8.sp,
        ),
        Obx(
        () => SubscribeButton(
            onPressed: Get.find<AppController>().rxPurchaseStatus.value ==
                    PurchaseStatus.pending
                ? null
                : controller.onSubscribed,
            child: Get.find<AppController>().rxPurchaseStatus.value ==
                    PurchaseStatus.pending
                ? SizedBox(
                    height: 32.sp,
                    width: 32.sp,
                    child: CircularProgressIndicator(
                      color: AppColor.white,
                      strokeWidth: 2.sp,
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(height: 6.sp),
                      Text(
                        TranslationConstants.continues.tr,
                        style: ThemeText.headline5.copyWith(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white),
                      )
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubscribeScreen(
        onRestored: controller.rxLoadedType.value == LoadedType.start
            ? null
            : controller.onRestored,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ContentWidget(
                    text: TranslationConstants.subscribeContentAndroid1.tr),
                ContentWidget(
                    text: TranslationConstants.subscribeContentAndroid2.tr),
                ContentWidget(
                    text: TranslationConstants.subscribeContentAndroid3.tr),
                ContentWidget(
                    text: TranslationConstants.subscribeContentAndroid4.tr),
                ContentWidget(
                    text: TranslationConstants.subscribeContentAndroid5.tr),
              ],
            ),
            _groupButtonWidget(),
            const SizedBox(),
          ],
        ));
  }
}
