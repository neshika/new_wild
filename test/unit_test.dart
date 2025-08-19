// Импортируем библиотеку для тестирования виджетов и логики Flutter-приложений
import 'package:flutter_test/flutter_test.dart';
// Импортируем наш файл с вспомогательными функциями, который будем тестировать
import 'package:new_wild/services/helpers.dart';

// Главная функция тестов - запускает все тесты, которые в ней определены
void main() {
  // Группируем тесты для функции validateEmail для лучшей организации
  // Все тесты внутри этой группы проверяют работу функции validateEmail
  group('validateEmail', () {
    // Тест 1: Проверяем поведение функции при передаче null
    test('Returns error when Email is null', () {
      // expect - функция утверждения: проверяет, что фактический результат соответствует ожидаемому
      // Мы ожидаем, что validateEmail(null) вернет строку с ошибкой
      expect(validateEmail(null), 'Email cannot be empty');
    });

    // Тест 2: Проверяем поведение функции при передаче пустой строки
    test('Returns error when Email is empty', () {
      // Ожидаем, что validateEmail('') также вернет ошибку о пустоте
      expect(validateEmail(''), 'Email cannot be empty');
    });

    // Тест 3: Проверяем обработку email без символа @
    test('Returns error when Email does not contain "@"', () {
      // Email без @ должен считаться невалидным
      expect(validateEmail('dfsdf.eff'), 'Please enter a valid email address');
    });

    // Тест 4: Проверяем обработку email где @ стоит в начале
    test('Returns error when Email does not contain "@"', () {
      // @ в начале - тоже невалидный формат
      expect(validateEmail('@dfsdf.eff'), 'Please enter a valid email address');
    });

    // Тест 5: Проверяем обработку email где @ стоит в конце
    test('Returns error when Email does not contain "@"', () {
      // @ в конце - невалидный формат
      expect(validateEmail('dfsdf.eff@'), 'Please enter a valid email address');
    });

    // Тест 6: Проверяем, что корректный email проходит валидацию
    test('Returns null when Email valid', () {
      // Для валидного email функция должна возвращать null (ошибок нет)
      expect(validateEmail('test@eff.ru'), null);
    });
  });
}
