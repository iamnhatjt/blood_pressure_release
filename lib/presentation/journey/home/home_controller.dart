import 'package:bloodpressure/common/constants/app_route.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  onPressHeartBeat() {
    Get.toNamed(AppRoute.heartBeatScreen);
  }
}
