class AppConfig {
  static const String weightUnitIdKey = "weightUnitId";
  static const String heightUnitIdKey = "heightUnitId";
  static const String firstTimeOpenApp = "heightUnitId";

  /**
   * Sub key
   */
  static const String _premiumIdentifierWeekly =
      'com.vietapps.bloodpressure.weekly';
  static const String _premiumIdentifierYearly =
      'com.vietapps.bloodpressure.yearly';
  static const String _premiumIdentifierAndroid = 'yearly';
  static final Set<String> listAndroidPremiumIdentifiers = <String>{
    _premiumIdentifierAndroid
  };
  static final Set<String> listIOSPremiumIdentifiers = <String>{
    premiumIdentifierWeekly,
    premiumIdentifierYearly
  };

  static String get premiumIdentifierWeekly => _premiumIdentifierWeekly;

  static String get premiumIdentifierYearly => _premiumIdentifierYearly;

  static String get premiumIdentifierAndroid => _premiumIdentifierAndroid;
}
