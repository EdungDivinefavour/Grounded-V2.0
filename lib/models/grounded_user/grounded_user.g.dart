// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grounded_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroundedUser _$GroundedUserFromJson(Map<String, dynamic> json) => GroundedUser(
      name: json['name'] as String,
      id: json['id'] as String,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      registrationTime: json['registrationTime'] as int,
      lastSeenAt: json['lastSeenAt'] as int,
      firebaseToken: json['firebaseToken'] as String,
      onlinePresence:
          $enumDecode(_$OnlinePresenceEnumMap, json['onlinePresence']),
      profilePhoto: json['profilePhoto'] as String,
    );

Map<String, dynamic> _$GroundedUserToJson(GroundedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userType': _$UserTypeEnumMap[instance.userType],
      'onlinePresence': _$OnlinePresenceEnumMap[instance.onlinePresence],
      'registrationTime': instance.registrationTime,
      'lastSeenAt': instance.lastSeenAt,
      'firebaseToken': instance.firebaseToken,
      'profilePhoto': instance.profilePhoto,
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
