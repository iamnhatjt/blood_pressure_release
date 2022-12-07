import 'package:get/get.dart';

import '../route/app_route.dart';

class HeartBeatController extends GetxController {
  onPressMeasureNow() {
    Get.toNamed(AppRoute.measureScreen);
  }
}