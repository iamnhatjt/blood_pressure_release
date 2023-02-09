class AppConfig {
  static const String weightUnitIdKey = "weightUnitId";
  static const String heightUnitIdKey = "heightUnitId";
  static const String firstTimeOpenApp = "firstTimeOpenApp";

  static const String _premiumIdentifierWeekly = 'weekly';
  static const String _premiumIdentifierYearly = 'yearly';
  static const String _premiumIdentifierAndroid = 'com.vietapps.bloodpressure.fullpack';

  static final Set<String> listAndroidPremiumIdentifiers = <String>{_premiumIdentifierAndroid};
  static final Set<String> listIOSPremiumIdentifiers = <String>{premiumIdentifierWeekly, premiumIdentifierYearly};

  static String get premiumIdentifierWeekly => _premiumIdentifierWeekly;

  static String get premiumIdentifierYearly => _premiumIdentifierYearly;

  static String get premiumIdentifierAndroid => _premiumIdentifierAndroid;
}
