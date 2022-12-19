import 'package:bloodpressure/presentation/journey/home/blood_sugar/add_blood_sugar_dialog/add_blood_sugar_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import 'package:get/get.dart';

class BloodSugarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BloodSugarController());
    Get.put(AddBloodSugarController());
  }

}