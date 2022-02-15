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
      notificationPreferences: NotificationPreferences.fromJson(
          json['notificationPreferences'] as Map<String, dynamic>),
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.parent,
      onlinePresence: $enumDecodeNullable(
              _$OnlinePresenceEnumMap, json['onlinePresence']) ??
          OnlinePresence.offline,
      registrationTime: json['registrationTime'] as int? ?? 0,
      lastSeenAt: json['lastSeenAt'] as int? ?? 0,
      firebaseToken: json['firebaseToken'] as String? ?? '',
      profilePhoto: json['profilePhoto'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/sonocare-15c7d.appspot.com/o/user_icon.png?alt=media&token=3de311b3-2b09-4573-949d-3887711f1368',
      wantsNewsletters: json['wantsNewsletters'] as bool? ?? false,
    );

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
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
      'notificationPreferences': instance.notificationPreferences.toJson(),
      'wantsNewsletters': instance.wantsNewsletters,
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
