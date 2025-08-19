// Импортируем файл с вспомогательными функциями и определениями
// В этом файле likely находится определение enum SocialPlatform
import 'package:new_wild/services/helpers.dart';

// Модель данных, представляющая запрос на генерацию сценария
// Это как "анкета" или "форма заказа" для создания видео
class ScenarioRequestModel {
  // Поля класса (final означает, что они не могут быть изменены после создания)
  final SocialPlatform
      platform; // Платформа для которой создается видео (VK, YouTube)
  final String videoTheme; // Тема видео (например, "путешествие на Бали")
  final String targetAudience; // Целевая аудитория (например, "IT специалисты")
  final int videoLengthInSecond; // Длина видео в секундах (для Shorts/Клипов)
  final String contentStyle; // Стиль контента (например, "информационный")
  final String callToAction; // Призыв к действию (например, "подпишитесь")

  // Конструктор класса - требуется передать все параметры при создании объекта
  ScenarioRequestModel({
    required this.platform,
    required this.videoTheme,
    required this.targetAudience,
    required this.videoLengthInSecond,
    required this.contentStyle,
    required this.callToAction,
  });

  // Метод для преобразования объекта в формат JSON (Map)
  // Нужен для отправки данных на сервер или сохранения в базу данных
  Map<String, dynamic> toJson() {
    return {
      'platform': platform.toString(), // Преобразуем enum в строку
      'videoTheme': videoTheme,
      'targetAudience': targetAudience,
      'videoLengthInSecond': videoLengthInSecond,
      'contentStyle': contentStyle,
      'callToAction': callToAction,
    };
  }

  // Статический метод для создания объекта из JSON данных
  // Нужен для получения данных от сервера или из базы данных
  static ScenarioRequestModel fromJson(Map<String, dynamic> json) {
    return ScenarioRequestModel(
      // Ищем в значениях enum SocialPlatform то, которое соответствует строке из JSON
      platform: SocialPlatform.values
          .firstWhere((element) => element.toString() == json['platform']),
      videoTheme: json['videoTheme'],
      targetAudience: json['targetAudience'],
      videoLengthInSecond: json['videoLengthInSecond'],
      contentStyle: json['contentStyle'],
      callToAction: json['callToAction'],
    );
  }
}
