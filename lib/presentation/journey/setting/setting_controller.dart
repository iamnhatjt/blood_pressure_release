import 'dart:io';

import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/ads/add_native_ad_manager.dart';
import '../../controller/app_controller.dart';
import '../../widget/app_dialog.dart';
import '../../widget/app_dialog_language_widget.dart';

class SettingController extends GetxController {
  late BuildContext context;
  RxString currentLanguageCode = Get.find<AppController>()
      .currentLocale
      .languageCode
      .obs;
  RxBool isLoading = false.obs;
  final AppController _appController =
      Get.find<AppController>();
  RxList<Map> listAds = RxList();

  @override
  void onInit() {
    _initNativeAds();
    super.onInit();
  }

  @override
  void dispose() {
    for (final adItem in listAds) {
      adItem['ad']?.dispose();
    }
    super.dispose();
  }

  _initNativeAds() {
    for (final adItem in listAds.value) {
      adItem['ad']?.dispose();
    }
    listAds.value = [];
    List<Map> listTemp = [];
    if (_appController.isPremiumFull.value) return;
    for (int i = 0; i < 2; i++) {
      NativeAd? nativeAd;
      nativeAd = createNativeAd(
          NativeFactoryId.appNativeAdFactorySmall, () {
        listTemp.add({
          'ad': nativeAd,
          'widget': SizedBox(
            width: Get.width,
            height: Get.width / 4,
            child: AdWidget(ad: nativeAd!),
          )
        });
        listAds.value = [...listTemp];
      });
      nativeAd.load();
    }
  }

  @override
  void onReady() {
    super.onReady();
    // currentLanguageCode.value =
    //     Get.find<AppController>().currentLocale.languageCode;
  }

  onPressPrivacy() {
    _openLink(AppExternalUrl.privacy);
  }

  onPressTerm() {
    _openLink(AppExternalUrl.termsAndConditions);
  }

  onPressContact() {
    _openLink(AppExternalUrl.contactUs);
  }

  onPressShare() {
    if (Platform.isIOS) {
      Share.share(
          'Install this app and track your health: itms-apps://apple.com/app/id1620921159');
    } else {
      Share.share(
          'Install this app and track your health: https://play.google.com/store/apps/details?id=com.infinity.nfctools');
    }
  }

  onPressLanguage() {
    showAppDialog(
      context,
      TranslationConstants.chooseLanguage.tr,
      '',
      hideGroupButton: true,
      messageWidget: AppDialogLanguageWidget(
        availableLocales: AppConstant.availableLocales,
        initialLocale:
            Get.find<AppController>().currentLocale,
        onLocaleSelected: (locale) async {
          final int index = AppConstant.availableLocales
              .indexWhere((element) =>
                  element.languageCode ==
                  locale.languageCode);
          currentLanguageCode.value = locale.languageCode;
          final prefs =
              await SharedPreferences.getInstance();
          prefs.setString('language', index.toString());
          Get.find<AppController>().updateLocale(locale);
          Get.back();
        },
        onPressCancel: () {
          Get.back();
        },
      ),
    );
  }

  onPressRemoveAds() {
    // Get.find<AppController>().onPressPremiumByProduct('com.infinity.nfctools.removeads');
  }

  onPressRestore() async {
    isLoading.value = true;
    await Get.find<AppController>().restorePurchases();
    isLoading.value = false;
  }

  _openLink(String url) async {
    Uri uri = Uri.parse(url);
    await canLaunchUrl(uri)
        ? await launchUrl(uri)
        : throw 'Could not launch $url';
  }
}
