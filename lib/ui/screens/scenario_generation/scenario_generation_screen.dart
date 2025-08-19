// Импортируем необходимые библиотеки Flutter
import 'package:flutter/material.dart';
// Импортируем клиент для работы с OpenAI API
import 'package:new_wild/services/dio_client.dart';
// Импортируем сервис для работы с Firebase Firestore
import 'package:new_wild/services/firebase_storage.dart';
// Импортируем вспомогательные функции и enum SocialPlatform
import 'package:new_wild/services/helpers.dart';
// Импортируем кастомное текстовое поле
import 'package:new_wild/ui/screens/scenario_generation/components/scenario_description_textfield.dart';

// Экран генерации нового сценария
class ScenarioGenerationScreen extends StatefulWidget {
  const ScenarioGenerationScreen({
    super.key,
    required this.socialPlatform, // Платформа, выбранная на предыдущем экране
  });

  final SocialPlatform socialPlatform;

  @override
  State<ScenarioGenerationScreen> createState() =>
      _ScenarioGenerationScreenState();
}

class _ScenarioGenerationScreenState extends State<ScenarioGenerationScreen> {
  // Контроллеры для всех текстовых полей формы
  final videoThemeController = TextEditingController();
  final targetAudienceController = TextEditingController();
  final videolengthController = TextEditingController();
  final contentStyleThemeController = TextEditingController();
  final callToActionController = TextEditingController();

  // Ключ для управления состоянием формы
  final formKey = GlobalKey<FormState>();

  // Экземпляр клиента для работы с API
  final client = DioClient.instance;

  // Флаг состояния загрузки
  bool isLoading = false;

  @override
  void dispose() {
    // Важно! Очищаем контроллеры при уничтожении виджета чтобы избежать утечек памяти
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
        // Обертываем в SingleChildScrollView для возможности скролла
        child: SingleChildScrollView(
          child: Form(
            key: formKey, // Связываем форму с ключом
            child: Column(
              children: [
                // Поле ввода темы видео
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

                // Поле ввода целевой аудитории
                ScenarioDescriptionTextfield(
                  title: 'Enter the target audience',
                  hint: 'Target audience',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the target audience.';
                    }
                    return null;
                  },
                  controller: targetAudienceController,
                ),
                const SizedBox(height: 16.0),

                // Поле ввода длины видео в секундах
                ScenarioDescriptionTextfield(
                  title: 'Enter the length of the video in seconds (15,30,60)',
                  hint: 'Length of the video',
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

                // Поле ввода стиля контента
                ScenarioDescriptionTextfield(
                  title: 'Enter the style of content',
                  hint: 'Style content',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the style content.';
                    }
                    return null;
                  },
                  controller: contentStyleThemeController,
                ),
                const SizedBox(height: 16.0),

                // Поле ввода призыва к действию
                ScenarioDescriptionTextfield(
                  title: 'Enter a call to action',
                  hint: 'Call to action',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a call to action.';
                    }
                    return null;
                  },
                  controller: callToActionController,
                ),
                const SizedBox(height: 24.0),

                // Кнопка отправки формы
                ElevatedButton(
                  onPressed: () async {
                    // Проверяем валидность всех полей формы
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true; // Показываем индикатор загрузки
                      });

                      // Генерируем сценарий через API
                      final res = await getScenario(
                          socialPlatform: widget.socialPlatform,
                          videoTheme: videoThemeController.text,
                          targetAudience: targetAudienceController.text,
                          videoLength: videolengthController.text,
                          contentStyle: contentStyleThemeController.text,
                          callToAction: callToActionController.text,
                          client: client);

                      // Сохраняем результат в Firebase
                      await FirebaseStorage().saveScenario(res);

                      setState(() {
                        isLoading = false; // Скрываем индикатор загрузки
                      });
                    }
                  },
                  // Стиль кнопки
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsetsDirectional.all(10.0),
                  ),
                  // Отображаем либо индикатор загрузки, либо текст
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
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
