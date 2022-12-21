import 'package:bloodpressure/common/config/hive_config/hive_config.dart';
import 'package:bloodpressure/data/local_repository.dart';
import 'package:get/get.dart';

import '../../../presentation/controller/app_controller.dart';
import '../app_di.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(LocalRepository(getIt<HiveConfig>()));
  }
}
