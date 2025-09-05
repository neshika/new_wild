// Импортируем необходимые библиотеки и пакеты
import 'package:firebase_auth/firebase_auth.dart'; // Для работы с аутентификацией Firebase
import 'package:firebase_core/firebase_core.dart'; // Основной пакет Firebase для инициализации
import 'package:flutter/material.dart'; // Основная библиотека Flutter для создания UI
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_wild/redux/store.dart';
import 'package:new_wild/services/auth.dart'; // Наш кастомный сервис для работы с аутентификацией
import 'package:new_wild/ui/home_screen.dart'; // Экран, который увидит авторизованный пользователь
import 'package:new_wild/ui/screens/authorization/login_screen.dart'; // Экран входа для неавторизованных пользователей

// Главная функция, с которой начинается выполнение любого приложения Flutter
void main() async {
  // Ключевое слово 'async' означает, что функция будет выполнять асинхронные операции
  // Эта строка гарантирует, что все связи между кодом Flutter и нативным кодом платформы установлены
  WidgetsFlutterBinding.ensureInitialized();

  // Асинхронно инициализируем Firebase, ждем завершения инициализации
  await Firebase.initializeApp();

  // Запускаем наше приложение, передавая ему виджет MyApp
  runApp(const MyApp());
}

// Основной виджет нашего приложения
class MyApp extends StatelessWidget {
  // StatelessWidget - виджет, который не меняет свое состояние
  const MyApp({super.key}); // Конструктор с ключом

  // Этот метод описывает, какую часть интерфейса должен отображать этот виджет
  @override
  Widget build(BuildContext context) {
    // MaterialApp - основа приложения, которая задает стиль и навигацию
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Scenario Maker App', // Название приложения

        // home определяет стартовый экран приложения
        home: StreamBuilder<User?>(
            // StreamBuilder - виджет, который "слушает" поток данных
            // Поток изменений состояния аутентификации из нашего сервиса Auth
            stream: Auth().getAuthStateChange,

            // builder вызывается каждый раз, когда в потоке появляются новые данные
            builder: (context, snapshot) {
              // snapshot содержит данные из потока и информацию о их состоянии

              // Если в snapshot есть данные (пользователь не null) - пользователь авторизован
              if (snapshot.hasData) {
                // Показываем главный экран приложения
                return HomeScreen();
              } else {
                // Если данных нет или пользователь null - показываем экран входа
                return LoginScreen();
              }
            }),
      ),
    );
  }
}
