// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grounded_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroundedUser _$GroundedUserFromJson(Map<String, dynamic> json) => GroundedUser(
      name: json['name'] as String,
      id: json['id'] as String,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      registrationTime: json['registrationTime'] as int? ?? 0,
      lastSeenAt: json['lastSeenAt'] as int? ?? 0,
      firebaseToken: json['firebaseToken'] as String? ?? '',
      onlinePresence: $enumDecodeNullable(
              _$OnlinePresenceEnumMap, json['onlinePresence']) ??
          OnlinePresence.offline,
      profilePhoto: json['profilePhoto'] as String? ??
          "https://firebasestorage.googleapis.com/v0/b/sonocare-15c7d.appspot.com/o/user_icon.png?alt=media&token=3de311b3-2b09-4573-949d-3887711f1368",
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
