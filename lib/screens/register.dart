import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/parent/home_parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';

class Register extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: Container());
  }

  void _registerParent(BuildContext context) {
    EasyLoading.show();
    _authService
        .registerParent(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text)
        .then((Parent parent) {
      EasyLoading.dismiss();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeParent(parent: parent)),
          (_) => false);
    }).catchError((onError) {
      EasyLoading.showError(
          'Unable to create your account at this time. Please try again later');
    });
  }
}
