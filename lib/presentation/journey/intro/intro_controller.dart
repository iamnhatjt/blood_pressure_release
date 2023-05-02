import 'package:get/get.dart';
import '../../../common/constants/app_route.dart';

class IntroController extends GetxController {
  RxInt pageIndex = 0.obs;


  void movePage() {
    if(pageIndex.value == 1){
      Get.toNamed(AppRoute.iosSub);
    }
    if (pageIndex.value == 3) {
      Get.offAndToNamed(AppRoute.measureScreen);
    }
    else{
      pageIndex++;
    }


  }
}