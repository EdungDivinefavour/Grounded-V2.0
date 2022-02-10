// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      id: json['id'] as String,
      name: json['name'] as String,
      parentID: json['parentID'] as String,
      loginToken: json['loginToken'] as String,
      age: json['age'] as int,
      grade: json['grade'] as int,
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..profilePhoto = json['profilePhoto'] as String;

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'profilePhoto': instance.profilePhoto,
      'id': instance.id,
      'name': instance.name,
      'parentID': instance.parentID,
      'loginToken': instance.loginToken,
      'age': instance.age,
      'grade': instance.grade,
      'achievements': instance.achievements.map((e) => e.toJson()).toList(),
    };
