import 'package:flutter/material.dart';
import 'package:new_wild/ui/screens/scenario_generation/components/generate_scenario_tile.dart';

class ScenarioGenerationScreen extends StatelessWidget {
  const ScenarioGenerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GenerateScenarioTile(
        backgroundColor: Colors.blue,
        iconBackgroundColor: Colors.blue[400],
        assetPath: 'assets/icons/icons8-youtube.svg',
        title: 'YouTube',
        description: 'Generated a scenario for YouTube shorts.',
      ),
    );
  }
}
