

import 'package:bloodpressure/presentation/journey/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.find<HomeController>();
  }
}