import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
      firstButtonText: TranslationConstants.save.tr,
      firstButtonCallback: () {
        Get.back();
      },
      secondButtonText: TranslationConstants.cancel.tr,
      secondButtonCallback: Get.back,
      widgetBody: Column(
        children: [

        ],
      ),
    );
  }
}
