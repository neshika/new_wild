import 'package:flutter/material.dart';

class SavedScenariosScreen extends StatelessWidget {
  const SavedScenariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        //ctrl . wrapp with center
        decoration: BoxDecoration(
          color: Colors.amber,
        ),
        child: SizedBox(
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
