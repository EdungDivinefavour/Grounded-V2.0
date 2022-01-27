import 'package:flutter/material.dart';
import 'package:grounded/services/firebase/authentication_service.dart';

class ForgotPassword extends StatelessWidget {
  final _emailController = TextEditingController();
  final _authenticationService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void sendPasswordResetEmail() {
    _authenticationService
        .sendPasswordResetEmail(email: _emailController.text)
        .then((_) {})
        .catchError((onError) {});
  }
}
