import 'package:bloodpressure/common/config/hive_config/hive_constants.dart';
import 'package:bloodpressure/common/extensions/double_extensions.dart';
import 'package:bloodpressure/common/util/convert_utils.dart';
import 'package:bloodpressure/data/local_repository.dart';
import 'package:bloodpressure/domain/enum/height_unit.dart';
import 'package:bloodpressure/domain/enum/weight_unit.dart';
import 'package:hive/hive.dart';

import '../../common/injector/app_di.dart';

part 'bmi_model.g.dart';

@HiveType(typeId: HiveTypeConstants.bmiModel)
class BMIModel extends HiveObject {
  @HiveField(0)
  String? key;
  @HiveField(1)
  double? weight; //unit is kg
  @HiveField(2)
  int? weightUnit;
  @HiveField(3)
  int? type;
  @HiveField(4)
  int? dateTime;
  @HiveField(5)
  int? age;
  @HiveField(6)
  double? height; //unit is m
  @HiveField(7)
  int? heightUnit;
  @HiveField(8)
  String? gender;
  @HiveField(9)
  int? bmi;
  BMIModel({
    this.key,
    this.weight,
    this.weightUnit,
    this.type,
    this.dateTime,
    this.age,
    this.height,
    this.heightUnit,
    this.gender,
    this.bmi,
  });

  ///Use only Weight and BMI screen
  double get weightByCurrentUnit {
    final id = getIt<LocalRepository>().getWeightUnitId();
    final currentWeightUnit =
        WeightUnitEnum.getWeightUnitById(id);
    final unit =
        WeightUnitEnum.getWeightUnitById(weightUnit);
    if (currentWeightUnit == unit) {
      return weight ?? 0.0;
    } else {
      return currentWeightUnit
          .convertToUnit(weight ?? 0.0)
          .roundDouble(1);
    }
  }

  double get heightCm {
    final unit =
        HeightUnitEnum.getHeigtUnitById(heightUnit);
    if (unit == HeightUnit.cm) {
      return height ?? 0.0;
    } else {
      return ConvertUtils.convertMToCM(height ?? 0.0)
          .roundDouble(1);
    }
  }

  double get weightKg {
    final unit =
        WeightUnitEnum.getWeightUnitById(weightUnit);
    if (unit == WeightUnit.kg) {
      return weight ?? 0.0;
    } else {
      return ConvertUtils.convertLbToKg(weight ?? 0.0)
          .roundDouble(1);
    }
  }
}
