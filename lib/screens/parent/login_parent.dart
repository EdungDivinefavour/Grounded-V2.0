import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/clickable_text.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/screens/parent/home_parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class LoginParent extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: SingleChildScrollView(
      child: Container(
        color: ThemeColors.primary,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 110, bottom: 30),
              alignment: Alignment.centerLeft,
              child: Text('Sign In',
                  style: TextStyles.bold
                      .copyWith(color: ThemeColors.lightElement, fontSize: 30)),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: ThemeColors.lightElement,
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Welcome Back !',
                        style: TextStyles.bold.copyWith(fontSize: 26)),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign in with your account to proceed',
                      style: TextStyles.regular,
                    ),
                  ),
                  SizedBox(height: 20),
                  InputField(
                      controller: _emailController,
                      hintText: 'Enter your email address',
                      title: 'Email address'),
                  SizedBox(height: 15),
                  InputField(
                      controller: _passwordController,
                      hintText: 'Enter password',
                      title: 'Password'),
                  Align(
                      alignment: Alignment.centerRight,
                      child:
                          ClickableText('Forgot Password?', onPressed: () {})),
                  SizedBox(height: 10),
                  CustomActionButton(onPressed: () {}, title: 'Sign In'),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Don't have an account?"),
                    ClickableText('Sign Up', onPressed: () {})
                  ]),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Or',
                        style: TextStyles.medium,
                      )),
                  SizedBox(height: 5),
                  ClickableText('Sign In As Child', onPressed: () {})
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void _loginParent(BuildContext context) {
    EasyLoading.show();
    _authService
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
