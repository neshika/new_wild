import 'package:flutter/material.dart';
import 'package:new_wild/services/dio_client.dart';
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
  final targetAudienceController = TextEditingController();
  final videolengthController = TextEditingController();
  final contentStyleThemeController = TextEditingController();
  final callToActionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final client = DioClient.instance;

  @override
  void dispose() {
    //удаление контроллеров, для очистки памяти

    super.dispose();
    videoThemeController.dispose();
    targetAudienceController.dispose();
    videolengthController.dispose();
    contentStyleThemeController.dispose();
    callToActionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate new video scenario')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // оборачиваем колонку, чтобы можно было скроллить
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // тема видео
                ScenarioDescriptionTextfield(
                  title: 'Enter the theme of the video',
                  hint: 'Video theme',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a video theme.';
                    }
                    return null;
                  },
                  controller: videoThemeController,
                ),
                const SizedBox(height: 16.0),
                // аудитория
                ScenarioDescriptionTextfield(
                  title: 'Enter the target audiens',
                  hint: 'target audiens',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the target audiens.';
                    }
                    return null;
                  },
                  controller: targetAudienceController,
                ),
                const SizedBox(height: 16.0),
                //длина видео
                ScenarioDescriptionTextfield(
                  title: 'Enter the length of the video in second(15,30,60)',
                  hint: 'length of the video',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the length of the video.';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    }
                    return null;
                  },
                  controller: videolengthController,
                ),
                const SizedBox(height: 16.0),
                // стиль контента
                ScenarioDescriptionTextfield(
                  title: 'Enter the style of content',
                  hint: 'style content',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the style content.';
                    }
                    return null;
                  },
                  controller: contentStyleThemeController,
                ),
                const SizedBox(height: 16.0),
                // предлагаем действия: подписаться, комментировать
                ScenarioDescriptionTextfield(
                  title: 'Enter a call action',
                  hint: 'call ti action',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a call to action.';
                    }
                    return null;
                  },
                  controller: callToActionController,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final res = await getScenario(
                          socialPlatform: widget.socialPlatform,
                          videoTheme: videoThemeController.text,
                          targetAudience: targetAudienceController.text,
                          videoLength: videolengthController.text,
                          contentStyle: contentStyleThemeController.text,
                          callToAction: callToActionController.text,
                          client: client);

                      print(res.body);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    //padding: EdgeInsetsDirectional.symmetric(vertical: 12.0),
                    padding: EdgeInsetsDirectional.all(10.0),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
