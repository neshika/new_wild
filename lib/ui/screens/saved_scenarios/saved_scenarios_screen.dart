import 'package:flutter/material.dart';
import 'package:new_wild/models/scenario_result_model.dart';
import 'package:new_wild/services/auth.dart';
import 'package:new_wild/services/firebase_storage.dart';
import 'package:new_wild/ui/screens/saved_scenarios/components/scenario_item.dart';
import 'package:share_plus/share_plus.dart';

class SavedScenariosScreen extends StatefulWidget {
  const SavedScenariosScreen({
    super.key,
  });

  @override
  State<SavedScenariosScreen> createState() => _SavedScenariosScreenState();
}

class _SavedScenariosScreenState extends State<SavedScenariosScreen>
    with AutomaticKeepAliveClientMixin<SavedScenariosScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Scenarios'),
        actions: [
          IconButton(
            onPressed: () {
              Auth().signOut();
            },
            icon: Icon(Icons.logout), // кнопка справа
          ),
        ],
      ),
      //получаем поток данных
      body: StreamBuilder<List<ScenarioResultModel>>(
        stream: FirebaseStorage().getScenariosStream(),
        //получаем список карточек
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Has error ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            //получаем сценарии
            final scenarios = snapshot.data!;
            if (scenarios.isEmpty) {
              return Center(
                child: Text('Null saved scenarios. \n Generate new scenario'),
              );
            }
            return ListView.builder(
              itemCount: scenarios.length,
              itemBuilder: (context, index) {
                final scenario = scenarios[index];
                return ScenarioItem(
                  scenario: scenario,
                  //делаем функцию. которая отправляет удаление по индексу
                  onDelete: () => FirebaseStorage().deleteScenario(scenario.id),
                  onShare: () => Share.share(
                    scenario.body,
                    subject: 'Поделиться сценарием',
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
