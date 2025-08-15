import 'package:flutter/material.dart';
import 'package:new_wild/ui/screens/scenario_generation/components/scenario_description_textfield.dart';

class ScenarioDescriptionForm extends StatelessWidget {
  const ScenarioDescriptionForm({
    super.key,
    required this.formKey,
    required this.videoThemeController,
    required this.targetAudienceController,
    required this.videolengthController,
    required this.contentStyleThemeController,
    required this.callToActionController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController videoThemeController;
  final TextEditingController targetAudienceController;
  final TextEditingController videolengthController;
  final TextEditingController contentStyleThemeController;
  final TextEditingController callToActionController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            SizedBox(height: 16.0),
            // аудитория
            ScenarioDescriptionTextfield(
              title: 'Enter the target audiens',
              hint: 'target audience',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the target audience.';
                }
                return null;
              },
              controller: targetAudienceController,
            ),
            SizedBox(height: 16.0),
            //длина видео
            ScenarioDescriptionTextfield(
              title: 'Enter the length of the video in seconds(15,30,60)',
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
            SizedBox(height: 16.0),
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
            SizedBox(height: 16.0),
            // предлагаем действия: подписаться, комментировать
            ScenarioDescriptionTextfield(
              title: 'Enter a call action',
              hint: 'call to action',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a call to action.';
                }
                return null;
              },
              controller: callToActionController,
            ),
          ],
        ),
      ),
    );
  }
}
