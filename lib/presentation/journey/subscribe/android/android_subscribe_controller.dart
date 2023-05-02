import 'package:bloodpressure/common/config/app_config.dart';
import 'package:bloodpressure/common/constants/enums.dart';
import 'package:bloodpressure/presentation/controller/app_base_controller.dart';
import 'package:bloodpressure/presentation/controller/app_controller.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AndroidSubscribeController extends AppBaseController {
  ProductDetails productDetailsFullPack =
      ProductDetails(title: '', id: '', currencyCode: '', description: '', price: '', rawPrice: 0.0);

  Future<void> onSubscribed() async {
    await Get.find<AppController>().onPressPremiumByProduct(AppConfig.premiumIdentifierAndroid);
  }

  void onRestored() async {
    rxLoadedType.value = LoadedType.start;
    await Get.find<AppController>().restorePurchases();
    rxLoadedType.value = LoadedType.finish;
  }

  @override
  void onInit() {
    super.onInit();

    productDetailsFullPack = Get.find<AppController>().listProductDetailsSub.firstWhere(
        (element) => element.id == 'com.hiennguyen.bloodpressure.fullpack',
        orElse: () => ProductDetails(title: '', id: '', currencyCode: '', description: '', price: '', rawPrice: 0.0));
  }
}
