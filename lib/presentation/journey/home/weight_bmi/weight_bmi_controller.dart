import 'package:bloodpressure/common/mixin/alarm_dialog_mixin.dart';
import 'package:bloodpressure/domain/enum/bmi_type.dart';
import 'package:bloodpressure/domain/enum/height_unit.dart';
import 'package:bloodpressure/domain/enum/weight_unit.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/model/bmi_model.dart';
import 'package:bloodpressure/domain/usecase/bmi_usecase.dart';
import 'package:bloodpressure/presentation/journey/alarm/alarm_controller.dart';
import 'package:bloodpressure/presentation/journey/home/weight_bmi/add_weight_bmi/add_weight_bmi_dialog.dart';
import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/constants/app_constant.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/mixin/date_time_mixin.dart';
import '../../../../common/util/app_util.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/enum/alarm_type.dart';
import '../../../../domain/usecase/alarm_usecase.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/snack_bar/app_snack_bar.dart';

class WeightBMIController extends GetxController
    with DateTimeMixin, AlarmDialogMixin {
  final RxBool isExporting = false.obs;
  late BuildContext context;
  RxList<BMIModel> bmiList = <BMIModel>[].obs;
  Rx<BMIModel> currentBMI = BMIModel().obs;
  RxList<Map> bmiChartListData = RxList();
  RxList<Map> weightChartListData = RxList();
  Rx<DateTime> chartMinDate = DateTime.now().obs;
  Rx<DateTime> chartMaxDate = DateTime.now().obs;
  RxInt spotIndex = 0.obs;

  RxInt chartSelectedX = 0.obs;

  final Rx<WeightUnit> weightUnit = WeightUnit.kg.obs;
  final Rx<HeightUnit> heightUnit = HeightUnit.cm.obs;

  final BMIUsecase _bmiUsecase;
  final AlarmUseCase _alarmUseCase;

  final analytics = FirebaseAnalytics.instance;

  WeightBMIController(this._bmiUsecase, this._alarmUseCase);

  @override
  void onInit() {
    filterWeightBMI();
    _getWeightUnit();
    super.onInit();
  }

  void _getWeightUnit() {
    final unitId = _bmiUsecase.getWeightUnitId();
    weightUnit.value =
        WeightUnitEnum.getWeightUnitById(unitId);
  }

  void exportData() async {
    analytics.logEvent(name: AppLogEvent.exportWeightBMI);
    debugPrint(
        "Logged ${AppLogEvent.exportWeightBMI} at ${DateTime.now()}");
    isExporting.value = true;
    List<String> header = [];
    List<List<String>> listOfData = [];
    header.add(TranslationConstants.date.tr);
    header.add(TranslationConstants.time.tr);
    header.add(TranslationConstants.bmi.tr);
    header.add("${TranslationConstants.weight.tr} (kg)");
    header.add("${TranslationConstants.height.tr} (cm)");
    header.add(TranslationConstants.age.tr);
    header.add(TranslationConstants.gender.tr);
    header.add(TranslationConstants.type.tr);
    for (final item in bmiList) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(
              item.dateTime ?? 0);
      final bmiType =
          BMITypeEnum.getBMITypeById(item.typeId);
      Map initialGender = AppConstant.listGender.firstWhere(
          (element) =>
              element['id'] == (item.gender ?? '0'),
          orElse: () => AppConstant.listGender.first);
      final gender = chooseContentByLanguage(
          initialGender['nameEN'], initialGender['nameVN']);
      listOfData.add([
        DateFormat('MMM dd, yyyy').format(dateTime),
        DateFormat('h:mm a').format(dateTime),
        '${item.bmi ?? 0}',
        '${item.weightKg}',
        '${item.heightCm}',
        '${item.age}',
        gender,
        bmiType.bmiName
      ]);
    }
    await exportFile(header, listOfData);
    isExporting.value = false;
  }

  void filterWeightBMI() {
    bmiList.value = _bmiUsecase.filterBMI(
      filterStartDate.value.millisecondsSinceEpoch,
      filterEndDate.value.millisecondsSinceEpoch,
    );
    if (bmiList.isNotEmpty) {
      currentBMI.value = bmiList.last;
    }
    _generateDataChart();
  }

  void onSetAlarm() {
    showAddAlarm(
        context: context,
        alarmType: AlarmType.weightAndBMI,
        onPressCancel: Get.back,
        onPressSave: _onSaveAlarm);
  }

  void _onSaveAlarm(AlarmModel alarm) async {
    _alarmUseCase.addAlarm(alarm);
    Get.find<AlarmController>().refresh();
    Get.back();
  }

  void onAddData() async {
    analytics.logEvent(
        name: AppLogEvent.addDataButtonWeightBMI);
    debugPrint(
        "Logged ${AppLogEvent.addDataButtonWeightBMI} at ${DateTime.now()}");
    final result = await showAppDialog(context, "", "",
        builder: (ctx) => const AddWeightBMIDialog());
    if (result ?? false) {
      filterWeightBMI();
    }
  }

  void _generateDataChart() {
    List<Map> listDataChart = [];
    List<Map> weightDataChart = [];
    Map mapGroupData = groupBy(
        bmiList,
        (p0) => DateFormat('dd/MM/yyyy').format(
            DateTime.fromMillisecondsSinceEpoch(
                p0.dateTime ?? 0)));
    DateTime? minDate;
    DateTime? maxDate;
    mapGroupData.forEach((key, value) {
      DateTime handleDate =
          DateFormat('dd/MM/yyyy').parse(key);
      if (minDate == null || minDate!.isAfter(handleDate)) {
        minDate = handleDate;
      }
      if (maxDate == null ||
          maxDate!.isBefore(handleDate)) {
        maxDate = handleDate;
      }
      if (((value ?? []) as List).isNotEmpty) {
        BMIModel bmiModel = value[0];
        for (BMIModel item in value) {
          if ((item.dateTime ?? 0) >
              (bmiModel.dateTime ?? 0)) {
            bmiModel = item;
          }
        }
        listDataChart.add({
          'date': handleDate,
          'value': bmiModel.bmi,
          'timeStamp': bmiModel.dateTime
        });
        weightDataChart.add({
          'date': handleDate,
          'value': bmiModel.weightKg,
          'timeStamp': bmiModel.dateTime
        });
      }
    });

    bmiChartListData.value = listDataChart;
    spotIndex.value = bmiChartListData.length - 1;
    weightChartListData.value = weightDataChart;
    if (minDate != null) {
      chartMinDate.value = minDate!;
    }
    if (maxDate != null) {
      chartMaxDate.value = maxDate!;
    }
  }

  void onEditBMI() async {
    final result = await showAppDialog(context, "", "",
        builder: (ctx) => AddWeightBMIDialog(
              bmiModel: currentBMI.value,
            ));
    if (result ?? false) {
      filterWeightBMI();
    }
  }

  void onDeleteBMI() async {
    await _bmiUsecase.deleteBMI(currentBMI.value.key ?? '');
    filterWeightBMI();
    showTopSnackBar(context,
        message: TranslationConstants.deleteDataSuccess.tr,
        type: SnackBarType.done);
  }
}
