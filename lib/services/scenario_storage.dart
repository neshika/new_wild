// Импортируем библиотеку для работы с JSON (кодирование/декодирование)
import 'dart:convert';

// Импортируем модель данных результата сценария
import 'package:new_wild/models/scenario_result_model.dart';

// Импортируем пакет для локального хранилища на устройстве
import 'package:shared_preferences/shared_preferences.dart';

// Класс для работы с локальным хранилищем сценариев
// Использует SharedPreferences - простое key-value хранилище
class ScenarioStorage {
  // Ключ для хранения данных в SharedPreferences
  // _kScenarioKey - приватная константа (начинается с _)
  static const String _kScenarioKey = 'scenario';

  // Метод для сохранения сценария в локальное хранилище
  Future<void> saveScenario(ScenarioResultModel scenario) async {
    // Получаем экземпляр SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Преобразуем объект сценария в JSON строку:
    // 1. scenario.toJson() - преобразуем объект в Map
    // 2. json.encode() - преобразуем Map в строку JSON
    final scenarioJson = json.encode(scenario.toJson());

    // Сохраняем JSON строку в хранилище по ключу _kScenarioKey
    await prefs.setString(_kScenarioKey, scenarioJson);
  }

  // Метод для загрузки сценария из локального хранилища
  Future<ScenarioResultModel?> loadScenario() async {
    // Получаем экземпляр SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Пытаемся получить сохраненную JSON строку по ключу
    final scenarioJson = prefs.getString(_kScenarioKey);

    // Если ничего не найдено (первый запуск или данные удалены) - возвращаем null
    if (scenarioJson == null) return null;

    // Преобразуем JSON строку обратно в объект:
    // 1. json.decode() - преобразуем строку JSON в Map
    // 2. ScenarioResultModel.fromJson() - создаем объект из Map
    return ScenarioResultModel.fromJson(json.decode(scenarioJson));
  }
}
