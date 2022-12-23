import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:bloodpressure/domain/usecase/bmi_usecase.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/weight_bmi_controller.dart';
import 'package:get/get.dart';

import '../../../presentation/journey/home/weight_bmi/add_weight_bmi/add_weight_bmi_controller.dart';
import '../app_di.dart';

class WeightBMIBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      WeightBMIController(
        getIt<BMIUsecase>(),
        getIt<AlarmUseCase>(),
      ),
    );
    Get.put(
      AddWeightBMIController(
        getIt<BMIUsecase>(),
      ),
    );
  }
}
