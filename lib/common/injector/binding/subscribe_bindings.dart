import 'package:bloodpressure/presentation/journey/subscribe/android/android_subscribe_controller.dart';
import 'package:bloodpressure/presentation/journey/subscribe/ios/ios_subscribe_controller.dart';
import 'package:get/get.dart';

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
