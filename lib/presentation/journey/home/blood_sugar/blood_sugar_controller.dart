import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/common/util/app_util.dart';
import 'package:bloodpressure/domain/model/blood_sugar_model.dart';
import 'package:bloodpressure/domain/usecase/blood_sugar_usecase.dart';
import 'package:bloodpressure/presentation/controller/app_base_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/select_state_mixin.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_blood_sugar_dialog/blood_sugar_add_data_dialog.dart';

class BloodSugarController extends AppBaseController
    with DateTimeMixin, SelectStateMixin {
  final BloodSugarUseCase useCase;

  late List<BloodSugarModel> bloodSugarDataList;

  RxDouble rxAverage = 0.0.obs;
  RxDouble rxMin = 0.0.obs;
  RxDouble rxMax = 0.0.obs;
  RxBool rxIsEmptyList = true.obs;
  Rx<BloodSugarModel> selectedBloodSugar = BloodSugarModel().obs;

  BloodSugarController(this.useCase);

  Future<void> onSelectedDateTime() async {
    await onPressDateRange(context);
    _onRefreshData();
  }

  void onDeleted(String key) async {
    await useCase.deleteBloodSugar(key);
  }

  void onSetAlarm() {
    onSelectTime(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  Future<void> onEdited() async {
    final result = await showAppDialog(context, "", "",
        builder: (ctx) => const BloodSugarAddDataDialog());
    await _onRefreshData();
  }

  Future onAddData() async {
    final result = await showAppDialog(context, "", "",
        builder: (ctx) => const BloodSugarAddDataDialog());
    await _onRefreshData();
    // if (result != null && result) {
    //   _filterBloodPressure();
    // }
  }

  Future<void> _getAllBloodSugarByDate() async {
    bloodSugarDataList = useCase.getAllBloodSugarByDate(
        startDate: filterStartDate.value, endDate: filterEndDate.value);
    rxIsEmptyList.value = isNullEmptyList(bloodSugarDataList);
  }

  void _setStatisticalData() {
    if (rxIsEmptyList.value == false) {
      var bloodSugarList = bloodSugarDataList;
      bloodSugarList.sort((a, b) => a.measure!.compareTo(b.measure!));
      // Lay max
      rxMax.value = bloodSugarDataList.first.measure!;
      // Lay min
      rxMin.value = bloodSugarDataList.last.measure!;
      // Lay trung binh
      if (rxMax.value == rxMin.value) {
        rxAverage.value = rxMax.value;
      } else {
        rxAverage.value =
            (rxMax.value - rxMin.value) / bloodSugarDataList.length;
      }
      // Lay detail moi nhat
      bloodSugarList.sort((a,b) => a.dateTime!.compareTo(b.dateTime!));
      selectedBloodSugar.value = bloodSugarList.first;
    }
  }

  Future<void> _onRefreshData() async {
    await _getAllBloodSugarByDate();
    _setStatisticalData();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _onRefreshData();
  }
}
