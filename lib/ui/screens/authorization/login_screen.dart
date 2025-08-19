// Импортируем необходимые библиотеки Flutter
import 'package:flutter/material.dart';
// Импортируем сервис аутентификации
import 'package:new_wild/services/auth.dart';
// Импортируем вспомогательные функции (validateEmail)
import 'package:new_wild/services/helpers.dart';
// Импортируем экран восстановления пароля
import 'package:new_wild/ui/screens/authorization/forgot_password_screen.dart';

// Экран входа в приложение
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Контроллеры для полей ввода email и пароля
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  // Ключ для доступа и управления состоянием формы
  final _formKey = GlobalKey<FormState>();

  // Экземпляр сервиса аутентификации
  final authService = Auth();

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллеры при создании виджета
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Отступы от краев
          child: Form(
            key: _formKey, // Связываем форму с ключом
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Колонка занимает минимальное место
              children: [
                // Заголовок приветствия
                Text(
                  'Welcome',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0), // Отступ после заголовка

                // Поле ввода email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(), // Рамка вокруг поля
                  ),
                  validator: validateEmail, // Проверка валидности email
                ),
                const SizedBox(height: 20.0), // Отступ между полями

                // Поле ввода пароля
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Скрытие текста пароля (звездочки)
                  // Можно добавить validator для пароля при необходимости
                ),
                const SizedBox(height: 20.0), // Отступ после пароля

                // Ряд с кнопками Входа и Регистрации
                Row(
                  mainAxisSize:
                      MainAxisSize.min, // Кнопки занимают минимальное место
                  children: [
                    // Кнопка Входа
                    ElevatedButton(
                      onPressed: () {
                        // Проверяем валидность формы
                        if (_formKey.currentState!.validate()) {
                          // Если валидация успешна - выполняем вход
                          authService.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(width: 20.0), // Отступ между кнопками

                    // Кнопка Регистрации
                    ElevatedButton(
                      onPressed: () {
                        // Проверяем валидность формы
                        if (_formKey.currentState!.validate()) {
                          // Если валидация успешна - создаем нового пользователя
                          authService.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: const Text('Register'),
                    )
                  ],
                ),
                const SizedBox(height: 10.0), // Отступ после кнопок

                // Кнопка "Забыли пароль?"
                TextButton(
                    onPressed: () {
                      // Переход на экран восстановления пароля
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text('Forgot password'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
