import 'package:flutter/material.dart';

class ScenarioGenerationScreen extends StatelessWidget {
  const ScenarioGenerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        //ctrl . wrapp with center
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: SizedBox(
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
