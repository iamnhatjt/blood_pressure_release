class AppConfig {
  static const String weightUnitIdKey = "weightUnitId";
  static const String heightUnitIdKey = "heightUnitId";
  static const String firstTimeOpenApp = "firstTimeOpenApp";

  static const String _premiumIdentifierWeekly = 'weekly';
  static const String _premiumIdentifierYearly = 'yearly';
  static const String _premiumIdentifierMonth = 'monthly';
  static const String _premiumIdentifierAndroid = 'com.hiennguyen.bloodpressure';

  static final Set<String> listAndroidPremiumIdentifiers = <String>{_premiumIdentifierAndroid};
  static final Set<String> listIOSPremiumIdentifiers = <String>{premiumIdentifierWeekly, premiumIdentifierYearly,  premiumIdentifierMonth};

  static String get premiumIdentifierWeekly => _premiumIdentifierWeekly;

  static String get premiumIdentifierYearly => _premiumIdentifierYearly;

  static String get premiumIdentifierMonth => _premiumIdentifierMonth;

  static String get premiumIdentifierAndroid => _premiumIdentifierAndroid;


}
