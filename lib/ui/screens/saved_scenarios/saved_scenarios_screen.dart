// Импортируем необходимые библиотеки Flutter
import 'package:flutter/material.dart';
// Импортируем модель данных сценария
import 'package:new_wild/models/scenario_result_model.dart';
// Импортируем сервис аутентификации
import 'package:new_wild/services/auth.dart';
// Импортируем сервис работы с Firebase Firestore
import 'package:new_wild/services/firebase_storage.dart';
// Импортируем виджет элемента списка сценариев
import 'package:new_wild/ui/screens/saved_scenarios/components/scenario_item.dart';
// Импортируем виджет-заглушку для пустых состояний
import 'package:new_wild/ui/screens/saved_scenarios/components/stub.dart';
// Импортируем пакет для функционала "поделиться"
import 'package:share_plus/share_plus.dart';

// Экран сохраненных сценариев
class SavedScenariosScreen extends StatefulWidget {
  const SavedScenariosScreen({
    super.key,
  });

  @override
  State<SavedScenariosScreen> createState() => _SavedScenariosScreenState();
}

class _SavedScenariosScreenState extends State<SavedScenariosScreen>
    with AutomaticKeepAliveClientMixin<SavedScenariosScreen> {
  // Переопределяем метод для сохранения состояния экрана
  // Когда пользователь переключает вкладки, этот экран не будет пересоздаваться
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super
        .build(context); // Обязательный вызов для AutomaticKeepAliveClientMixin
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Scenarios'), // Заголовок экрана
        actions: [
          // Кнопка выхода в правом верхнем углу
          IconButton(
            onPressed: () {
              Auth().signOut(); // Вызываем выход из системы
            },
            icon: Icon(Icons.logout), // Иконка выхода
          ),
        ],
      ),
      // Используем StreamBuilder для работы с потоком данных из Firestore
      body: StreamBuilder<List<ScenarioResultModel>>(
        // Получаем поток сценариев из Firebase
        stream: FirebaseStorage().getScenariosStream(),
        // builder вызывается каждый раз, когда в потоке появляются новые данные
        builder: (context, snapshot) {
          // Состояние загрузки - показываем индикатор прогресса
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Обработка ошибок - показываем заглушку с ошибкой
          else if (snapshot.hasError) {
            return Stub(
              text: 'Has error ${snapshot.error}',
              icon: Icons.warning,
              iconColor: Colors.red[800],
            );
          }
          // Если есть данные и они не null
          else if (snapshot.hasData && snapshot.data != null) {
            // Получаем список сценариев
            final scenarios = snapshot.data!;
            // Если список пустой - показываем заглушку
            if (scenarios.isEmpty) {
              return Stub(
                text: 'No saved scenarios. \n Generate new scenario',
                icon: Icons.dangerous,
                iconColor: Colors.yellow[800],
              );
            }
            // Если есть сценарии - показываем список
            return ListView.builder(
              itemCount: scenarios.length, // Количество элементов
              itemBuilder: (context, index) {
                final scenario = scenarios[index];
                // Создаем элемент списка для каждого сценария
                return ScenarioItem(
                  scenario: scenario, // Передаем данные сценария
                  // Функция удаления - вызывается при нажатии на кнопку удаления
                  onDelete: () => FirebaseStorage().deleteScenario(scenario.id),
                  // Функция поделиться - использует share_plus для отправки
                  onShare: () => Share.share(
                    scenario.body, // Текст сценария для отправки
                    subject: 'Поделиться сценарием', // Тема сообщения
                  ),
                );
              },
            );
          }
          // Если данных нет (null) - показываем заглушку
          else {
            return Stub(
              text: 'No data available',
              icon: Icons.dangerous,
              iconColor: Colors.red[800],
            );
          }
        },
      ),
    );
  }
}
