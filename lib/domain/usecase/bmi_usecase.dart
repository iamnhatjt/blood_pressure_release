import 'package:bloodpressure/data/local_repository.dart';
import 'package:bloodpressure/domain/model/bmi_model.dart';

class BMIUsecase {
  final LocalRepository _localRepository;

  BMIUsecase(this._localRepository);

  Future saveBMI(BMIModel bmi) =>
      _localRepository.saveBMIModel(bmi);

  List<BMIModel> getAll() => _localRepository.getAllBMI();

  List<BMIModel> filterBMI(int start, int end) =>
      _localRepository.filterBMI(start, end);

  Future<bool> setWeightUnitId(int id) =>
      _localRepository.setWeightUnitId(id);

  int? getWeightUnitId() =>
      _localRepository.getWeightUnitId();

  Future<bool> setHeightUnitId(int id) =>
      _localRepository.setHeightUnitId(id);

  int? getHeightUnitId() =>
      _localRepository.getHeightUnitId();
}
