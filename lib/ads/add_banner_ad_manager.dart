import 'package:applovin_max/applovin_max.dart';

import '../../build_constants.dart';

class AddBannerAdManager {
  initializeBannerAds() {
    AppLovinMAX.createBanner(BuildConstants.idBannerAd, AdViewPosition.bottomCenter);
  }
}
