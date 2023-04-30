import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/Button_ios_3d.dart';
import 'package:bloodpressure/presentation/widget/ios_cofig_widget/app_header_component_widget.dart';
import 'package:bloodpressure/presentation/widget/native_ads_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/constants/app_route.dart';
import '../../../common/util/app_util.dart';
import '../../../common/util/disable_glow_behavior.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../theme/theme_text.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_loading.dart';
import '../../widget/app_touchable.dart';
import 'setting_controller.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({Key? key}) : super(key: key);

  Widget _buildItemMore({Function()? onPressed, String? asset, String? title, String? subTitle}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0.sp, horizontal: 12.0.sp),

      child: ButtonIos3D(
        onPress: onPressed,
        innerColor: const Color(0xFF000000).withOpacity(0.15),
        dropColor: const Color(0xFF000000).withOpacity(0.25),
        offsetInner: Offset(0,-2),
        offsetDrop: Offset(0,1),

        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0.sp, horizontal: 12.0.sp),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0.sp),
                child: Image.asset(
                  asset ?? '',
                  width: 48.0.sp,
                ),
              ),
              SizedBox(width: 6.0.sp),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      style: textStyle16400(),
                    ),
                    Text(
                      subTitle ?? '',
                      style: textStyle14400(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemSetting(Function() onPressed, String imagePath, String text, {bool isLanguage = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0.sp, left: 20.0.sp, right: 20.0.sp),
      child: Stack(
        children: [
          ButtonIos3D(

            onPress: onPressed,
            width: Get.width,
            height: 48.0.sp,
            radius: 10,
            child: Row(
              children: [
                imagePath.isEmpty
                    ? const SizedBox.shrink()
                    : SizedBox(

                        width: 72.0.sp,
                      ),
                Expanded(
                  child: Text(
                    text,
                    style: textStyle18400(),
                  ),
                ),
                isLanguage
                    ? Obx(() {
                        return Row(
                          children: [
                            Text(
                              controller.currentLanguageCode.value == "vi" ? "Vie" : "Eng",
                              style: textStyle18400(),
                            ),
                            SizedBox(width: 12.sp),
                          ],
                        );
                      })
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0.sp,horizontal: 16.0.sp),
            child:  AppImageWidget.asset(
      path: imagePath,
      width: 40.0.sp,
      fit: BoxFit.contain,
      ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {

    Widget _unlockAllFeature() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
        margin: EdgeInsets.symmetric(
          horizontal: 16.0.sp,

        ).copyWith(top: 12.0.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0.sp),
            image: const DecorationImage(
                image: AssetImage(AppImage.ios_unlock_screen),
                fit: BoxFit.cover
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 10.0.sp,
                  offset: const Offset(0, 0))
            ]),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0,1),
                          color: Colors.black.withOpacity(0.15)
                      )
                    ]
                ),
                child: Text(
                    TranslationConstants.bloodPressure.tr,
                    style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,)
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0,1),
                          color: Colors.black.withOpacity(0.15)
                      )
                    ]
                ),
                child: Text(
                  chooseContentByLanguage('Unlock all Features', 'Mở khóa tất cả tính năng'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0.sp,
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoute.iosSub),

                child: Container(
                  height: 34.0.sp,
                  width: 151.0.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF5298EB),

                  ),
                  child: Center(
                      child: Text(
                        chooseContentByLanguage('Join Now', 'Tham gia ngay'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ),
              )
            ],
          ),

        ]),
      );
    }


    controller.context = context;
    return AppContainer(
      isShowBanner: false,
      coverScreenWidget: Obx(() => controller.isLoading.value ? const AppLoading() : const SizedBox.shrink()),
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.setting.tr,
            leftWidget: IosLeftHeaderWidget(),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: DisableGlowBehavior(),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.sp).copyWith(bottom: 16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                            () => Get.find<AppController>().isPremiumFull.value ? const SizedBox.shrink() : _unlockAllFeature()
                    ),


                    SizedBox(
                      height: 18.sp,
                    ),
                    _buildItemSetting(controller.onPressShare, AppImage.ic_share_app, TranslationConstants.shareApp.tr),
                    _buildItemSetting(controller.onPressPrivacy, AppImage.ic_pivacy, TranslationConstants.privacy.tr),
                    // NativeAdsWidget(
                    //   factoryId: NativeFactoryId.appNativeAdFactorySmall,
                    //   isPremium: Get.find<AppController>().isPremiumFull.value,
                    //   height: 120.0.sp,
                    // ),
                    Obx(() {
                      return Get.find<AppController>().isPremiumFull.value
                          ? const SizedBox.shrink()
                          : NativeAdsWidget(
                        factoryId: NativeFactoryId.appNativeAdFactorySmall,
                        isPremium: Get.find<AppController>().isPremiumFull.value,
                        height: 120.0.sp,
                      );
                    }),
                    _buildItemSetting(controller.onPressTerm, AppImage.ic_term, TranslationConstants.termOfCondition.tr),
                    _buildItemSetting(controller.onPressLanguage, AppImage.ic_language, TranslationConstants.language.tr,
                        isLanguage: true),
                    _buildItemSetting(controller.onPressContact, AppImage.ic_contact, TranslationConstants.contactUs.tr),
                    _buildItemSetting(controller.onPressRestore, AppImage.ic_restore, TranslationConstants.restore.tr),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.sp),
                      child: Text(
                        TranslationConstants.moreApp.tr,
                        style: textStyle20400(),
                      ),
                    ),

                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: '', iOSAppId: 'id1671558516');
                        },
                        asset: AppImage.iosMapet,
                        title: 'Dynamics Pixel Pets for 14 pro',
                        subTitle:
                        "Customize your dynamic island with 9 exclusive Pixel Pets. Put them on the lock screen widget to Feed & play with your virtual friends anytime you want! Only for iOS 16"),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: '', iOSAppId: 'id1670239220');
                        },
                        asset: AppImage.iosMatheo,
                        title: 'Thermometer - Check temperature',
                        subTitle:
                        "Plan your day with weather forecast, thermometer, hygrometer, rain precipitation, AQI, UV index, wind speed, direction, compass, snow fall, visibility distance and more."),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: '', iOSAppId: 'id6446508641');
                        },
                        asset: AppImage.iosMaNFC,
                        title: 'Smart NFC tools - RFID scanner',
                        subTitle:
                        "Start automating daily boring repetitive tasks with Smart NFC tools - RFID scanner. Easy for new users to write and read NFC card, chip & Stickers with unlimited storage."),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: '', iOSAppId: 'id6446268145');
                        },
                        asset: AppImage.iosMaTrip,
                        title: 'Road conditions: Drive weather',
                        subTitle:
                        "Check road conditions and be prepared for any situation with road trip planner! Display waypoint weather forecast and detailed route weather information to arrive safely."),
                    SizedBox(
                      height: 30.0.sp,
                    )
                    ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
