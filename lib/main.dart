import 'package:flutter/material.dart';
import 'package:new_wild/ui/home_screen.dart';
//import 'package:new_wild/ui/screens/authorization/login_screen.dart';

void main() {
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
