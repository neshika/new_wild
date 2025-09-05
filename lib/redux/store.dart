import 'package:redux/redux.dart';
import 'package:new_wild/redux/state.dart';
import 'package:new_wild/redux/reducers.dart';

final store = Store<ScenarioState>(
  scenarioReducer,
  initialState: ScenarioState(),
);
