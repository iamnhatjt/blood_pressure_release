import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/constants/app_route.dart';
import '../../../../common/constants/enums.dart';
import '../../../controller/app_base_controller.dart';
import '../../../controller/app_controller.dart';

class IosSubscribeController extends AppBaseController {
  RxString rxSelectedIdentifier = AppConfig.premiumIdentifierYearly.obs;

  ProductDetails productDetailsWeek =
      ProductDetails(title: '', id: '', currencyCode: '', description: '', price: '', rawPrice: 0.0);
  ProductDetails productDetailsYear =
      ProductDetails(title: '', id: '', currencyCode: '', description: '', price: '', rawPrice: 0.0);

  @override
  void onInit() {
    super.onInit();

    productDetailsWeek = Get.find<AppController>().listProductDetailsSub.firstWhere(
        (element) => element.id == 'com.vietapps.bloodpressure.weekly',
        orElse: () => ProductDetails(title: '', id: '', currencyCode: '', description: '', price: '', rawPrice: 0.0));
    productDetailsYear = Get.find<AppController>().listProductDetailsSub.firstWhere(
        (element) => element.id == 'com.vietapps.bloodpressure.yearly',
        orElse: () => ProductDetails(title: '', id: '', currencyCode: '', description: '', price: '', rawPrice: 0.0));
  }

  void onSelectedIdentifier(String identifier) {
    rxSelectedIdentifier.value = identifier;
  }

  Future<void> onSubscribed() async {
    await Get.find<AppController>().onPressPremiumByProduct(rxSelectedIdentifier.value);
  }

  void onRestored() async {
    rxLoadedType.value = LoadedType.start;
    await Get.find<AppController>().restorePurchases();
    rxLoadedType.value = LoadedType.finish;
  }

  void onPressBack() {
    Get.offAndToNamed(AppRoute.androidSub);
  }
}
