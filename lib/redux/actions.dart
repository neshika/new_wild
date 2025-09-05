class LoadScenarioAction {}

class LoadScenarioSuccessAction {}

class LoadScenarioFailureAction {
  final String error;
  //constructor
  LoadScenarioFailureAction(this.error);
}
