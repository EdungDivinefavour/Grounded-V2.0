import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/services/firebase/firestore_service.dart';

class LoginChild extends StatefulWidget {
  @override
  State<LoginChild> createState() => _LoginChildState();
}

class _LoginChildState extends State<LoginChild> {
  final _loginTokenController = TextEditingController();

  final _firestoreService = FirestoreService.instance;
  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: Container());
  }

  void _loginChild() async {
    EasyLoading.show();
    final result = await _firestoreService
        .getChildInfoFromLoginToken(_loginTokenController.text);

    _authService
        .loginUser(
            email: result.email,
            password: result.password,
            userType: UserType.child)
        .then((GroundedUser groundedUser) {
      EasyLoading.dismiss();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => BottomTabs(groundedUser: groundedUser)),
          (_) => false);
    }).catchError((onError) {
      EasyLoading.showError('Please confirm login token and try again.');
    });
  }
}
