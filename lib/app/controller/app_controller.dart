import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:bloodpressure/app/data/model/user_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/app_constant.dart';
import '../util/app_util.dart';

onSelectNotification(s1) async {}

class AppController extends SuperController {
  Locale currentLocale = AppConstant.availableLocales[1];
  Rx<UserModel> currentUser = UserModel().obs;

  // late AppOpenAdManager _appOpenAdManager;
  bool avoidShowOpenApp = false;
  RxBool isPremiumFull = false.obs;
  StreamSubscription<dynamic>? _subscriptionIAP;
  List<ProductDetails> _listProductDetails = [];

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    if (Platform.isAndroid) {
      InAppPurchase.instance.restorePurchases();
    }
  }

  @override
  void onReady() {
    super.onReady();
    // _onInitIAPListener();
    // _appOpenAdManager = AppOpenAdManager()..loadAd();
    // AppStateEventNotifier.startListening();
    // AppStateEventNotifier.appStateStream.forEach((state) {
    //   if (state == AppState.foreground) {
    //     if (!isPremiumFull.value && !avoidShowOpenApp) {
    //       _appOpenAdManager.showAdIfAvailable();
    //     }
    //   }
    // });
    // AddInterstitialAdManager().initializeInterstitialAds();
    // AddRewardAdManager().initializeRewardedAds();
    // _initNotificationSelectHandle();
  }

  @override
  void onClose() {
    _subscriptionIAP?.cancel();
    super.onClose();
  }

  updateLocale(Locale locale) {
    Get.updateLocale(locale);
    currentLocale = locale;
  }

  updateUser(UserModel userModel) async {
    currentUser.value = userModel;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(userModel.toJson()));
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? stringUser = prefs.getString('user');
    if ((stringUser ?? '').isNotEmpty) {
      currentUser.value = UserModel.fromJson(jsonDecode(stringUser!));
    }
  }

  onPressPremiumByProduct(String productId) async {
    ProductDetails? productDetails = _listProductDetails.firstWhereOrNull((element) => element.id == productId);
    if (productDetails == null || productDetails.id.isEmpty) {
      showToast('Not available');
    } else {
      log('---IAP---: response.productDetails ${productDetails.title}');
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  _onInitIAPListener() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscriptionIAP = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      log('---IAP--- done IAP stream');
      _subscriptionIAP?.cancel();
    }, onError: (error) {
      log('---IAP--- error IAP stream: $error');
    });
  }

  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      log('---IAP---: purchaseDetails.productID: ${purchaseDetails.productID}');
      log('---IAP---: purchaseDetails.status: ${purchaseDetails.status}');
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // isPremium.value = false;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // isPremium.value = false;
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          // isPremium.value = true;
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setBool('isBought', true);
          switch (purchaseDetails.productID) {
            case 'com.vietapps.thermometer.removeads':
              isPremiumFull.value = true;
              break;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  getIAPProductDetails() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      showToast('Can not connect store');
    } else {
      const Set<String> kIds = <String>{
        'com.vietapps.thermometer.removeads',
      };
      final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(kIds);
      _listProductDetails = response.productDetails;
      log('///////////// _listProductDetails: ${response.productDetails}    ${response.productDetails.isNotEmpty ? response.productDetails.first.id : ''}');
    }

    if (Platform.isAndroid) {
      InAppPurchase.instance.restorePurchases();
    }
  }

  _initNotificationSelectHandle() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('background');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification);
  }

  onDidReceiveLocalNotification(i1, s1, s2, s3) {}
}
