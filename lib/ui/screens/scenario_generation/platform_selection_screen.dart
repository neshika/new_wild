import 'package:flutter/material.dart';
import 'package:new_wild/services/helpers.dart';
import 'package:new_wild/ui/screens/scenario_generation/components/generate_scenario_tile.dart';
import 'package:new_wild/ui/screens/scenario_generation/scenario_generation_screen.dart';

class PlatformSelectionScreen extends StatelessWidget {
  const PlatformSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose platform'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            GenerateScenarioTile(
              backgroundColor: Colors.blue,
              iconBackgroundColor: Colors.blue[400],
              assetPath: 'assets/icons/icons8-youtube.svg',
              title: 'YouTube',
              description: 'Generated a scenario for YouTube shorts.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScenarioGenerationScreen(
                      socialPlatform: SocialPlatform.youtube),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GenerateScenarioTile(
              backgroundColor: Colors.green,
              iconBackgroundColor: Colors.green[400],
              assetPath: 'assets/icons/icons8-vk.svg',
              title: 'VK',
              description: 'Generated a scenario for VK clips.',
            ),
          ],
        ),
      ),
    );
  }
}
