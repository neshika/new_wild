// Импортируем модель запроса сценария, чтобы использовать ее в этой модели
import 'package:new_wild/models/scenario_request_model.dart';

// Модель данных, представляющая РЕЗУЛЬТАТ генерации сценария
// Это как "готовый заказ" или "сгенерированный сценарий" с полной информацией
class ScenarioResultModel {
  // Поля класса (final - неизменяемые после создания)
  final String id; // Уникальный идентификатор сценария
  final String
      title; // Заголовок сценария (например, "Discover Bali: Your Ultimate Travel Guide")
  final String
      body; // Основное содержимое/текст сценария (что озвучивать, описание)
  final ScenarioRequestModel
      request; // Исходный запрос, на основе которого был создан этот результат

  // Конструктор класса - требует все параметры при создании
  ScenarioResultModel({
    required this.id,
    required this.title,
    required this.body,
    required this.request,
  });

  // Метод для преобразования объекта в JSON (для отправки/сохранения)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'request': request.toJson(), // Преобразуем вложенный объект тоже в JSON
    };
  }

  // Статический метод для создания объекта из JSON (для получения/загрузки)
  static ScenarioResultModel fromJson(Map<String, dynamic> json) {
    return ScenarioResultModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      request: ScenarioRequestModel.fromJson(
          json['request']), // Создаем вложенный объект из JSON
    );
  }
}
