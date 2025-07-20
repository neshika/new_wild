import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  //ctrl .
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(20.0),
              topEnd: Radius.circular(20.0),
            ),
            boxShadow: [BoxShadow(color: Colors.grey)]),
      ),
    );
  }
}
