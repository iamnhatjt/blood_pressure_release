import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_route.dart';
import '../../controller/app_controller.dart';

class SelectLocationController extends GetxController {
  List listItemAge = [];
  
  RxInt valueChose = 30.obs;
  RxBool isMale = true.obs;
  RxBool isFemale = false.obs;

  RxString location = "United States".obs;

  @override
  void onInit() {
    super.onInit();

    for(int i = 13; i <= 100; i++) {
      listItemAge.add(i);
    }
  }

  onPressMale() {
    isMale.value = true;
    isFemale.value = false;
    Get.find<AppController>().currentUser.value.genderId = '1';
  }

  onPressFemale() {
    isMale.value = false;
    isFemale.value = true;
    Get.find<AppController>().currentUser.value.genderId = '2';
  }

  onPressNext() async {
    Get.offAndToNamed(AppRoute.mainScreen);

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_first_open_app", false);
  }
}