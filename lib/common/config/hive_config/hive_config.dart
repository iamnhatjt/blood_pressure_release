import 'package:bloodpressure/common/config/hive_config/hive_constants.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:bloodpressure/domain/model/blood_sugar_model.dart';
import 'package:bloodpressure/domain/model/bmi_model.dart';
import 'package:bloodpressure/domain/model/user_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart'
    as path_provider;

import '../../../domain/model/blood_pressure_model.dart';

class HiveConfig {
  late Box<UserModel> userBox;
  late Box<AlarmModel> alarmBox;
  late Box<BloodPressureModel> bloodPressureBox;
  late Box<BloodSugarModel> bloodSugarBox;
  late Box<BMIModel> bmiBox;

  Future<void> init() async {
    final appDocumentDirectory = await path_provider
        .getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(AlarmModelAdapter());
    Hive.registerAdapter(AlarmTypeAdapter());
    userBox = await Hive.openBox(HiveBox.userBox);
    alarmBox = await Hive.openBox(HiveBox.alarmBox);
    Hive.registerAdapter(BloodPressureModelAdapter());
    bloodPressureBox =
        await Hive.openBox(HiveBox.bloodPressureBox);
    Hive.registerAdapter(BMIModelAdapter());
    bmiBox = await Hive.openBox(HiveBox.bmiBox);
    Hive.registerAdapter(BloodSugarModelAdapter());
    bloodSugarBox = await Hive.openBox(HiveBox.bloodSugarBox);
  }

  void dispose() {
    userBox.compact();
    alarmBox.compact();
    bloodPressureBox.compact();
    bmiBox.compact();
    bloodSugarBox.compact();
    Hive.close();
  }
}
