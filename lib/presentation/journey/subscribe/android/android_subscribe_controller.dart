import 'package:bloodpressure/common/config/app_config.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/presentation/controller/app_base_controller.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:get/get.dart';

class AndroidSubscribeController extends AppBaseController {
  Future<void> onSubscribed() async {
    await Get.find<AppController>()
        .onPressPremiumByProduct(AppConfig.premiumIdentifierYearly);
  }

  void onRestored() async {
    rxLoadedType.value = LoadedType.start;
    await Get.find<AppController>().restorePurchases();
    rxLoadedType.value = LoadedType.finish;
  }
}
