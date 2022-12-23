import 'package:bloodpressure/common/injector/app_di.dart';
import 'package:bloodpressure/domain/usecase/blood_sugar_usecase.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/add_blood_sugar_dialog/add_blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import 'package:get/get.dart';

class BloodSugarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BloodSugarController(getIt<BloodSugarUseCase>()));
    Get.put(AddBloodSugarController(getIt<BloodSugarUseCase>()));
  }

}