import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:bloodpressure/common/constants/app_image.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:get/get.dart';

class InsightController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> insightList = <Map<String, dynamic>>[].obs;

  void _loadData() async {
    final insights = await parseJsonFromAsset(AppConstant.insightAsset) as List<dynamic>;
    insightList.value = insights.map((e) => e as Map<String, dynamic>).toList();
  }

  @override
  void onInit() {
    _loadData();
    isLoading.value = false;
    super.onInit();
  }

  void onSubScriblePremium() {}
}