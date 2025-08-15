enum LoadingStatus { defaultStatus, generating, success, failure }

class ScenarioState {
  final LoadingStatus loadingStatus;

  //создаем конструктор
  ScenarioState({
    this.loadingStatus = LoadingStatus.defaultStatus,
  });

  // при копировании экземпляра, копируем конкретные поля
  ScenarioState copyWith({LoadingStatus? loadingStatus}) {
    return ScenarioState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
