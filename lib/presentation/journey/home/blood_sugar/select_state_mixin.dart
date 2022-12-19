import 'package:bloodpressure/common/constants/app_constant.dart';
import 'package:get/get.dart';

mixin SelectStateMixin {
  RxString rxSelectedState = BloodSugarStateCode.defaultCode.obs;

  void onSelectState(String stateCode) {
    rxSelectedState.value = stateCode.tr;
  }
}