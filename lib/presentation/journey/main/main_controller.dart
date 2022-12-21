import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentTab = 0.obs;

  onPressTab(int index) {
    currentTab.value = index;
  }
}