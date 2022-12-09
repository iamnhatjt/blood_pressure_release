import 'dart:async';
import 'package:bloodpressure/app/controller/heart_beat_controller.dart';
import 'package:bloodpressure/app/data/model/heart_rate_model.dart';
import 'package:bloodpressure/app/ui/widget/heart_bpm.dart';
import 'package:bloodpressure/app/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../res/string/app_strings.dart';
import '../ui/widget/app_dialog.dart';
import '../ui/widget/app_dialog_heart_rate_widget.dart';
import '../util/app_permission.dart';
import 'app_controller.dart';

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
  int _recentBPM = 0;
  final AppController _appController = Get.find<AppController>();

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  _initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      if (currentMiniSecond == totalMiniSecondsToMeasure) {
        currentMiniSecond = 0;
        timer.cancel();
        onPressStopMeasure();
        showAppDialog(
          context,
          '',
          '',
          hideGroupButton: true,
          widgetBody: AppDialogHeartRateWidget(
            inputDateTime: DateTime.now(),
            inputValue: _recentBPM,
            onPressCancel: () {
              Get.back();
              _recentBPM = 0;
            },
            onPressAdd: (dateTime, value) {
              if (Get.isRegistered<HeartBeatController>()) {
                Get.find<HeartBeatController>().updateHeartRateData(HeartRateModel(
                  timeStamp: dateTime.millisecondsSinceEpoch,
                  value: value,
                  age: _appController.currentUser.value.age ?? 30,
                  genderId: _appController.currentUser.value.genderId ?? '0',
                ));
              }
              Get.back();
              showToast(StringConstants.addSuccess.tr);
              _recentBPM = 0;
            },
          ),
        );
      } else {
        currentMiniSecond = currentMiniSecond + 200;
        progress.value = currentMiniSecond / totalMiniSecondsToMeasure;
      }
    });
  }

  onPressStartMeasure() {
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
    _recentBPM = bpmAverage.value;
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
