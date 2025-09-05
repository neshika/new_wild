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
    return 'Please enter a valid email address';
  }
  return null;
}

enum SocialPlatform { youtube, vk }

/// Fetches a generated video scenario from the backend.
///
/// Throws [FormatException] if videoLength is not a valid integer.
/// Throws [Exception] if API call fails.
Future<ScenarioResultModel> getScenario({
  required SocialPlatform socialPlatform,
  required String videoTheme,
  required String targetAudience,
  required String videoLength,
  required String contentStyle,
  required String callToAction,
  required DioClient client,
}) async {
  // 1. Validate and parse video length
  final int? lengthInSec = int.tryParse(videoLength.trim());
  if (lengthInSec == null) {
    throw FormatException(
        'Invalid video length: $videoLength. Must be a number.');
  }

  // 2. Build the prompt by replacing placeholders
  final scenarioPrompt = kScenarioPrompt
      .replaceAll('{platform}', socialPlatform.name)
      .replaceAll('{videoTheme}', videoTheme)
      .replaceAll('{targetAudience}', targetAudience)
      .replaceAll('{videoLength}', lengthInSec.toString())
      .replaceAll('{contentStyle}', contentStyle)
      .replaceAll('{callToAction}', callToAction);

  // 3. Call API
  String result = await client.getScenario(scenarioPrompt);

  // 4. Clean response (remove markdown or extra symbols like ```json ... ```)
  // Убираем возможные обёртки вроде ```json{...}```
  result = result.trim();
  if (result.startsWith('```json')) {
    result = result.substring(7);
  }
  if (result.endsWith('```')) {
    result = result.substring(0, result.length - 3);
  }

  // 5. Decode JSON
  final Map<String, dynamic> jsonResult = json.decode(result);

  // 6. Add metadata: ID and original request
  jsonResult['id'] = DateTime.now().microsecondsSinceEpoch.toString();
  jsonResult['request'] = ScenarioRequestModel(
    platform: socialPlatform,
    videoTheme: videoTheme,
    targetAudience: targetAudience,
    videoLengthInSecond: lengthInSec,
    contentStyle: contentStyle,
    callToAction: callToAction,
  ).toJson();

  // 7. Return parsed model
  return ScenarioResultModel.fromJson(jsonResult);
}
