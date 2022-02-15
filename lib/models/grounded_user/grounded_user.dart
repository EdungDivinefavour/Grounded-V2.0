import 'package:grounded/constants/enums/online_presence.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grounded_user.g.dart';

@JsonSerializable(explicitToJson: true)
class GroundedUser {
  final String id;
  final String name;
  final UserType userType;
  final OnlinePresence onlinePresence;
  final int registrationTime;
  final int lastSeenAt;
  final String firebaseToken;
  String profilePhoto;

  GroundedUser({
    required this.name,
    required this.id,
    required this.userType,
    required this.registrationTime,
    required this.lastSeenAt,
    required this.firebaseToken,
    required this.onlinePresence,
    required this.profilePhoto,
  });

  factory GroundedUser.fromJson(Map<String, dynamic> json) =>
      _$GroundedUserFromJson(json);
  Map<String, dynamic> toJson() => _$GroundedUserToJson(this);
}
