import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/components/custom_scaffold.dart';

class ForgotPassword extends StatelessWidget {
  final _emailController = TextEditingController();
  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: Container());
  }

  void _sendPasswordResetEmail() {
    EasyLoading.show();
    _authService
        .sendPasswordResetEmail(email: _emailController.text)
        .then((_) {})
        .catchError((onError) {});
  }
}
