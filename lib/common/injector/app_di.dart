import 'package:bloodpressure/common/config/hive_config/hive_config.dart';
import 'package:bloodpressure/data/local_repository.dart';
import 'package:bloodpressure/domain/usecase/alarm_usecase.dart';
import 'package:bloodpressure/domain/usecase/blood_pressure_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void configDI() {
  _configCommonDI();
  _configDataDI();
  _configDomainDI();
}

void _configCommonDI() {
  getIt.registerSingleton(HiveConfig());
}

void _configDataDI() {
  getIt.registerSingleton(
      LocalRepository(getIt<HiveConfig>()));
}

void _configDomainDI() {
  getIt.registerFactory(
      () => BloodPressureUseCase(getIt<LocalRepository>()));
  getIt.registerSingleton(AlarmUseCase(
      localRepository: getIt.get<LocalRepository>()));
}
