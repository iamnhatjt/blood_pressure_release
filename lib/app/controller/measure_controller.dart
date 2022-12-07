import 'dart:async';
import 'package:bloodpressure/app/ui/widget/heart_bpm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../res/string/app_strings.dart';
import '../util/app_permission.dart';

enum MeasureScreenState { idle, measuring }

class MeasureController extends GetxController {
  late BuildContext context;
  Rx<MeasureScreenState> currentMeasureScreenState = MeasureScreenState.idle.obs;
  Timer? _timer;
  RxDouble progress = 0.0.obs;
  final int totalMiniSecondsToMeasure = 20000;
  int currentMiniSecond = 0;
  RxInt bpmAverage = 0.obs;
  List<int> _listDataBPM = [];

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  _initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (currentMiniSecond >= totalMiniSecondsToMeasure) {
        onPressStopMeasure();
      } else {
        currentMiniSecond = currentMiniSecond + 300;
        progress.value = currentMiniSecond / totalMiniSecondsToMeasure;
      }
    });
  }

  onPressStartMeasure() {
    // showAppDialog(
    //   context,
    //   '',
    //   '',
    //   widgetBody: const AppDialogHeartRateWidget(),
    // );
    AppPermission.checkPermission(
      context,
      Permission.camera,
      StringConstants.permissionCameraDenied01.tr,
      StringConstants.permissionCameraSetting01.tr,
      onGrant: () async {
        currentMeasureScreenState.value = MeasureScreenState.measuring;
        _listDataBPM = [];
        bpmAverage.value = 0;
        progress.value = 0.0;
        currentMiniSecond = 0;
      },
      onDenied: () {},
      onOther: () {},
    );
  }

  onPressStopMeasure() {
    currentMeasureScreenState.value = MeasureScreenState.idle;
    _timer?.cancel();
  }

  onBPM(int value) {
    _listDataBPM.add(value);
    int t = 0;
    for (int item in _listDataBPM) {
      t += item;
    }
    bpmAverage.value = t ~/ _listDataBPM.length;
  }

  onRawData(SensorValue value) {
    if (value.value > 75 || value.value < 65) {
      // finger out
      _timer?.cancel();
      _timer = null;
      _listDataBPM = [];
      bpmAverage.value = 0;
      progress.value = 0.0;
      currentMiniSecond = 0;
    } else {
      // finger ok
      if (_timer == null || _timer?.isActive != true) {
        _initTimer();
      }
    }
  }
}
