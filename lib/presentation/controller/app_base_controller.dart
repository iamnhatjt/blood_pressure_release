import 'dart:async';

import 'package:bloodpressure/common/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBaseController extends GetxController {
  late BuildContext context;
  Rx<LoadedType> rxLoadedType = LoadedType.finish.obs;
  Timer? timerLoading;

  void startLoading({int? timeout}) {
    rxLoadedType.value = LoadedType.start;
    timerLoading = Timer(Duration(seconds: timeout ?? 60), finishLoading);
  }

  void finishLoading() {
    rxLoadedType.value = LoadedType.finish;
  }
}