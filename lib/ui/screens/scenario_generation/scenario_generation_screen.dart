import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_wild/redux/actions.dart';
import 'package:new_wild/redux/state.dart';
import 'package:new_wild/services/dio_client.dart';
import 'package:new_wild/services/firebase_storage.dart';
import 'package:new_wild/services/helpers.dart';
import 'package:new_wild/ui/screens/saved_scenarios/components/stub.dart';
import 'package:new_wild/ui/screens/scenario_generation/scenario_description_form.dart';
import 'package:redux/redux.dart';

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

  void loadScenario(Store store) async {
    //загружает сценарий
    if (formKey.currentState!.validate()) {
      try {
        store.dispatch(LoadScenatioAction()); //загружаем сценарий
        final res = await getScenario(
            socialPlatform: widget.socialPlatform,
            videoTheme: videoThemeController.text,
            targetAudience: targetAudienceController.text,
            videoLength: videolengthController.text,
            contentStyle: contentStyleThemeController.text,
            callToAction: callToActionController.text,
            client: client);
        // await ScenarioStorage().saveScenario(res); //сохраняем результат
        //обращаемся к ФБ сторадж
        await FirebaseStorage().saveScenario(res);
        store.dispatch(LoadScenatioSuccessAction()); //удачная загрузка
      } catch (error) {
        store.dispatch(LoadScenatioFailureAction(error.toString()));
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
          child: StoreConnector<ScenarioState, ScenarioState>(
            converter: (store) => store.state,
            builder: (context, state) {
              if (state.loadingStatus == LoadingStatus.defaultStatus ||
                  state.loadingStatus == LoadingStatus.success) {
                return Column(
                  children: [
                    Expanded(
                      child: ScenarioDescriptionForm(
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
                      //кнопка внизу
                      onPressed: () => loadScenario(store),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    )
                  ],
                );
              }
              if (state.loadingStatus == LoadingStatus.failure) {
                return Center(
                  child: Stub(
                    text: 'An error occured! \n Try again later',
                    icon: Icons.warning,
                    iconColor: Colors.red[800],
                  ),
                );
              }
              return Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
