// нужен статус нашего приложения
enum LoadingStatus { defaultStatus, generating, success, failure }

class ScenarioState {
  final LoadingStatus loadingStatus;

  //создаем конструктор
  ScenarioState({
    this.loadingStatus = LoadingStatus.defaultStatus,
  });

  // создаем метод
  ScenarioState copyWith({LoadingStatus? loadingStatus}) {
    return ScenarioState(
      loadingStatus: loadingStatus ??
          this.loadingStatus, //если в лоадстатус что-то пришло, это и передаем
    );
  }
}
