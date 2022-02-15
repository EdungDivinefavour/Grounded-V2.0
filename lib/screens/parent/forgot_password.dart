import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class ForgotPassword extends StatelessWidget {
  final _emailController = TextEditingController();
  final _authService = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundColor: ThemeColors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                  lowerTitle: "Forgot password",
                  theme: CustomAppBarTheme.light),
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
                      child: Text('Uh-oh! did someone forget their password',
                          style: TextStyles.bold.copyWith(fontSize: 26)),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "That's ok! Just enter the email address you've used to register with us and we'll send you a reset link",
                        style: TextStyles.regular,
                      ),
                    ),
                    SizedBox(height: 20),
                    InputField(
                        controller: _emailController,
                        hintText: 'Enter your recovery email address',
                        title: 'Email address'),
                    SizedBox(height: 160),
                    CustomActionButton(
                        onPressed: _sendPasswordResetEmail,
                        title: 'Reset Password'),
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
        .then((_) {})
        .catchError((onError) {});
  }
}
