import 'package:flutter/material.dart';
import 'package:new_wild/models/scenario_result_model.dart';
import 'package:new_wild/services/auth.dart';
import 'package:new_wild/services/scenario_storage.dart';
import 'package:new_wild/ui/screens/saved_scenarios/components/scenario_item.dart';

class SavedScenariosScreen extends StatelessWidget {
  const SavedScenariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
            future: _loadScenario(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                      'Error loadingSnapshot ${snapshot.error.toString()}'),
                );
              } else if (snapshot.hasData && snapshot.data == null) {
                return Center(
                  child: Text('No saved scenario available'),
                );
              } else {
                return Center(
                  child: ScenarioItem(scenario: snapshot.data!),
                );
              }
            }));
  }

  Future<ScenarioResultModel?> _loadScenario() async {
    final scenarioStorage = ScenarioStorage();

    return await scenarioStorage.loadScenario();
  }
}
