import 'package:flutter/material.dart';
import 'package:grounded/services/firebase/authentication_service.dart';

class Register extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authenticationService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void registerParent() {
    _authenticationService
        .registerParent(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text)
        .then((_) {})
        .catchError((onError) {});
  }
}
