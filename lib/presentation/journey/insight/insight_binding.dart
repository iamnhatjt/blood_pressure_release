
import 'package:bloodpressure/presentation/journey/insight/insight_controller.dart';
import 'package:get/get.dart';

class InsightBinding extends Bindings {
  @override
  void dependencies() {
    Get.put( InsightController());
  }

}