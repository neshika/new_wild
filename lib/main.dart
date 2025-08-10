// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:new_wild/services/auth.dart';
// import 'package:new_wild/ui/home_screen.dart';
// import 'package:new_wild/ui/screens/authorization/login_screen.dart';

// void main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); //для инициализации всех пакетов Flutter
//   await Firebase.initializeApp();
//   //запуск
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Scenario Maker App ',
//       home: StreamBuilder<User?>(
//           stream: Auth().getAuthStateChange,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return HomeScreen();
//             } else {
//               return LoginScreen();
//             }
//           }),
//     );
//   }
// }
import 'package:new_wild/services/dio_client.dart';

void main() async {
  final client = DioClient.instance;
  final response =
      await client.getScenario('Шутка про мобильного разработчика');
  print(response);
}
