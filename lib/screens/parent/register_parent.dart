import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/clickable_text.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/parent/home_parent.dart';
import 'package:grounded/screens/parent/login_parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class RegisterParent extends StatefulWidget {
  @override
  State<RegisterParent> createState() => _RegisterParentState();
}

class _RegisterParentState extends State<RegisterParent> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundColor: ThemeColors.primary,
        body: SingleChildScrollView(
            child: Column(
          children: [
            CustomAppBar(
                lowerTitle: "Create an account",
                theme: CustomAppBarTheme.light),
            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: ThemeColors.lightElement,
                ),
                child: Column(children: [
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Welcome!',
                        style: TextStyles.bold.copyWith(fontSize: 26)),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hello there, sign up to continue',
                      style: TextStyles.regular,
                    ),
                  ),
                  SizedBox(height: 20),
                  InputField(
                      controller: _nameController,
                      hintText: 'Enter your full name',
                      title: 'Name'),
                  InputField(
                      controller: _emailController,
                      hintText: 'Enter your email',
                      title: 'Email address'),
                  InputField(
                      controller: _passwordController,
                      hintText: 'Enter password',
                      title: 'Password'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            Text('By creating an account, you agree to our'),
                            ClickableText('Terms and Conditions',
                                onPressed: () {}),
                          ],
                        ),
                      )),
                  CustomActionButton(
                      onPressed: _registerParent, title: 'Sign Up'),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Already have an account?"),
                    ClickableText('Sign In', onPressed: _openLoginParentScreen)
                  ]),
                ])),
          ],
        )));
  }

  void _registerParent() {
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

  void _openLoginParentScreen() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginParent()));
  }
}
