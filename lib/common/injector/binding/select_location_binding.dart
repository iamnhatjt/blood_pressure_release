import 'package:get/get.dart';

import '../../../presentation/journey/select_location/select_location_controller.dart';

class SelectLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectLocationController());
  }
}
