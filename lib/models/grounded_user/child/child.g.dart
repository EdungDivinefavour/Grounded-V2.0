// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      name: json['name'] as String,
      parentID: json['parentID'] as String,
      loginToken: json['loginToken'] as String,
      age: json['age'] as int,
      grade: json['grade'] as int,
    )..profilePhoto = json['profilePhoto'] as String;

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'profilePhoto': instance.profilePhoto,
      'parentID': instance.parentID,
      'loginToken': instance.loginToken,
      'name': instance.name,
      'age': instance.age,
      'grade': instance.grade,
    };
