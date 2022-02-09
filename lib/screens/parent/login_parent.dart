import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/components/custom_scaffold.dart';

class LoginParent extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: Container());
  }

  void _loginParent(BuildContext context) {
    EasyLoading.show();
    _authService
        .loginParent(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((Parent parent) {
      EasyLoading.dismiss();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => BottomTabs(groundedUser: parent)),
          (_) => false);
    }).catchError((onError) {
      EasyLoading.showError('Please confirm email and password and try again.');
    });
  }
}
