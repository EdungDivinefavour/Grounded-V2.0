// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grounded_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroundedNotification _$GroundedNotificationFromJson(
        Map<String, dynamic> json) =>
    GroundedNotification(
      title: json['title'] as String,
      body: json['body'] as String,
      creationTimeStamp: json['creationTimeStamp'] as int,
    );

Map<String, dynamic> _$GroundedNotificationToJson(
        GroundedNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'creationTimeStamp': instance.creationTimeStamp,
    };
