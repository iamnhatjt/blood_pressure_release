import 'package:get/get.dart';

import '../controller/measure_controller.dart';

class MeasureBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MeasureController());
  }
}
