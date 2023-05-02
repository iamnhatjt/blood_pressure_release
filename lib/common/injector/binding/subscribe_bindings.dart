import 'package:get/get.dart';

import '../../../presentation/journey/subscribe/android/android_subscribe_controller.dart';
import '../../../presentation/journey/subscribe/ios/ios_subscribe_controller.dart';

class IosSubscribeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(IosSubscribeController());
  }
}

class AndroidSubscribeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AndroidSubscribeController());
  }
}
