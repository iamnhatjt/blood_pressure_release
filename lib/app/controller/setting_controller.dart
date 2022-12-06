import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ads/add_native_ad_manager.dart';
import 'app_controller.dart';

class SettingController extends GetxController {
  late BuildContext context;
  RxString currentLanguageCode = ''.obs;
  RxBool isLoading = false.obs;
  final AppController _appController = Get.find<AppController>();
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
      nativeAd = createNativeAd(() {
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
    currentLanguageCode.value = Get.find<AppController>().currentLocale.toLanguageTag() == 'vi-VN' ? 'VI' : 'EN';
  }

  onPressPrivacy() {
    _openLink('https://sites.google.com/view/nfcmanagertool/policy-privacy');
  }

  onPressTerm() {
    _openLink('https://sites.google.com/view/nfcmanagertool/terms-condition');
  }

  onPressContact() {
    _openLink('https://sites.google.com/view/nfcmanagertool/contact');
  }

  onPressShare() {
    if (Platform.isIOS) {
      Share.share('Install this app and manage your NFC tags: itms-apps://apple.com/app/id1620921159');
    } else {
      Share.share(
          'Install this app and manage your NFC tags: https://play.google.com/store/apps/details?id=com.infinity.nfctools');
    }
  }

  onPressLanguage() {
    // showAppDialog(
    //   context,
    //   StringConstants.language.tr,
    //   '',
    //   messageWidget: Column(
    //     children: [
    //       SizedBox(height: 32.0.sp),
    //       AppTouchable(
    //         onPressed: () async {
    //           currentLanguageCode.value = 'EN';
    //           final prefs = await SharedPreferences.getInstance();
    //           prefs.setString('language', '1');
    //           Get.find<AppController>().updateLocale(AppConstant.availableLocales[1]);
    //           Get.back();
    //         },
    //         padding: EdgeInsets.symmetric(vertical: 12.0.sp, horizontal: 16.0.sp),
    //         child: Row(
    //           children: [
    //             Expanded(
    //               child: Text(
    //                 'English',
    //                 style: TextStyle(
    //                   fontSize: 20.0.sp,
    //                   color: AppColor.primaryColor,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               width: 20.0.sp,
    //               height: 20.0.sp,
    //               padding: EdgeInsets.all(2.0.sp),
    //               decoration: BoxDecoration(
    //                 color: Colors.transparent,
    //                 borderRadius: BorderRadius.circular(12.0.sp),
    //                 border: Border.all(color: AppColor.primaryColor, width: 1),
    //               ),
    //               child: Obx(() => currentLanguageCode.value == 'EN'
    //                   ? Container(
    //                       decoration: BoxDecoration(
    //                         color: AppColor.primaryColor,
    //                         borderRadius: BorderRadius.circular(12.0.sp),
    //                       ),
    //                     )
    //                   : const SizedBox.shrink()),
    //             ),
    //           ],
    //         ),
    //       ),
    //       AppTouchable(
    //         onPressed: () async {
    //           currentLanguageCode.value = 'VI';
    //           final prefs = await SharedPreferences.getInstance();
    //           prefs.setString('language', '0');
    //           Get.find<AppController>().updateLocale(AppConstant.availableLocales[0]);
    //           Get.back();
    //         },
    //         padding: EdgeInsets.symmetric(vertical: 12.0.sp, horizontal: 16.0.sp),
    //         child: Row(
    //           children: [
    //             Expanded(
    //               child: Text(
    //                 'Tiếng Việt',
    //                 style: TextStyle(
    //                   fontSize: 20.0.sp,
    //                   color: AppColor.primaryColor,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               width: 20.0.sp,
    //               height: 20.0.sp,
    //               padding: EdgeInsets.all(2.0.sp),
    //               decoration: BoxDecoration(
    //                 color: Colors.transparent,
    //                 borderRadius: BorderRadius.circular(12.0.sp),
    //                 border: Border.all(color: AppColor.primaryColor, width: 1),
    //               ),
    //               child: Obx(() => currentLanguageCode.value == 'VI'
    //                   ? Container(
    //                       decoration: BoxDecoration(
    //                         color: AppColor.primaryColor,
    //                         borderRadius: BorderRadius.circular(12.0.sp),
    //                       ),
    //                     )
    //                   : const SizedBox.shrink()),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 32.0.sp),
    //     ],
    //   ),
    // );
  }

  onPressRemoveAds() {
    // Get.find<AppController>().onPressPremiumByProduct('com.infinity.nfctools.removeads');
  }

  onPressRestore() async {
    // isLoading.value = true;
    // await InAppPurchase.instance.restorePurchases();
    // isLoading.value = false;
    // showToast(StringConstants.restoreSuccessful.tr);
  }

  _openLink(String url) async {
    Uri uri = Uri.parse(url);
    await canLaunchUrl(uri) ? await launchUrl(uri) : throw 'Could not launch $url';
  }
}
