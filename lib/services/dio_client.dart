import 'package:dio/dio.dart';

// ✅ Убраны пробелы в конце URL
const String baseUrl = 'https://openai.api.proxyapi.ru/v1/chat/completions';
const String apiKey = 'sk-JuUam0b8FY1RgXjzzCYo6T7LewvAiZHn';

class DioClient {
  DioClient._();

  static final DioClient instance = DioClient._();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 30),
    responseType: ResponseType.json,
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
  ));

  Future<String> getScenario(String userMessage) async {
    try {
      // ✅ Исправлено: messages (с буквой s)
      final Map<String, dynamic> data = {
        'model': 'gpt-4o-mini',
        'messages': [
          {
            'role': 'user',
            'content': userMessage,
          }
        ],
        'max_tokens': 500,
        'temperature': 0.7,
      };

      final Response response = await _dio.post('', data: data);

      // ✅ Проверка успешного статуса
      if (response.statusCode == 200) {
        return response.data['choices'][0]['message']['content'] ??
            'No response generated';
      } else {
        throw 'Unexpected status code: ${response.statusCode}, Response: ${response.data}';
      }
    } on DioException catch (e) {
      // ✅ Показываем детали ошибки
      if (e.response != null) {
      //  print('Status: ${e.response?.statusCode}');
      //  print('Response data: ${e.response?.data}');
      //  print('Headers: ${e.response?.headers}');
      } else {
       // print('Error: ${e.message}');
      }
      rethrow;
    } catch (e) {
    //  print('General error: $e');
      rethrow;
    }
  }
}
