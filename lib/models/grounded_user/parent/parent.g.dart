// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parent _$ParentFromJson(Map<String, dynamic> json) => Parent(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      children: (json['children'] as List<dynamic>)
          .map((e) => Child.fromJson(e as Map<String, dynamic>))
          .toList(),
      childrenLoginTokens: (json['childrenLoginTokens'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      notificationPreferences: NotificationPreferences.fromJson(
          json['notificationPreferences'] as Map<String, dynamic>),
      wantsNewsletters: json['wantsNewsletters'] as bool? ?? false,
    )..profilePhoto = json['profilePhoto'] as String;

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'profilePhoto': instance.profilePhoto,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'children': instance.children.map((e) => e.toJson()).toList(),
      'childrenLoginTokens': instance.childrenLoginTokens,
      'notificationPreferences': instance.notificationPreferences.toJson(),
      'wantsNewsletters': instance.wantsNewsletters,
    };
