import 'package:new_wild/redux/reducers.dart';
import 'package:new_wild/redux/state.dart';
import 'package:redux/redux.dart';

final store = Store<ScenarioState>(
  scenarioReducer,
  initialState: ScenarioState(),
);
