import 'dart:io';

enum Environment { dev, prod }

class BuildConstants {
  static Map<String, dynamic> _config = _Config.devConstants;
  static var currentEnvironment = Environment.dev;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.prod:
        _config = _Config.prodConstants;
        currentEnvironment = Environment.prod;
        break;
      case Environment.dev:
        _config = _Config.devConstants;
        currentEnvironment = Environment.dev;
        break;
    }
  }

  static get apiUrl {
    return _config[_Config.apiBase];
  }

  static get idInterstitialAd {
    return Platform.isAndroid ? _config[_Config.idInterstitialAdAndroidKey] : _config[_Config.idInterstitialAdIosKey];
  }

  static get idBannerAd {
    return Platform.isAndroid ? _config[_Config.idBannerAdAndroidKey] : _config[_Config.idBannerAdIosKey];
  }

  static get iDOpenAppAd {
    return Platform.isAndroid ? _config[_Config.iDOpenAppAdAndroidKey] : _config[_Config.iDOpenAppAdIosKey];
  }

  static get idRewardAppAd {
    return Platform.isAndroid ? _config[_Config.idRewardAppAdAndroidKey] : _config[_Config.idRewardAppAdIosKey];
  }

  static get idNativeAppAd {
    return Platform.isAndroid ? _config[_Config.idNativeAppAdAndroidKey] : _config[_Config.idNativeAppAdIosKey];
  }

  static get appLovinToken {
    return _config[_Config.appLovinTokenKey];
  }
}

class _Config {
  static const apiBase = "API_BASE";
  static const idInterstitialAdAndroidKey = "idInterstitialAdAndroid";
  static const idBannerAdAndroidKey = "idBannerAdAndroid";
  static const iDOpenAppAdAndroidKey = "iDOpenAppAdAndroid";
  static const idRewardAppAdAndroidKey = "idRewardAppAdAndroid";
  static const idInterstitialAdIosKey = "idInterstitialAdIos";
  static const idBannerAdIosKey = "idBannerAdIos";
  static const iDOpenAppAdIosKey = "iDOpenAppAdIos";
  static const idRewardAppAdIosKey = "idRewardAppAdIos";
  static const idNativeAppAdAndroidKey = "idNativeAppAdAndroidKey";
  static const idNativeAppAdIosKey = "idNativeAppAdIosKey";
  static const appLovinTokenKey = "appLovinTokenKey";

  /// prod
  static Map<String, dynamic> prodConstants = {
    apiBase: "http://8.9.31.66:8000",
    idInterstitialAdAndroidKey: "11d70e4c8f332c08",
    idInterstitialAdIosKey: "9aff2af77cc978f7",
    idBannerAdAndroidKey: "275ce0aa351f14a3",
    idBannerAdIosKey: "5038094d210c3124",
    iDOpenAppAdAndroidKey: "ca-app-pub-5294836995166944/9246128224",
    iDOpenAppAdIosKey: "ca-app-pub-5294836995166944/5470534748",
    idRewardAppAdAndroidKey: "4adebe68d3e9905a",
    idRewardAppAdIosKey: "b0b12747b3616e63",
    idNativeAppAdAndroidKey: "ca-app-pub-5294836995166944/8608953534",
    idNativeAppAdIosKey: "ca-app-pub-5294836995166944/7834927914",
    appLovinTokenKey: "bHNo9I54UFEXQysIBS4ouIwd-5ztx_Cmc5NFCgT5CnTRzABi5RemvpybCuW1ViIlFBGoFpXdR42dm6qA3g8tCz",
  };

  /// dev
  // static Map<String, dynamic> prodConstants = {
  //   apiBase: "http://8.9.31.66:8000",
  //   idInterstitialAdAndroidKey: "a8dfb6103bca1128",
  //   idInterstitialAdIosKey: "d870fe58efb04148",
  //   idBannerAdAndroidKey: "e7cf386b1a58894d",
  //   idBannerAdIosKey: "e323b037e9f6bbb7",
  //   iDOpenAppAdAndroidKey: "ca-app-pub-3940256099942544/3419835294",
  //   iDOpenAppAdIosKey: "ca-app-pub-3940256099942544/5662855259",
  //   idRewardAppAdAndroidKey: "9b9e9de32828c82c",
  //   idRewardAppAdIosKey: "155231992cf644dc",
  //   idNativeAppAdAndroidKey: "ca-app-pub-3940256099942544/2247696110",
  //   idNativeAppAdIosKey: "ca-app-pub-3940256099942544/3986624511",
  //   appLovinTokenKey: "bHNo9I54UFEXQysIBS4ouIwd-5ztx_Cmc5NFCgT5CnTRzABi5RemvpybCuW1ViIlFBGoFpXdR42dm6qA3g8tCz",
  // };

  static Map<String, dynamic> devConstants = {
    apiBase: "http://8.9.31.66:8000",
    idInterstitialAdAndroidKey: "11d70e4c8f332c08",
    idInterstitialAdIosKey: "9aff2af77cc978f7",
    idBannerAdAndroidKey: "275ce0aa351f14a3",
    idBannerAdIosKey: "5038094d210c3124",
    iDOpenAppAdAndroidKey: "ca-app-pub-3940256099942544/3419835294",
    iDOpenAppAdIosKey: "ca-app-pub-3940256099942544/5662855259",
    idRewardAppAdAndroidKey: "4adebe68d3e9905a",
    idRewardAppAdIosKey: "b0b12747b3616e63",
    idNativeAppAdAndroidKey: "ca-app-pub-3940256099942544/2247696110",
    idNativeAppAdIosKey: "ca-app-pub-3940256099942544/3986624511",
    appLovinTokenKey: "bHNo9I54UFEXQysIBS4ouIwd-5ztx_Cmc5NFCgT5CnTRzABi5RemvpybCuW1ViIlFBGoFpXdR42dm6qA3g8tCz",
  };
}
