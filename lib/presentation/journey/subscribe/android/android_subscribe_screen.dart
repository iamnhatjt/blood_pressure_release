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
        SubscribeButton(
          onPressed: null,
          height: 128.sp,
          child: Padding(
            padding: EdgeInsets.only(top: 16.sp, bottom: 8.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 52.sp),
                  child: Text(
                    TranslationConstants.subscribeContentAndroid6.tr,
                    style: ThemeText.bodyText1.copyWith(
                        color: AppColor.white, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "${Get.find<AppController>().productDetailMap[AppConfig.premiumIdentifierYearly]?.price ?? ''} ${TranslationConstants.perYear.tr}",
                  style: ThemeText.headline4.copyWith(color: AppColor.white),
                ),
                Text(TranslationConstants.subscribeAutoRenewable.tr,
                    style: ThemeText.caption.copyWith(color: AppColor.white)),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12.sp,
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
                      Text(
                        TranslationConstants.continues.tr,
                        style: ThemeText.headline5.copyWith(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white),
                      ),
                      SizedBox(height: 4.sp),
                      Text(
                        TranslationConstants.freeTrial.tr,
                        style: ThemeText.caption.copyWith(color: AppColor.white),
                      ),
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
