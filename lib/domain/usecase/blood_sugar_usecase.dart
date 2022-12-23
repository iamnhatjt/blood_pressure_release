import 'package:bloodpressure/data/local_repository.dart';
import 'package:bloodpressure/domain/model/blood_sugar_model.dart';

class BloodSugarUseCase {
  final LocalRepository repository;

  BloodSugarUseCase(this.repository);

  Future<void> addBloodSugarData(BloodSugarModel model) =>
      repository.addBloodSugar(model);

  List<BloodSugarModel> getAllBloodSugar() => repository.getAllBloodSugar();

  List<BloodSugarModel> getAllBloodSugarByDate(
      {required DateTime startDate, required DateTime endDate}) {
    return repository.getAllBloodSugarByDate(
        startDate: startDate.millisecondsSinceEpoch,
        endDate: endDate.millisecondsSinceEpoch);
  }

  Future deleteBloodSugar(String key) => repository.deleteBloodSugar(key);
}
