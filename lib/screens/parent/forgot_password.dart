import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/screens/parent/login_parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          theme: CustomAppBarTheme.light,
          isWhiteBackround: false,
        ),
        backgroundColor: ThemeColors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: ScreenTitle(
                    title: "Forgot password", isWhiteForeground: true),
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
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Uh-oh! did someone forget their password',
                          style: TextStyles.bold.copyWith(fontSize: 22)),
                    ),
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "That's ok! Just enter the email address you've used to register with us and we'll send you a reset link",
                        style: TextStyles.regular,
                      ),
                    ),
                    SizedBox(height: 35),
                    InputField(
                        controller: _emailController,
                        hintText: 'Enter your recovery email address',
                        title: 'Email address'),
                    SizedBox(height: 160),
                    CustomActionButton(
                      onPressed: _sendPasswordResetEmail,
                      title: 'Reset Password',
                    ),
                    SizedBox(height: 200),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _sendPasswordResetEmail() {
    EasyLoading.show();
    _authService
        .sendParentPasswordResetEmail(email: _emailController.text)
        .then((_) {
      EasyLoading.dismiss();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginParent()));
    }).catchError((onError) {});
  }
}
