// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPreferences _$NotificationPreferencesFromJson(
        Map<String, dynamic> json) =>
    NotificationPreferences(
      notifyWhenChildCompletesTask:
          json['notifyWhenChildCompletesTask'] as bool? ?? true,
      notifyWhenChildComesOnline:
          json['notifyWhenChildComesOnline'] as bool? ?? false,
      notifyWhenChildGoesOffline:
          json['notifyWhenChildGoesOffline'] as bool? ?? false,
    );

Map<String, dynamic> _$NotificationPreferencesToJson(
        NotificationPreferences instance) =>
    <String, dynamic>{
      'notifyWhenChildCompletesTask': instance.notifyWhenChildCompletesTask,
      'notifyWhenChildComesOnline': instance.notifyWhenChildComesOnline,
      'notifyWhenChildGoesOffline': instance.notifyWhenChildGoesOffline,
    };
