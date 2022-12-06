import 'package:bloodpressure/app/controller/heart_beat_controller.dart';
import 'package:get/get.dart';

class HeartBeatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HeartBeatController());
  }
}
