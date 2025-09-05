import 'package:flutter/material.dart';
import 'package:new_wild/ui/screens/scenario_generation/components/scenario_description_textfield.dart';

class ScenarionDescriptionForm extends StatelessWidget {
  const ScenarionDescriptionForm({
    super.key,
    required this.formKey,
    required this.videoThemeController,
    required this.targetAudienceController,
    required this.videolengthController,
    required this.contentStyleThemeController,
    required this.callToActionController,
  });

  // Ключ для управления состоянием формы
  final GlobalKey<FormState> formKey;
  // Контроллеры для всех текстовых полей формы
  final videoThemeController;
  final targetAudienceController;
  final videolengthController;
  final contentStyleThemeController;
  final callToActionController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey, // Связываем форму с ключом
        child: Column(
          children: [
            // Поле ввода темы видео
            ScenarioDescriptionTextfield(
              title: 'Тема Видео',
              hint: 'Тема Видео',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ведите тему для видео.';
                }
                return null;
              },
              controller: videoThemeController,
            ),
            const SizedBox(height: 16.0),

            // Поле ввода целевой аудитории
            ScenarioDescriptionTextfield(
              title: 'Аудитория',
              hint: 'Аудитория',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите для кого это видео';
                }
                return null;
              },
              controller: targetAudienceController,
            ),
            const SizedBox(height: 16.0),

            // Поле ввода длины видео в секундах
            ScenarioDescriptionTextfield(
              title: 'Длина видео в секундах (15,30,60)',
              hint: 'Длина видео',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите длину видео.';
                }
                if (int.tryParse(value) == null) {
                  return 'Длина должны быть в цифрах.';
                }
                return null;
              },
              controller: videolengthController,
            ),
            const SizedBox(height: 16.0),

            // Поле ввода стиля контента
            ScenarioDescriptionTextfield(
              title: 'Стиль контента',
              hint: 'Стиль контента',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите стиль контента.';
                }
                return null;
              },
              controller: contentStyleThemeController,
            ),
            const SizedBox(height: 16.0),

            // Поле ввода призыва к действию
            ScenarioDescriptionTextfield(
              title: 'Действия: подписаться, комментировать',
              hint: 'Какие действия',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите действия.';
                }
                return null;
              },
              controller: callToActionController,
            ),
            // const SizedBox(height: 24.0),

            // Кнопка отправки формы
            // ElevatedButton(
            //
            //     }
            //   },
            //   // Стиль кнопки
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsetsDirectional.all(10.0),
            //   ),
            //   // Отображаем либо индикатор загрузки, либо текст
            //   child: isLoading
            //       ? const Center(
            //           child: CircularProgressIndicator(),
            //         )
            //       : const Text(
            //           'Submit',
            //           style: TextStyle(fontSize: 18.0),
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
