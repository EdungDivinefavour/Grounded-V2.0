import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/services/firebase/authentication_service.dart';

class LoginChild extends StatelessWidget {
  final _loginTokenController = TextEditingController();
  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: Container());
  }

  void _loginChild(BuildContext context) {
    EasyLoading.show();
    _authService
        .loginChild(loginToken: _loginTokenController.text)
        .then((Child child) {
      EasyLoading.dismiss();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => BottomTabs(groundedUser: child)),
          (_) => false);
    }).catchError((onError) {
      EasyLoading.showError('Please confirm login token and try again.');
    });
  }
}
