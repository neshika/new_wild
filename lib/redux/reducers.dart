import 'package:new_wild/redux/actions.dart';
import 'package:new_wild/redux/state.dart';

// метод получает события и возвращает состояния в зависимости от них
ScenarioState scenarioReducer(ScenarioState state, dynamic action) {
  if (action is LoadScenarioAction) {
    return state.copyWith(loadingStatus: LoadingStatus.generating);
  } else if (action is LoadScenarioSuccessAction) {
    return state.copyWith(loadingStatus: LoadingStatus.success);
  } else if (action is LoadScenarioFailureAction) {
    return state.copyWith(loadingStatus: LoadingStatus.failure);
  }
  return state;
}
