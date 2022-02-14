import 'package:json_annotation/json_annotation.dart';

part 'notification_preferences.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationPreferences {
  bool notifyWhenChildCompletesTask;
  bool notifyWhenChildComesOnline;
  bool notifyWhenChildGoesOffline;

  NotificationPreferences({
    this.notifyWhenChildCompletesTask = true,
    this.notifyWhenChildComesOnline = false,
    this.notifyWhenChildGoesOffline = false,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationPreferencesToJson(this);
}
