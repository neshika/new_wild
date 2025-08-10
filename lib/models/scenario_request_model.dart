import 'package:new_wild/services/helpers.dart';

class ScenarioRequestModel {
  final SocialPlatform platform;
  final String videoTheme;
  final String targetAudience;
  final int videoLengthInSecond;
  final String contentStyle;
  final String callToAction;

  ScenarioRequestModel({
    required this.platform,
    required this.videoTheme,
    required this.targetAudience,
    required this.videoLengthInSecond,
    required this.contentStyle,
    required this.callToAction,
  });

  Map<String, dynamic> toJson() {
    return {
      'platform': platform.toString(),
      'videoTheme': videoTheme,
      'targetAudience': targetAudience,
      'videoLengthInSecond': videoLengthInSecond,
      'contentStyle': contentStyle,
      'callToAction': callToAction,
    };
  }

  static ScenarioRequestModel fromJson(Map<String, dynamic> json) {
    return ScenarioRequestModel(
      platform: SocialPlatform.values
          .firstWhere((element) => element.toString() == json['platform']),
      videoTheme: json['videoTheme'],
      targetAudience: json['targetAudience'],
      videoLengthInSecond: json['videoLengthInSecond'],
      contentStyle: json['contentStyle'],
      callToAction: json['callToAction'],
    );
  }
}
