import 'dart:convert';

import 'package:bloodpressure/app/data/model/heart_rate_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../route/app_route.dart';

class HeartBeatController extends GetxController {
  RxList<HeartRateModel> listHeartRateModel = RxList();
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  _initData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    isLoading.value = false;
    List<String>? heartRateDataString = prefs.getStringList('heartRateData');
    if ((heartRateDataString ?? []).isNotEmpty) {
      listHeartRateModel.value = heartRateDataString!.map((e) => HeartRateModel.fromJson(jsonDecode(e))).toList();
    }
  }

  updateHeartRateData(HeartRateModel heartRateModel) async {
    listHeartRateModel.add(heartRateModel);
    listHeartRateModel.value = [...listHeartRateModel];
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('heartRateData', listHeartRateModel.map((element) => jsonEncode(element.toJson())).toList());
  }

  onPressMeasureNow() {
    Get.toNamed(AppRoute.measureScreen);
  }
}
