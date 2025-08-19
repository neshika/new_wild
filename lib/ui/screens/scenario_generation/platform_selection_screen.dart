// Импортируем необходимые библиотеки Flutter
import 'package:flutter/material.dart';
// Импортируем вспомогательные функции, включая enum SocialPlatform
import 'package:new_wild/services/helpers.dart';
// Импортируем кастомный виджет плитки выбора платформы
import 'package:new_wild/ui/screens/scenario_generation/components/generate_scenario_tile.dart';
// Импортируем экран генерации сценария
import 'package:new_wild/ui/screens/scenario_generation/scenario_generation_screen.dart';

// Экран выбора платформы для генерации сценария
class PlatformSelectionScreen extends StatelessWidget {
  const PlatformSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose platform'), // Заголовок экрана
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Отступы от краев экрана
        child: Column(
          children: [
            // Плитка для выбора YouTube
            GenerateScenarioTile(
              backgroundColor: Colors.blue, // Основной цвет фона плитки
              iconBackgroundColor: Colors.blue[400], // Цвет фона иконки
              assetPath:
                  'assets/icons/icons8-youtube.svg', // Путь к иконке YouTube
              title: 'YouTube', // Название платформы
              description:
                  'Generate a scenario for YouTube shorts.', // Описание
              onTap: () => Navigator.push(
                // Обработчик нажатия
                context,
                MaterialPageRoute(
                  builder: (context) => ScenarioGenerationScreen(
                      socialPlatform: SocialPlatform
                          .youtube), // Передаем выбранную платформу
                ),
              ),
            ),
            SizedBox(
              height: 20.0, // Отступ между плитками
            ),
            // Плитка для выбора VK
            GenerateScenarioTile(
              backgroundColor: Colors.green, // Основной цвет фона плитки
              iconBackgroundColor: Colors.green[400], // Цвет фона иконки
              assetPath: 'assets/icons/icons8-vk.svg', // Путь к иконке VK
              title: 'VK', // Название платформы
              description: 'Generate a scenario for VK clips.', // Описание
              onTap: () => Navigator.push(
                // Обработчик нажатия
                context,
                MaterialPageRoute(
                  builder: (context) => ScenarioGenerationScreen(
                      socialPlatform:
                          SocialPlatform.vk), // Передаем выбранную платформу
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
