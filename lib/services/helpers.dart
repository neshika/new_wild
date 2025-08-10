import 'dart:convert';

import 'package:new_wild/constants.dart';
import 'package:new_wild/models/scenario_request_model.dart';
import 'package:new_wild/models/scenario_result_model.dart';
import 'package:new_wild/services/dio_client.dart';

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email cannot be empty';
  }
  int atIndex = email.indexOf('@');
  if (atIndex == -1 || atIndex == 0 || atIndex == email.length - 1) {
    // нет собачки в строке, или в начале строки, или в конце
    return 'Please enter a valid adress email';
  }

  return null;
}

enum SocialPlatform { youtube, vk }

Future<ScenarioResultModel> getScenario({
  required SocialPlatform socialPlatform,
  required String videoTheme,
  required String targetAudience,
  required String videoLength,
  required String contentStyle,
  required String callToAction,
  required DioClient client,
}) async {
  final scenarioPrompt = kScenarioPrompt
      .replaceAll('{patform}', socialPlatform.name)
      .replaceAll('{videoTheme}', videoTheme)
      .replaceAll('{targetAudience}', targetAudience)
      .replaceAll('{videoLength}', videoLength)
      .replaceAll('{contentStyle}', contentStyle)
      .replaceAll('{callToAction}', callToAction);

  String result = await client.getScenario(scenarioPrompt);
  result = result.substring(7, result.length - 3); //убираем лишние символы

  final jsonResult = json.decode(result);
  //id,чтобы быть уникальным будет дете и время с начала времен
  jsonResult['id'] = DateTime.now().microsecondsSinceEpoch.toString();
  jsonResult['request'] = ScenarioRequestModel(
    platform: socialPlatform,
    videoTheme: videoTheme,
    targetAudience: targetAudience,
    videoLengthInSecond: int.parse(videoLength),
    contentStyle: contentStyle,
    callToAction: callToAction,
  ).toJson();
  return ScenarioResultModel.fromJson(jsonResult); // возвращает результат
}
