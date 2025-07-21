import 'package:flutter/material.dart';
import 'package:new_wild/services/helpers.dart';
import 'package:new_wild/ui/screens/scenario_generation/components/scenario_description_textfield.dart';

class ScenarioGenerationScreen extends StatefulWidget {
  const ScenarioGenerationScreen({
    super.key,
    required this.socialPlatform,
  });

  final SocialPlatform socialPlatform;

  @override
  State<ScenarioGenerationScreen> createState() =>
      _ScenarioGenerationScreenState();
}

class _ScenarioGenerationScreenState extends State<ScenarioGenerationScreen> {
  final videoThemeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate new video scenario')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ScenarioDescriptionTextfield(
                title: 'Enter the theme of the video',
                hint: 'Enter the theme of the video',
                controller: videoThemeController),
          ],
        ),
      ),
    );
  }
}
