import 'package:bloodpressure/app/ui/widget/app_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../res/string/app_strings.dart';

class MainController extends GetxController {
  late BuildContext context;
  RxInt currentTab = 0.obs;

  onPressTab(int index) {
    currentTab.value = index;
  }

  onPressAddAlarm() {
    showAppDialog(
      context,
      'Alarm for Heart Rate',
      '',
      firstButtonText: StringConstants.save.tr,
      firstButtonCallback: () {
        Get.back();
      },
      secondButtonText: StringConstants.cancel.tr,
      secondButtonCallback: Get.back,
      widgetBody: Column(
        children: [

        ],
      ),
    );
  }
}
