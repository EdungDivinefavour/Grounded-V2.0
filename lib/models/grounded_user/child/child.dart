import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/utils/string_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'child.g.dart';

@JsonSerializable(explicitToJson: true)
class Child extends GroundedUser {
  final String parentID;
  final String loginToken;
  @override
  String name;
  int age;
  int grade;

  Child({
    required this.name,
    required this.parentID,
    required this.loginToken,
    required this.age,
    required this.grade,
  }) : super(id: Uuid().v1(), name: name, userType: UserType.child);

  static Child newChild({
    required String name,
    required String parentID,
    required int age,
    required int grade,
  }) {
    return Child(
        name: name,
        parentID: parentID,
        loginToken: generateLoginToken,
        age: age,
        grade: grade);
  }

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);
  Map<String, dynamic> toJson() => _$ChildToJson(this);
}
