import 'package:grounded/constants/enums/online_presence.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/achievement.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'child.g.dart';

@JsonSerializable(explicitToJson: true)
class Child extends GroundedUser {
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
  final String parentID;
  final String loginToken;
  final int age;
  final int grade;
  final List<GroundedTask> tasks;
  final List<Achievement> achievements;

  Child({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.parentID,
    required this.loginToken,
    required this.age,
    required this.grade,
    required this.achievements,
    required this.tasks,
    this.userType = UserType.child,
    this.registrationTime = 0,
    this.lastSeenAt = 0,
    this.firebaseToken = '',
    this.onlinePresence = OnlinePresence.offline,
    this.profilePhoto =
        "https://firebasestorage.googleapis.com/v0/b/grounded-440dc.appspot.com/o/placeholders%2Fno_profile_photo.png?alt=media&token=f7f210f9-8cc8-42ed-81d6-55a4679c260b",
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

  static Child newChild({
    required String id,
    required String name,
    required String password,
    required String loginToken,
    required String email,
    required String parentID,
    required int age,
    required int grade,
  }) {
    return Child(
      id: id,
      name: name,
      email: email,
      password: password,
      parentID: parentID,
      loginToken: loginToken,
      age: age,
      grade: grade,
      achievements: [],
      tasks: [],
    );
  }

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

  static List<Child> fromJsonList(List<dynamic>? list) =>
      list?.map((e) => Child.fromJson(e)).toList() ?? [];

  Map<String, dynamic> toJson() => _$ChildToJson(this);
}
