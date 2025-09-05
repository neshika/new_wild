// Импортируем необходимые библиотеки Flutter
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_wild/redux/actions.dart';
import 'package:new_wild/redux/state.dart';
// Импортируем клиент для работы с OpenAI API
import 'package:new_wild/services/dio_client.dart';
// Импортируем сервис для работы с Firebase Firestore
import 'package:new_wild/services/firebase_storage.dart';
// Импортируем вспомогательные функции и enum SocialPlatform
import 'package:new_wild/services/helpers.dart';
import 'package:new_wild/ui/screens/saved_scenarios/components/stub.dart';
import 'package:new_wild/ui/screens/scenario_generation/scenarion_description_form.dart';
// Импортируем кастомное текстовое поле
import 'package:redux/redux.dart';

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

  void loadScenario(Store store) async {
    if (formKey.currentState!.validate()) {
      // Генерируем сценарий через API
      try {
        store.dispatch(LoadScenarioAction());
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

        //если все удачно, то возвращаем что все удачно
        store.dispatch(LoadScenarioSuccessAction());
      } on Exception catch (error) {
        store.dispatch(LoadScenarioFailureAction(error.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<ScenarioState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Generate new video scenario')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          // Обертываем в SingleChildScrollView для возможности скролла
          child: StoreConnector<ScenarioState, ScenarioState>(
            converter: (store) => store.state,
            builder: (context, state) {
              if (state.loadingStatus == LoadingStatus.defaultStatus ||
                  state.loadingStatus == LoadingStatus.success) {
                return Column(
                  children: [
                    //занимает все возможное пространство
                    Expanded(
                      child: ScenarionDescriptionForm(
                          formKey: formKey,
                          videoThemeController: videoThemeController,
                          targetAudienceController: targetAudienceController,
                          videolengthController: videolengthController,
                          contentStyleThemeController:
                              contentStyleThemeController,
                          callToActionController: callToActionController),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () => loadScenario(store),
                      // Стиль кнопки
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsetsDirectional.all(10.0),
                      ),
                      // Отображаем либо индикатор загрузки, либо текст
                      child: const Text(
                        'Создать',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                );
              }
              if (state.loadingStatus == LoadingStatus.failure) {
                return Center(
                  child: Stub(
                      text: 'Ошибка! \nПопробуйте позже',
                      icon: Icons.warning,
                      iconColor: Colors.red[800]),
                );
              }
              return Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            }, //builder
          ),
        ),
      ),
    );
  }
}
