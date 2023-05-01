

import 'package:bloodpressure/presentation/journey/intro/intro_controller.dart';
import 'package:get/get.dart';

class IntroBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(IntroController());
  }
}