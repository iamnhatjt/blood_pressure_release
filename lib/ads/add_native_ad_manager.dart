import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../build_constants.dart';
import '../app/util/app_util.dart';

NativeAd createNativeAd(Function() onAdLoaded) {
  return NativeAd(
    adUnitId: BuildConstants.idNativeAppAd,
    factoryId: 'appNativeAdFactory',
    request: const AdRequest(),
    listener: NativeAdListener(
      onAdLoaded: (Ad ad) {
        log('---NATIVE ADS---: $NativeAd loaded.');
        onAdLoaded();
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        log('---NATIVE ADS---: $NativeAd failedToLoad: $error');
        ad.dispose();
      },
      onAdOpened: (Ad ad) => log('---NATIVE ADS---: $NativeAd onAdOpened.'),
      onAdClosed: (Ad ad) => log('---NATIVE ADS---: $NativeAd onAdClosed.'),
    ),
  );
}
