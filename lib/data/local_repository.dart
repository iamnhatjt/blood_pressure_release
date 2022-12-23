import 'package:bloodpressure/common/config/app_config.dart';
import 'package:bloodpressure/common/config/hive_config/hive_config.dart';
import 'package:bloodpressure/common/config/hive_config/hive_constants.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/model/blood_pressure_model.dart';
import 'package:bloodpressure/domain/model/blood_sugar_model.dart';
import 'package:bloodpressure/domain/model/bmi_model.dart';
import 'package:bloodpressure/domain/model/user_model.dart';

import '../common/util/share_preference_utils.dart';

class LocalRepository {
  final HiveConfig _hiveConfig;
  final SharePreferenceUtils _sharePreferenceUtils;

  LocalRepository(
      this._hiveConfig, this._sharePreferenceUtils);

  Future saveUser(UserModel user) async {
    _hiveConfig.userBox.put(HiveKey.userModel, user);
  }

  UserModel? getUser() {
    return _hiveConfig.userBox.get(HiveKey.userModel);
  }

  List<AlarmModel> getAlarms() {
    return _hiveConfig.alarmBox.values.toList();
  }

  Future<void> removeAlarm(int index) {
    final key = _hiveConfig.alarmBox.keyAt(index);
    return _hiveConfig.alarmBox.delete(key);
  }

  Future<void> addAlarm(AlarmModel alarmModel) {
    return _hiveConfig.alarmBox.add(alarmModel);
  }

  Future<void> updateAlarm(
      int index, AlarmModel alarmModel) {
    return _hiveConfig.alarmBox.putAt(index, alarmModel);
  }

  Future saveBloodPressure(
      BloodPressureModel bloodPressureModel) async {
    return await _hiveConfig.bloodPressureBox
        .put(bloodPressureModel.key, bloodPressureModel);
  }

  Future deleteBloodPressure(String key) async {
    await _hiveConfig.bloodPressureBox.delete(key);
  }

  List<BloodPressureModel> getAll() {
    return _hiveConfig.bloodPressureBox.values.toList();
  }

  List<BloodPressureModel> filterBloodPressureDate(
      int start, int end) {
    return _hiveConfig.bloodPressureBox.values
        .where((bloodPress) =>
            bloodPress.dateTime! >= start &&
            bloodPress.dateTime! <= end)
        .toList();
  }

  Future saveBMIModel(BMIModel bmi) async {
    await _hiveConfig.bmiBox.put(bmi.key, bmi);
  }

  List<BMIModel> filterBMI(int start, int end) {
    return _hiveConfig.bmiBox.values
        .where((bmi) =>
            bmi.dateTime! >= start && bmi.dateTime! <= end)
        .toList();
  }

  List<BMIModel> getAllBMI() =>
      _hiveConfig.bmiBox.values.toList();

  Future<bool> setWeightUnitId(int id) =>
      _sharePreferenceUtils.setInt(
          AppConfig.weightUnitIdKey, id);

  int? getWeightUnitId() => _sharePreferenceUtils
      .getInt(AppConfig.weightUnitIdKey);

  Future<bool> setHeightUnitId(int id) =>
      _sharePreferenceUtils.setInt(
          AppConfig.heightUnitIdKey, id);

  int? getHeightUnitId() => _sharePreferenceUtils
      .getInt(AppConfig.heightUnitIdKey);

  /**
   * Blood Sugar
   */
  Future<void> addBloodSugar(BloodSugarModel model) async {
    await _hiveConfig.bloodSugarBox.put(model.key, model);
  }

  List<BloodSugarModel> getAllBloodSugar() {
    return _hiveConfig.bloodSugarBox.values.toList();
  }

  List<BloodSugarModel> getAllBloodSugarByDate(
      {required int startDate, required int endDate}) {
    return _hiveConfig.bloodSugarBox.values
        .where((value) =>
            value.dateTime! >= startDate &&
            value.dateTime! <= endDate)
        .toList();
  }

  Future deleteBloodSugar(String key) async {
    await _hiveConfig.bloodSugarBox.delete(key);
  }
}
