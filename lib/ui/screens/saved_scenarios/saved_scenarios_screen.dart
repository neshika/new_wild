import 'package:flutter/material.dart';
import 'package:new_wild/services/auth.dart';
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
      body: Center(
        child: ScenarioItem(),
      ),
    );
  }
}
