import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable(explicitToJson: true)
class Parent extends GroundedUser {
  @override
  final String id;
  @override
  final String name;
  final String email;
  final String password;
  final List<Child> children;
  final List<String> childrenLoginTokens;

  Parent({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.children,
    required this.childrenLoginTokens,
  }) : super(id: id, name: name, userType: UserType.parent);

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
      children: [],
      childrenLoginTokens: [],
    );
  }

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);
  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
