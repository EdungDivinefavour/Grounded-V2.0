import 'package:grounded/constants/enums/online_presence.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/models/grounded_user/parent/notification_preferences/notification_preferences.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable(explicitToJson: true)
class Parent extends GroundedUser {
  @override
  final String id;
  @override
  final String name;
  @override
  final UserType userType;
  @override
  final OnlinePresence onlinePresence;
  @override
  final int registrationTime;
  @override
  final int lastSeenAt;
  @override
  final String firebaseToken;
  @override
  String profilePhoto;
  final String email;
  final String password;
  final NotificationPreferences notificationPreferences;

  bool wantsNewsletters;

  Parent({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.notificationPreferences,
    this.userType = UserType.parent,
    this.onlinePresence = OnlinePresence.offline,
    this.registrationTime = 0,
    this.lastSeenAt = 0,
    this.firebaseToken = '',
    this.profilePhoto =
        'https://firebasestorage.googleapis.com/v0/b/sonocare-15c7d.appspot.com/o/user_icon.png?alt=media&token=3de311b3-2b09-4573-949d-3887711f1368',
    this.wantsNewsletters = false,
  }) : super(
          id: id,
          name: name,
          userType: userType,
          onlinePresence: onlinePresence,
          registrationTime: registrationTime,
          lastSeenAt: lastSeenAt,
          firebaseToken: firebaseToken,
          profilePhoto: profilePhoto,
        );

  static Parent newParent({
    required String id,
    required String name,
    required String email,
    required String password,
  }) {
    return Parent(
      id: id,
      name: name,
      email: email,
      password: password,
      notificationPreferences: NotificationPreferences(),
    );
  }

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);
  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
