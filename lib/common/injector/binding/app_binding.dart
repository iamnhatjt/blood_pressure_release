import 'package:bloodpressure/common/injector/binding/splash_binding.dart';
import 'package:bloodpressure/common/injector/binding/weight_bmi_binding.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:get/get.dart';

import '../../../domain/usecase/alarm_usecase.dart';
import '../../../presentation/controller/app_controller.dart';
import '../../../presentation/journey/alarm/widgets/alarm_add_button_controller.dart';
import '../../../presentation/journey/alarm/widgets/alarm_dialog_controller.dart';
import '../../../presentation/journey/home/home_controller.dart';
import '../../../presentation/journey/insight/insight_controller.dart';
import '../../../presentation/journey/main/main_controller.dart';
import '../../../presentation/journey/setting/setting_controller.dart';
import '../app_di.dart';
import 'heart_beat_binding.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(SplashBinding());
    Get.put(MainController());
    Get.put(HomeController());
    Get.put(WeightBMIBinding());
    Get.put(HeartBeatBinding());
    Get.put(MeasureBinding());

    Get.put(InsightController());
    Get.put(AlarmController(alarmUseCase: getIt.get<AlarmUseCase>()));
    Get.put(SettingController());
    Get.put(AlarmAddButtonController());
    Get.put(AlarmDialogController());
  }
}
