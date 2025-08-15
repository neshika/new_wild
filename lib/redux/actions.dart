class LoadScenatioAction {}

class LoadScenatioSuccessAction {}

class LoadScenatioFailureAction {
  final String error;

  //создаем конструктор
  LoadScenatioFailureAction(this.error);
}
