import 'package:bloodpressure/presentation/journey/home/food_scanner/food_scanner_controller.dart';
import 'package:get/get.dart';

class FoodScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FoodScannerController());
  }

}