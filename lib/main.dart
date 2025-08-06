import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_wild/ui/home_screen.dart';
//import 'package:new_wild/ui/screens/authorization/login_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //для инициализации всех пакетов Flutter
  await Firebase.initializeApp();
  //запуск
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Scenario Maker App ',
      //  home: LoginScreen(),
      home: HomeScreen(),
    );
  }
}
