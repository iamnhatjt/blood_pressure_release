import 'dart:ui';

import 'package:intl/intl.dart';

class AppConstant {
  static final availableLocales = [const Locale('vi', 'VN'), const Locale('en', 'US')];
  static final dateTimeFormatCommon = DateFormat('HH:mm dd/MM/yyyy');
  static const int minHeartRate = 40;
  static const int maxHeartRate = 220;
  static final List<Map> listGender = [
    {'id': '0', 'nameEN': 'Male', 'nameVN': 'Nam'},
    {'id': '1', 'nameEN': 'Female', 'nameVN': 'Nữ'},
    {'id': '2', 'nameEN': 'Other', 'nameVN': 'Khác'},
  ];
}
