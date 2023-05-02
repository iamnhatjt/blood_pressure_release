import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:bloodpressure/common/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/constants/app_image.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/util/app_util.dart';
import '../../../../common/util/disable_glow_behavior.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../controller/app_controller.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/ios_cofig_widget/Button_ios_3d.dart';
import '../../main/widgets/subscribe_button.dart';
import '../widgets/content_widget.dart';
import '../widgets/subscribe_screen.dart';
import 'ios_subscribe_controller.dart';

class IosSubscribeScreen extends GetView<IosSubscribeController> {
  const IosSubscribeScreen({super.key});

  Widget ButtonHandleBuyingYear(
      {required isSelected,
      required Null Function() onSlect,
      required String priceType}) {
    Color color = isSelected ? Colors.white : const Color(0xFF6D6D6D);
    Color dropShawDow =
        isSelected ? const Color(0xFF43BA29) : const Color(0xFFD9D9D9);
    return GestureDetector(
      onTap: onSlect,
      child: Stack(
        children: [
          Container(
            height: 136.0.sp,
            width: 128.0.sp,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: dropShawDow,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    spreadRadius: 2),
                BoxShadow(color: Color(0xFFD9D9D9)),
                BoxShadow(
                    color: Color(0xFFFFFFFF),
                    blurRadius: 10,
                    spreadRadius: -0.1,
                    offset: Offset(0, -4)),
              ],
              gradient: isSelected
                  ? const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF68DF55), Color(0xFF31A714)])
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Spacer(flex: 1),
                Text(
                  'Yearly',
                  style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.w600,
                      color: color),
                ),
                Spacer(flex: 1),
                Text(
                  priceType,
                  style: TextStyle(
                      fontSize: 28.0.sp,
                      fontWeight: FontWeight.w600,
                      color: color),
                ),
                SizedBox(height: 8.0.sp),
                Text(
                  chooseContentByLanguage('per year', 'một năm'),
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w400,
                    color: color,
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Transform.translate(
              offset: Offset(20.0.sp, -12.0.sp),
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 6.0.sp, horizontal: 10.0.sp),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB904),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(chooseContentByLanguage('BEST OFFER', 'TỐT NHẤT'),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12.0.sp,
                      color: Colors.white,
                    )),
              ),
            ),
          ).animate(onPlay: (controller)=>controller.repeat(reverse: true, period: 3000.ms)).slide(
            begin: Offset(0, -0.3),
            end: Offset(0, 0.3),
            duration: 300.ms
          ),
        ],
      ),
    );
  }

  Widget ButtonHandleTypeBuy(
      {required title,
      required String priceType,
      required bool isSelected,
      required Null Function() onSelected,
      String? Subtitle}) {
    String text = title;
    String price = priceType;
    Color color = isSelected ? Colors.white : const Color(0xFF6D6D6D);
    Color dropShawDow =
        isSelected ? const Color(0xFF43BA29) : const Color(0xFFD9D9D9);
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0.sp),
        height: 110.0.sp,
        width: 100.0.sp,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: dropShawDow,
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 2),
            BoxShadow(color: Color(0xFFD9D9D9)),
            const BoxShadow(
                color: Color(0xFFFFFFFF),
                blurRadius: 10,
                spreadRadius: -0.1,
                offset: Offset(0, -4)),
          ],
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF68DF55), Color(0xFF31A714)])
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Spacer(flex: 1),
            Text(
              text,
              style: TextStyle(
                  fontSize: 20.0.sp, fontWeight: FontWeight.w600, color: color),
            ),
            Spacer(flex: 1),
            Text(
              price,
              style: TextStyle(
                  fontSize: 20.0.sp, fontWeight: FontWeight.w600, color: color),
            ),
            Spacer(flex: 1),
            Text(
              Subtitle ?? '',
              style: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget GroupButtonHandleTypeBuy() {


    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: AnimateList(
          interval: 300.ms,
          effects: [MoveEffect(begin: Offset(0, -4)), FadeEffect(duration: 300.ms)],
          children: [
            Obx(
                  () => ButtonHandleTypeBuy(
                title: 'Weekly',
                Subtitle: chooseContentByLanguage('per week', 'một tuần'),
                priceType:
                " ${controller.productDetailsWeek.price == '' ? '\$9.99' : controller.productDetailsWeek.price}",
                isSelected: controller.rxSelectedIdentifier.value ==
                    AppConfig.premiumIdentifierWeekly,
                onSelected: () {
                  controller
                      .onSelectedIdentifier(AppConfig.premiumIdentifierWeekly);
                },
              ),
            ),
            Obx(
                  () => ButtonHandleBuyingYear(
                      isSelected: controller.rxSelectedIdentifier.value ==
                          AppConfig.premiumIdentifierYearly,
                  priceType: controller.productDetailsYear.price == ''
                      ? '\$29.99'
                      : controller.productDetailsYear.price,
                  onSlect: () {
                    controller
                        .onSelectedIdentifier(AppConfig.premiumIdentifierYearly);
                  }),
            ),
            Obx(() {
              print('${controller.productDetailsMonth.price} ');
              return ButtonHandleTypeBuy(
                Subtitle: chooseContentByLanguage('per month', 'một Tháng'),
                title: 'Monthly',
                priceType: controller.productDetailsMonth.price == ''
                    ? '\$2.49'
                    : controller.productDetailsMonth.price,
                isSelected: controller.rxSelectedIdentifier.value ==
                    AppConfig.premiumIdentifierMonth,
                onSelected: () {
                  controller
                      .onSelectedIdentifier(AppConfig.premiumIdentifierMonth);
                },
              );
            }),
          ]
        ),
      ),
    );
  }

  Widget _groupButtonWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //test button

        GroupButtonHandleTypeBuy(),
        SizedBox(
          height: 12.0.sp,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImageWidget.asset(
              path: AppImage.iosProtectImage,
              height: 28,
            ),
            SizedBox(
              width: 12.0.sp,
            ),
            Text(TranslationConstants.subscribeAutoRenewable.tr,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF646464),
                )),
          ],
        ),
        SizedBox(
          height: 12.0.sp,
        ),
        //continue button

        Obx(
          () => Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
            child: Stack(
              children: [
                SubscribeButton(
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
                      : Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 4.0.sp),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      TranslationConstants.continues.tr,
                                      style: ThemeText.headline5.copyWith(
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.white),
                                    ),
                                    Text(
                                      '${TranslationConstants.freeTrial.tr}',
                                      style: ThemeText.caption
                                          .copyWith(color: AppColor.white),
                                    ),
                                  ],
                                ),
                              )
                            ),

                          ],
                        ),
                ),
                Container(
                  height: 60.0.sp,
                  alignment: Alignment.centerRight,
                  child: AppImageWidget.asset(path: AppImage.iosRight),
                )
              ],
            ),
          ).animate(onPlay: (controller)=> controller.repeat(reverse: true, period: 1000.ms,))
          .scale(begin: Offset(0.9, 0.9), delay: 2000.ms, duration: 500.ms ),
        )
      ],
    );
  }

  Widget _imuableElement() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImageWidget.asset(
          path: AppImage.iosPremiumImage,
          height: 160.sp,
        ),
        SizedBox(height: 20.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.sp, vertical: 12.0.sp)
              .copyWith(right: 20.0.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ContentWidget(text: TranslationConstants.removeAds.tr),
              ContentWidget(
                  text: chooseContentByLanguage(
                      'Check your inbody with BMI Calculator',
                      'Kiểm tra cơ thể của bạn với Máy tính BMI')),
              ContentWidget(
                  text: chooseContentByLanguage('Access to Blood pressure log',
                      'Truy cập Nhật ký huyết áp')),
              ContentWidget(
                  text: chooseContentByLanguage('Unlimited Heart Rate Measure',
                      'Đo nhịp tim không giới hạn')),
              ContentWidget(
                  text: chooseContentByLanguage(
                      'Track your Blood Sugar & Blood Pressure level',
                      'Theo dõi lượng đường trong máu và huyết áp của bạn')),
            ],
          ),
        ),
        SizedBox(height: 40.sp),
      ],
    );
  }

  Widget _groupButtonHandleBuy() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.sp),
        _groupButtonWidget(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SubscribeScreen(
          padding: EdgeInsets.zero,
          onRestored: controller.rxLoadedType.value == LoadedType.start
              ? null
              : controller.onRestored,
          onPressBack: controller.onPressBack,
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _imuableElement(),
                  _groupButtonHandleBuy(),
                ],
              ),
            ),
          )),
    );

    // return AppContainer(
    //   child: Column(
    //     children: [
    //       AppHeader(
    //         title: "fjfjdijf",
    //       ),
    //     ],
    //   )
    // );
  }

  String getPriceOfWeek(String price) {
    double _price = price.toDouble;

    // if (price == 0.0) price = 29.99;

    String currencyUnit = controller.productDetailsYear.currencySymbol;
    double priceOfWeek = ((_price / 52 * 100).ceil()) / 100;

    return '$priceOfWeek$currencyUnit';
  }
}
