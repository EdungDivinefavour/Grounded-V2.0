import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/services/firebase/authentication_service.dart';

class ForgotPassword extends StatelessWidget {
  final _emailController = TextEditingController();
  final _authenticationService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void _sendPasswordResetEmail() {
    EasyLoading.show();
    _authenticationService
        .sendPasswordResetEmail(email: _emailController.text)
        .then((_) {})
        .catchError((onError) {});
  }
}
