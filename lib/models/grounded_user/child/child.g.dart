// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      name: json['name'] as String,
      parentID: json['parentID'] as String,
      loginToken: json['loginToken'] as String,
    )..profilePhoto = json['profilePhoto'] as String;

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'profilePhoto': instance.profilePhoto,
      'name': instance.name,
      'parentID': instance.parentID,
      'loginToken': instance.loginToken,
    };
