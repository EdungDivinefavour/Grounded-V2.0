// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      parentID: json['parentID'] as String,
      loginToken: json['loginToken'] as String,
      age: json['age'] as int,
      grade: json['grade'] as int,
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList(),
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.child,
      registrationTime: json['registrationTime'] as int? ?? 0,
      lastSeenAt: json['lastSeenAt'] as int? ?? 0,
      firebaseToken: json['firebaseToken'] as String? ?? '',
      onlinePresence: $enumDecodeNullable(
              _$OnlinePresenceEnumMap, json['onlinePresence']) ??
          OnlinePresence.offline,
      profilePhoto: json['profilePhoto'] as String? ??
          "https://firebasestorage.googleapis.com/v0/b/sonocare-15c7d.appspot.com/o/user_icon.png?alt=media&token=3de311b3-2b09-4573-949d-3887711f1368",
    );

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userType': _$UserTypeEnumMap[instance.userType],
      'onlinePresence': _$OnlinePresenceEnumMap[instance.onlinePresence],
      'registrationTime': instance.registrationTime,
      'lastSeenAt': instance.lastSeenAt,
      'firebaseToken': instance.firebaseToken,
      'profilePhoto': instance.profilePhoto,
      'email': instance.email,
      'password': instance.password,
      'parentID': instance.parentID,
      'loginToken': instance.loginToken,
      'age': instance.age,
      'grade': instance.grade,
      'achievements': instance.achievements.map((e) => e.toJson()).toList(),
    };

const _$UserTypeEnumMap = {
  UserType.parent: 'parent',
  UserType.child: 'child',
};

const _$OnlinePresenceEnumMap = {
  OnlinePresence.online: 'online',
  OnlinePresence.away: 'away',
  OnlinePresence.offline: 'offline',
};
