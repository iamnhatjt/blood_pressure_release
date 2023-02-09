import 'package:bloodpressure/common/config/app_config.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/common/extensions/string_extension.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/journey/subscribe/ios/ios_subscribe_controller.dart';
import 'package:bloodpressure/presentation/journey/subscribe/widgets/content_widget.dart';
import 'package:bloodpressure/presentation/journey/subscribe/widgets/subscribe_button.dart';
import 'package:bloodpressure/presentation/journey/subscribe/widgets/subscribe_screen.dart';
import 'package:bloodpressure/presentation/theme/app_color.dart';
import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:bloodpressure/presentation/widget/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../common/util/disable_glow_behavior.dart';

class IosSubscribeScreen extends GetView<IosSubscribeController> {
  const IosSubscribeScreen({super.key});

  Widget _selectedSubscribeButton({required String title, String? content, bool? isSelected, Function()? onSelected}) {
    return SubscribeButton(
        height: 52.sp,
        onPressed: onSelected,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: ThemeText.headline5.copyWith(color: AppColor.white, fontWeight: FontWeight.w500)),
                  !isNullEmpty(content)
                      ? Text(content!, style: ThemeText.caption.copyWith(color: AppColor.white, fontWeight: FontWeight.w500))
                      : const SizedBox(),
                ],
              ),
              AppImageWidget.asset(
                path: isSelected == true ? AppImage.ic_select : AppImage.ic_unselect,
                height: 20.sp,
                width: 20.sp,
              )
            ],
          ),
        ));
  }

  Widget _groupButtonWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 48.sp, right: 28.sp),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.sp, right: 20.sp),
                child: Obx(
                  () => _selectedSubscribeButton(
                      isSelected: controller.rxSelectedIdentifier.value == AppConfig.premiumIdentifierYearly,
                      onSelected: () {
                        controller.onSelectedIdentifier(AppConfig.premiumIdentifierYearly);
                      },
                      title:
                          "   ${controller.productDetailsYear.price == '' ? '\$29.99' : controller.productDetailsYear.price} ${TranslationConstants.perYear.tr}",
                      // content:
                      //     "     ${TranslationConstants.only.tr} ${getPriceOfWeek(controller.productDetailsYear.price == '' ? '29.99' : controller.productDetailsYear.price)} ${TranslationConstants.perWeek.tr}"
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(4.sp),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(3.sp),
                      boxShadow: const [BoxShadow(color: AppColor.green, blurRadius: 10)]),
                  child: Text(
                    TranslationConstants.bestOffer.tr,
                    style: ThemeText.caption.copyWith(fontWeight: FontWeight.w500, color: AppColor.green),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.sp),
          child: Obx(
            () => _selectedSubscribeButton(
                isSelected: controller.rxSelectedIdentifier.value == AppConfig.premiumIdentifierWeekly,
                onSelected: () {
                  controller.onSelectedIdentifier(AppConfig.premiumIdentifierWeekly);
                },
                title:
                    "   ${controller.productDetailsWeek.price == '' ? '\$4.99' : controller.productDetailsWeek.price} ${TranslationConstants.perWeek.tr}"),
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.sp),
          child: Obx(
            () => SubscribeButton(
              onPressed: Get.find<AppController>().rxPurchaseStatus.value == PurchaseStatus.pending
                  ? null
                  : controller.onSubscribed,
              child: Get.find<AppController>().rxPurchaseStatus.value == PurchaseStatus.pending
                  ? SizedBox(
                      height: 32.sp,
                      width: 32.sp,
                      child: CircularProgressIndicator(
                        color: AppColor.white,
                        strokeWidth: 2.sp,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TranslationConstants.continues.tr,
                          style: ThemeText.headline5
                              .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w500, color: AppColor.white),
                        ),
                        Text(
                          TranslationConstants.freeTrial.tr,
                          style: ThemeText.caption.copyWith(color: AppColor.white),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SubscribeScreen(
          padding: EdgeInsets.zero,
          onRestored: controller.rxLoadedType.value == LoadedType.start ? null : controller.onRestored,
          onPressBack: controller.onPressBack,
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 24.sp),
                  AppImageWidget.asset(
                    path: AppImage.subscribeImg,
                    height: 153.sp,
                  ),
                  SizedBox(height: 12.sp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ContentWidget(text: TranslationConstants.subscribeContentIos1.tr),
                        ContentWidget(text: TranslationConstants.subscribeContentIos2.tr),
                        ContentWidget(text: TranslationConstants.subscribeContentIos3.tr),
                        ContentWidget(text: TranslationConstants.subscribeContentIos4.tr),
                        ContentWidget(text: TranslationConstants.subscribeContentIos5.tr),
                        ContentWidget(text: TranslationConstants.subscribeContentIos6.tr),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 8.sp),
                      Text(TranslationConstants.subscribeAutoRenewable.tr, style: ThemeText.bodyText1),
                      SizedBox(height: 8.sp),
                      _groupButtonWidget(),
                      SizedBox(height: 16.sp),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                        child: Text(
                          TranslationConstants.descriptionSub.trParams({
                            "priceOfWeek":
                                controller.productDetailsWeek.price == '' ? '\$4.99' : controller.productDetailsWeek.price,
                            "priceOfYear":
                                controller.productDetailsYear.price == '' ? '\$29.99' : controller.productDetailsWeek.price,
                          }),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.sp),
                    ],
                  ),
                  const SizedBox()
                ],
              ),
            ),
          )),
    );
  }

  String getPriceOfWeek(String price) {
    double _price = price.toDouble;

    // if (price == 0.0) price = 29.99;

    String currencyUnit = controller.productDetailsYear.currencySymbol;
    double priceOfWeek = ((_price / 52 * 100).ceil()) / 100;

    return '$priceOfWeek$currencyUnit';
  }
}
