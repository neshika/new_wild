import 'package:new_wild/models/scenario_request_model.dart';

class ScenarioResultModel {
  final String id;
  final String title;
  final String body;
  final ScenarioRequestModel request;

  ScenarioResultModel({
    required this.id,
    required this.title,
    required this.body,
    required this.request,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'request': request.toJson(),
    };
  }

  static ScenarioResultModel fromJson(Map<String, dynamic> json) {
    return ScenarioResultModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      request: ScenarioRequestModel.fromJson(json['request']),
    );
  }
}
