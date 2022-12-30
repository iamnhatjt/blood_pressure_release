class AppConfig {
  static const String weightUnitIdKey = "weightUnitId";
  static const String heightUnitIdKey = "heightUnitId";

  /**
   * Sub key
   */
  static const String _premiumIdentifierWeekly =
      'com.vietapps.bloodpressure.weekly';
  static const String _premiumIdentifierYearly =
      'com.vietapps.bloodpressure.yearly';
  static final Set<String> listAndroidPremiumIdentifiers = <String>{
    premiumIdentifierYearly
  };
  static final Set<String> listIOSPremiumIdentifiers = <String>{
    premiumIdentifierWeekly,
    premiumIdentifierYearly
  };

  static String get premiumIdentifierWeekly => _premiumIdentifierWeekly;

  static String get premiumIdentifierYearly => _premiumIdentifierYearly;
}
