// Импортируем необходимые библиотеки Flutter
import 'package:flutter/material.dart';
// Импортируем наш сервис аутентификации
import 'package:new_wild/services/auth.dart';
// Импортируем вспомогательные функции, включая validateEmail
import 'package:new_wild/services/helpers.dart';

// Экран восстановления пароля
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Контроллер для поля ввода email - позволяет получать и управлять текстом
  late final TextEditingController _emailController;

  // Ключ для доступа и управления состоянием формы (валидация и т.д.)
  final _formKey = GlobalKey<FormState>();

  // Создаем экземпляр сервиса аутентификации
  final authService = Auth();

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллер email при создании виджета
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Заголовок в верхней панели
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: Padding(
          // Отступы от краев экрана
          padding: const EdgeInsets.all(16.0),
          child: Form(
            // Связываем форму с нашим ключом
            key: _formKey,
            child: Column(
              // Колонка занимает минимально необходимое пространство
              mainAxisSize: MainAxisSize.min,
              children: [
                // Поле ввода email
                TextFormField(
                  controller: _emailController, // Привязываем контроллер
                  decoration: const InputDecoration(
                    labelText: 'Email', // Подпись над полем
                    hintText: 'Enter your Email', // Подсказка внутри поля
                    border: OutlineInputBorder(), // Рамка вокруг поля
                  ),
                  // Валидатор - функция проверки корректности введенных данных
                  validator: validateEmail,
                ),
                // Просто пустое пространство высотой 20 пикселей
                const SizedBox(
                  height: 20.0,
                ),
                // Кнопка отправки ссылки для восстановления
                ElevatedButton(
                  onPressed: () {
                    // Проверяем, прошла ли форма валидацию
                    if (_formKey.currentState!.validate()) {
                      // Если email валиден - отправляем запрос на восстановление
                      authService.repearPassword(email: _emailController.text);
                      // Закрываем текущий экран и возвращаемся назад
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Send Reset Link'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
