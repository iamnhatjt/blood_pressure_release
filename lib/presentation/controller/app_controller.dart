import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:bloodpressure/common/config/app_config.dart';
import 'package:bloodpressure/data/local_repository.dart';
import 'package:bloodpressure/domain/model/user_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/ads/add_interstitial_ad_manager.dart';
import '../../common/ads/add_open_ad_manager.dart';
import '../../common/ads/add_reward_ad_manager.dart';
import '../../common/config/hive_config/hive_config.dart';
import '../../common/constants/app_constant.dart';
import '../../common/injector/app_di.dart';
import '../../common/util/app_util.dart';

onSelectNotification(s1) async {}

class AppController extends SuperController {
  Locale currentLocale = AppConstant.availableLocales[1];
  Rx<UserModel> currentUser = UserModel().obs;
  final _localRepository = getIt.get<LocalRepository>();

  // late AppOpenAdManager _appOpenAdManager;
  bool avoidShowOpenApp = false;
  RxBool isPremiumFull = false.obs;
  StreamSubscription<dynamic>? _subscriptionIAP;
  List<ProductDetails> _listProductDetails = [];
  Map<String, ProductDetails> productDetailMap = {};
  Rx<PurchaseStatus> rxPurchaseStatus = PurchaseStatus.canceled.obs;

  //late
  late AppOpenAdManager _appOpenAdManager;

  RxBool skipOneAd = false.obs;
  RxInt freeAdCount = 0.obs;
  RxBool allowHeartRateFirstTime = false.obs;
  RxBool allowBloodPressureFirstTime = false.obs;
  RxBool allowBloodSugarFirstTime = false.obs;
  RxBool allowWeightAndBMIFirstTime = false.obs;

  void increaseFreeAdCount() {
    _localRepository.setFreeAdCount(++freeAdCount.value);
  }

  @override
  void onInit() {
    _setupAllowAd();
    super.onInit();
  }

  void _setupAllowAd() {
    _localRepository.getFreeAdCount().then((value) {
      freeAdCount.value = value;
    });
    _localRepository.getAllowHeartRateFirstTime().then((value) {
      allowHeartRateFirstTime.value = value;
    });

    _localRepository.getAllowBloodPressureFirstTime().then((value) {
      allowBloodPressureFirstTime.value = value;
    });

    _localRepository.getAllowBloodSugarFirstTime().then((value) {
      allowBloodSugarFirstTime.value = value;
    });

    _localRepository.getAllowWeightAndBMIFirstTime().then((value) {
      allowWeightAndBMIFirstTime.value = value;
    });
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    InAppPurchase.instance.restorePurchases();
  }

  @override
  void onReady() {
    super.onReady();
    _onInitIAPListener();
    if (Platform.isIOS) {
      int? firstTimeOpenApp = _localRepository.getFirstTimeOpenApp();
      if (isNullEmptyFalseOrZero(firstTimeOpenApp)) {
        isPremiumFull.value = true;
        _localRepository.setFirstTimeOpenApp(DateTime.now().millisecondsSinceEpoch);
      } else {
        var now = DateTime.now().millisecondsSinceEpoch;
        if (now - firstTimeOpenApp! > 86400000) {
          configAds();
        } else {
          isPremiumFull.value = true;
        }
      }
    } else {
      configAds();
    }
    // _initNotificationSelectHandle();
  }

  @override
  void onClose() {
    _subscriptionIAP?.cancel();
    getIt<HiveConfig>().dispose();
    super.onClose();
  }

  void configAds() {
    _appOpenAdManager = AppOpenAdManager()..loadAd();
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) {
      if (state == AppState.foreground) {
        if (!isPremiumFull.value && !avoidShowOpenApp) {
          _appOpenAdManager.showAdIfAvailable();
        }
      }
    });
    AddInterstitialAdManager().initializeInterstitialAds();
    AddRewardAdManager().initializeRewardedAds();
  }

  void updateFreeAdCount() {
    freeAdCount++;
    _localRepository.setFreeAdCount(freeAdCount.value);
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
    ProductDetails? productDetails = _listProductDetails
        .firstWhereOrNull((element) => element.id == productId);
    if (productDetails == null || productDetails.id.isEmpty) {
      showToast('Not available');
    } else {
      log('---IAP---: response.productDetails ${productDetails.title}');
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
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
      rxPurchaseStatus.value = purchaseDetails.status;
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
          if (Platform.isAndroid) {
            isPremiumFull.value =
                purchaseDetails.productID == AppConfig.premiumIdentifierYearly;
          } else if (Platform.isIOS) {
            isPremiumFull.value = purchaseDetails.productID ==
                    AppConfig.premiumIdentifierWeekly ||
                purchaseDetails.productID == AppConfig.premiumIdentifierYearly;
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
      Set<String> kIds = <String>{};
      if (Platform.isIOS) {
        kIds = AppConfig.listIOSPremiumIdentifiers;
      } else {
        kIds = AppConfig.listAndroidPremiumIdentifiers;
      }
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails(kIds);
      _listProductDetails = response.productDetails;
      log('///////////// _listProductDetails: ${response.productDetails} ${response.productDetails.isNotEmpty ? response.productDetails.first.id : ''}');
      for (final ProductDetails detail in _listProductDetails) {
        productDetailMap[detail.id] = detail;
      }
    }

    await restorePurchases();
  }

  Future<void> restorePurchases() async {
    // lấy danh sách các product đã mua, ios ghep sau
    // if (Platform.isAndroid) {
    await InAppPurchase.instance.restorePurchases();
    // } else {
    // final prefs = await SharedPreferences.getInstance();
    // bool isBought = prefs.getBool('isBought') ?? false;
    // if (isBought) {
    //   await InAppPurchase.instance.restorePurchases();
    // }
    // }
  }

  _initNotificationSelectHandle() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('background');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification);
  }

  onDidReceiveLocalNotification(i1, s1, s2, s3) {}

  void setAllowHeartRateFirstTime(bool value) {
    allowHeartRateFirstTime.value = value;
    _localRepository.setAllowHeartRateFirstTime(value);
  }

  void setAllowBloodPressureFirstTime(bool value) {
    allowBloodPressureFirstTime.value = value;
    _localRepository.setAllowBloodPressureFirstTime(value);
  }

  void setAllowBloodSugarFirstTime(bool value) {
    allowBloodSugarFirstTime.value = value;
    _localRepository.setAllowBloodSugarFirstTime(value);
  }

  void setAllowWeightAndBMIFirstTime(bool value) {
    allowWeightAndBMIFirstTime.value = value;
    _localRepository.setAllowWeigtAndBMIFirstTime(value);
  }
}
