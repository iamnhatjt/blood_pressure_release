import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AlarmDialogController extends GetxController {
  static final AlarmModel defaultModel = AlarmModel(
      id: const Uuid().v4(),
      type: AlarmType.heartRate,
      time: DateTime.now(),
      alarmDays: List<bool>.generate(7, (index) => false));

  Rx<AlarmModel> alarmModel = defaultModel
      .copyWith(id: Uuid().v4())
      .obs;
  RxBool isValid = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    _validate();
    super.onInit();
  }

  void onSelectedWeekDaysChanged(List<bool> days) {
    alarmModel.value = alarmModel.value.copyWith(alarmDays: days);
    _validate();
  }

  void onTimeChange(DateTime value) {
    alarmModel.value = alarmModel.value.copyWith(time: value);
    _validate();
  }

  void _validate() {
    final days = alarmModel.value.alarmDays!;
    if (days
        .where((element) => !element)
        .isEmpty) {
      isValid.value = false;
    } else {
      isValid.value = true;
    }
  }
}
