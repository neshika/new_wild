import 'package:new_wild/redux/actions.dart';
import 'package:new_wild/redux/state.dart';

ScenarioState scenarioReducer(ScenarioState state, dynamic action) {
  if (action is LoadScenatioAction) {
    //возвращаем генератион
    return state.copyWith(loadingStatus: LoadingStatus.generating);
  } else if (action is LoadScenatioSuccessAction) {
    //возвращаем успех
    return state.copyWith(loadingStatus: LoadingStatus.success);
  } else if (action is LoadScenatioFailureAction) {
    //возвращем неудачу
    return state.copyWith(loadingStatus: LoadingStatus.failure);
  }

  return state; // если не смоги определить что пришло
}
