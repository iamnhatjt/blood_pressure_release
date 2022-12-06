import 'package:bloodpressure/app/controller/alarm_controller.dart';
import 'package:bloodpressure/app/controller/home_controller.dart';
import 'package:bloodpressure/app/controller/insight_controller.dart';
import 'package:bloodpressure/app/controller/setting_controller.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(HomeController());
    Get.put(InsightController());
    Get.put(AlarmController());
    Get.put(SettingController());
  }
}
