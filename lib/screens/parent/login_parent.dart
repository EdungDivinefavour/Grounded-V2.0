import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/screens/parent/home_parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';

class LoginParent extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authenticationService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void _loginParent(BuildContext context) {
    EasyLoading.show();
    _authenticationService
        .loginParent(
            email: _emailController.text, password: _passwordController.text)
        .then((_) {
      EasyLoading.dismiss();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeParent()), (_) => false);
    }).catchError((onError) {
      EasyLoading.showError('Please confirm email and password and try again.');
    });
  }
}
