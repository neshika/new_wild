import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_wild/models/scenario_result_model.dart';
import 'package:new_wild/services/auth.dart';

class FirebaseStorage {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveScenario(ScenarioResultModel scenario) async {
    // по ИД пользователя создаем коллекции (сохраняем)

    final userId = Auth().getUserId;
    if (userId != null) {
      await _db.collection(userId).doc(scenario.id).set(scenario.toJson());
    } else {
      throw Exception('User not authenticated');
    }
  }

  Future<void> deleteScenario(String documentId) async {
    // по ИД пользователя создаем коллекции (удаляем)

    final userId = Auth().getUserId;
    if (userId != null) {
      await _db.collection(userId).doc(documentId).delete();
    } else {
      throw Exception('User not authenticated');
    }
  }

  //получение сценария подписка
  Stream<List<ScenarioResultModel>> getScenariosStream() {
    final userId = Auth().getUserId;
    if (userId != null) {
      return _db.collection(userId).snapshots().map((snapshot) => snapshot.docs
          .map(
            (doc) => ScenarioResultModel.fromJson(
              doc.data(),
            ),
          )
          .toList());
    } else {
      throw Exception('User not authenticated');
    }
  }
}
