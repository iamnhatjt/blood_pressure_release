import 'package:bloodpressure/common/ads/add_native_ad_manager.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:bloodpressure/presentation/widget/native_ads_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/disable_ glow_behavior.dart';
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

  Widget _buildItemMore(
      {Function()? onPressed, String? asset, String? title, String? subTitle}) {
    return AppTouchable.commonRadius20(
      onPressed: onPressed,
      padding: EdgeInsets.all(12.0.sp),
      margin: EdgeInsets.only(top: 12.0.sp, left: 20.0.sp, right: 20.0.sp),
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
    );
  }

  Widget _buildItemSetting(Function() onPressed, String imagePath, String text,
      {bool isLanguage = false}) {
    return AppTouchable.commonRadius87(
      onPressed: onPressed,
      width: Get.width,
      height: 48.0.sp,
      padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
      margin: EdgeInsets.only(bottom: 16.0.sp, left: 20.0.sp, right: 20.0.sp),
      child: Row(
        children: [
          imagePath.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(right: 8.0.sp),
                  child: AppImageWidget.asset(
                    path: imagePath,
                    width: 40.0.sp,
                    fit: BoxFit.contain,
                  ),
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
                        controller.currentLanguageCode.value == "vi"
                            ? "Vie"
                            : "Eng",
                        style: textStyle18400(),
                      ),
                      SizedBox(width: 12.sp),
                    ],
                  );
                })
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      coverScreenWidget: Obx(() => controller.isLoading.value
          ? const AppLoading()
          : const SizedBox.shrink()),
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.setting.tr,
            leftWidget: SizedBox(width: 40.0.sp),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: DisableGlowBehavior(),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.sp).copyWith(bottom: 16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImageWidget.asset(path: AppImage.setting_banner),
                    _buildItemSetting(
                        controller.onPressShare,
                        AppImage.ic_share_app,
                        TranslationConstants.shareApp.tr),
                    _buildItemSetting(controller.onPressPrivacy,
                        AppImage.ic_pivacy, TranslationConstants.privacy.tr),
                    NativeAdsWidget(
                      factoryId: NativeFactoryId.appNativeAdFactoryMedium,
                      isPremium: Get.find<AppController>().isPremiumFull.value,
                    ),
                    _buildItemSetting(controller.onPressTerm, AppImage.ic_term,
                        TranslationConstants.termOfCondition.tr),
                    _buildItemSetting(controller.onPressLanguage,
                        AppImage.ic_language, TranslationConstants.language.tr,
                        isLanguage: true),
                    _buildItemSetting(controller.onPressContact,
                        AppImage.ic_contact, TranslationConstants.contactUs.tr),
                    _buildItemSetting(controller.onPressRestore,
                        AppImage.ic_restore, TranslationConstants.restore.tr),
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
                              androidAppId: 'com.vietapps.numerology.thansohoc',
                              iOSAppId: 'id1620921159');
                        },
                        asset: AppImage.ma_numerology,
                        title: 'Psychic numerology & life path',
                        subTitle:
                            "Explore all about: Numerology, Tarot cards, Zodiac, Dream meaning, Life path or Love"),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: 'com.vietapps.watchface',
                              iOSAppId: 'id1543589965');
                        },
                        asset: AppImage.ma_watchface,
                        title: 'Watch Face Wallpaper Gallery',
                        subTitle:
                            "Feel free to customize watch faces on your own apple watch with up to 2000+ wallpapers from Watch Face Wallpaper Gallery app. Let's try it!!!"),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: 'com.infinity.nfctools',
                              iOSAppId: 'id1639914460');
                        },
                        asset: AppImage.ma_nfc,
                        title: 'Read nfc tagwriter - nfc writer',
                        subTitle:
                            "NFC Tools- nfc tag reader are simple, intuitive, can record standard information on your NFC tags"),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: 'com.vietapps.multiscanner',
                              iOSAppId: 'id1639914460');
                        },
                        asset: AppImage.ma_qrcode,
                        title: 'QR Reader & MRZ, NFC Reader',
                        subTitle:
                            "The simplest QR code generator- QR, NFC, MRZ, Barcode scanner app for Android!"),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: 'com.vietapps.airlive',
                              iOSAppId: 'id1556565950');
                        },
                        asset: AppImage.ma_air_live,
                        title: 'Airlive Wallpaper',
                        subTitle: "Feel free to customize"),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: 'com.vietapps.umeme',
                              iOSAppId: 'id1574788977');
                        },
                        asset: AppImage.ma_umeme,
                        title: 'uMeme - Your Meme Maker',
                        subTitle:
                            "uMeme is the new way to share your mood into the world"),
                    _buildItemMore(
                        onPressed: () {
                          StoreRedirect.redirect(
                              androidAppId: 'com.vietapps.ballline',
                              iOSAppId: 'id1607340262');
                        },
                        asset: AppImage.ma_animal_cross,
                        title: 'Animal Cross',
                        subTitle: "Addictive puzzle game"),
                    _buildItemMore(
                        onPressed: () => StoreRedirect.redirect(
                            androidAppId: 'com.vietapps.gravityball',
                            iOSAppId: 'id1603988842'),
                        asset: AppImage.ma_gravity,
                        title: 'Gravity Ball',
                        subTitle:
                            "Help the gravity ball find its way to the black hole despite the gravity and spikes?"),
                    _buildItemMore(
                        onPressed: () => StoreRedirect.redirect(
                            androidAppId: 'com.vietapps.tilematch',
                            iOSAppId: 'id1609914640'),
                        asset: AppImage.ma_connect_title,
                        title: 'Connect Tile',
                        subTitle:
                            "Connect Tile - Geometry tile matching game is a brand new tile connect game with innovative gameplay."),
                    _buildItemMore(
                        onPressed: () => StoreRedirect.redirect(
                            androidAppId: 'com.vietapps.healthyfit',
                            iOSAppId: 'id1525850085'),
                        asset: AppImage.ma_fitness,
                        title: 'HealthyFit - Fitness for your health',
                        subTitle:
                            "We created this application to target office workers, those who have little time and also those who are passionate about gym. Let's exercise with us!!!"),
                    _buildItemMore(
                        onPressed: () => StoreRedirect.redirect(
                            androidAppId: 'com.vietapps.thermometer',
                            iOSAppId: 'id1525850085'),
                        asset: AppImage.ma_weather,
                        title: 'Smart thermometer for room',
                        subTitle:
                            "Temperature tracker- temperature detector helps you check temperature, check thermometer. Besides, check thermometer, show weather, humidity, or air quality are integrated like a thermostat app"),
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
