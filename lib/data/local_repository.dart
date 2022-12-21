import 'package:bloodpressure/common/config/hive_config/hive_config.dart';
import 'package:bloodpressure/common/config/hive_config/hive_constants.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/model/blood_pressure_model.dart';
import 'package:bloodpressure/domain/model/user_model.dart';

class LocalRepository {
  final HiveConfig hiveConfig;

  LocalRepository(this.hiveConfig);

  Future saveUser(UserModel user) async {
    hiveConfig.userBox.put(HiveKey.userModel, user);
  }

  UserModel? getUser() {
    return hiveConfig.userBox.get(HiveKey.userModel);
  }

  List<AlarmModel> getAlarms() {
    return hiveConfig.alarmBox.values.toList();
  }

  Future<void> removeAlarm(int index) {
    final key = hiveConfig.alarmBox.keyAt(index);
    return hiveConfig.alarmBox.delete(key);
  }

  Future<void> addAlarm(AlarmModel alarmModel) {
    return hiveConfig.alarmBox.add(alarmModel);
  }

  Future<void> updateAlarm(
      int index, AlarmModel alarmModel) {
    return hiveConfig.alarmBox.putAt(index, alarmModel);
  }

  Future saveBloodPressure(
      BloodPressureModel bloodPressureModel) async {
    return await hiveConfig.bloodPressureBox
        .put(bloodPressureModel.key, bloodPressureModel);
  }

  Future deleteBloodPressure(String key) async {
    await hiveConfig.bloodPressureBox.delete(key);
  }

  List<BloodPressureModel> getAll() {
    return hiveConfig.bloodPressureBox.values.toList();
  }

  List<BloodPressureModel> filterBloodPressureDate(
      int start, int end) {
    return hiveConfig.bloodPressureBox.values
        .where((bloodPress) =>
            bloodPress.dateTime! >= start &&
            bloodPress.dateTime! <= end)
        .toList();
  }
}
