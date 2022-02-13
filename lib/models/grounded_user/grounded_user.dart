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
    this.registrationTime = 0,
    this.lastSeenAt = 0,
    this.firebaseToken = '',
    this.onlinePresence = OnlinePresence.offline,
    this.profilePhoto =
        "https://firebasestorage.googleapis.com/v0/b/sonocare-15c7d.appspot.com/o/user_icon.png?alt=media&token=3de311b3-2b09-4573-949d-3887711f1368",
  });

  factory GroundedUser.fromJson(Map<String, dynamic> json) =>
      _$GroundedUserFromJson(json);
  Map<String, dynamic> toJson() => _$GroundedUserToJson(this);
}
