// Импортируем пакет Dio для выполнения HTTP-запросов
import 'package:dio/dio.dart';

// ✅ Базовый URL API OpenAI через прокси (без пробелов в конце)
const String baseUrl = 'https://openai.api.proxyapi.ru/v1/chat/completions';
// ✅ API-ключ для аутентификации (в реальном приложении должен храниться безопасно!)
const String apiKey = 'sk-JuUam0b8FY1RgXjzzCYo6T7LewvAiZHn';

// Класс-клиент для работы с OpenAI API через прокси-сервер
class DioClient {
  // Приватный конструктор - запрещаем создание экземпляров извне
  DioClient._();

  // Создаем единственный экземпляр класса (паттерн Singleton)
  static final DioClient instance = DioClient._();

  // Создаем экземпляр Dio с базовыми настройками
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl, // Базовый URL для всех запросов
    connectTimeout: Duration(seconds: 15), // Таймаут подключения - 15 секунд
    receiveTimeout:
        Duration(seconds: 30), // Таймаут получения данных - 30 секунд
    responseType: ResponseType.json, // Ожидаем ответ в формате JSON
    headers: {
      // Заголовки HTTP-запроса
      'Authorization': 'Bearer $apiKey', // Ключ авторизации
      'Content-Type': 'application/json', // Тип содержимого - JSON
    },
  ));

  // Метод для получения сценария от OpenAI
  Future<String> getScenario(String userMessage) async {
    try {
      // ✅ Формируем тело запроса (исправлено messages с буквой s)
      final Map<String, dynamic> data = {
        'model': 'gpt-4o-mini', // Модель ИИ для генерации
        'messages': [
          // Массив сообщений диалога
          {
            'role': 'user', // Роль отправителя - пользователь
            'content':
                userMessage, // Сообщение пользователя (запрос на сценарий)
          }
        ],
        'max_tokens': 500, // Максимальное количество токенов в ответе
        'temperature':
            0.7, // "Творческость" ответа (0-1, где 1 - самый креативный)
      };

      // Выполняем POST-запрос к API (пустой путь '', т.к. baseUrl уже содержит полный путь)
      final Response response = await _dio.post('', data: data);

      // ✅ Проверяем успешный статус ответа (200 OK)
      if (response.statusCode == 200) {
        // Извлекаем сгенерированный текст из сложной структуры ответа OpenAI
        return response.data['choices'][0]['message']['content'] ??
            'No response generated'; // Если ответ пустой - возвращаем заглушку
      } else {
        // Если статус не 200 - бросаем исключение с деталями
        throw 'Unexpected status code: ${response.statusCode}, Response: ${response.data}';
      }
    } on DioException catch (e) {
      // ✅ Ловим специфические ошибки Dio (сетеые ошибки, таймауты и т.д.)
      if (e.response != null) {
        // Если есть ответ от сервера (но с ошибкой)
        // Раскомментируйте для отладки:
        // print('Status: ${e.response?.statusCode}');
        // print('Response data: ${e.response?.data}');
        // print('Headers: ${e.response?.headers}');
      } else {
        // Если ошибка на уровне сети (нет подключения и т.д.)
        // print('Error: ${e.message}');
      }
      rethrow; // Пробрасываем ошибку дальше для обработки в UI
    } catch (e) {
      // Ловим любые другие непредвиденные ошибки
      // print('General error: $e');
      rethrow; // Пробрасываем ошибку дальше
    }
  }
}
