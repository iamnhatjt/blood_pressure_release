import 'package:bloodpressure/common/injector/app_di.dart';
import 'package:bloodpressure/common/injector/binding/app_binding.dart';
import 'package:bloodpressure/common/injector/binding/splash_binding.dart';
import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_add_button_controller.dart';
import 'package:bloodpressure/presentation/journey/alarm/widgets/alarm_dialog_controller.dart';
import 'package:bloodpressure/presentation/journey/home/home_controller.dart';
import 'package:bloodpressure/presentation/journey/insight/insight_controller.dart';
import 'package:bloodpressure/presentation/journey/setting/setting_controller.dart';
import 'package:get/get.dart';

import '../../../presentation/journey/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(AppBinding());
    Get.put(SplashBinding());

    Get.put(HomeController());
    Get.put(InsightController());
    Get.put(AlarmController(alarmUseCase: getIt.get<AlarmUseCase>()));
    Get.put(SettingController());
    Get.put(AlarmAddButtonController());
    Get.put(AlarmDialogController());
  }
}
