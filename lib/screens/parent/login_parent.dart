import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/clickable_text.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/screens/child/login_child.dart';
import 'package:grounded/screens/parent/forgot_password.dart';
import 'package:grounded/screens/parent/register_parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class LoginParent extends StatefulWidget {
  @override
  State<LoginParent> createState() => _LoginParentState();
}

class _LoginParentState extends State<LoginParent> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

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
                child: ScreenTitle(title: "Sign In", isWhiteForeground: true),
              ),
              Container(
                padding: EdgeInsets.all(22),
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
                      child: Text('Welcome Back !',
                          style: TextStyles.bold.copyWith(fontSize: 26)),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Sign in with your account to proceed',
                          style: TextStyles.smallRegular
                              .copyWith(color: ThemeColors.darkBackground)),
                    ),
                    SizedBox(height: 40),
                    InputField(
                      controller: _emailController,
                      hintText: 'Enter your email address',
                      title: 'Email address',
                      inputFieldType: InputFieldType.email,
                    ),
                    SizedBox(height: 35),
                    InputField(
                      controller: _passwordController,
                      hintText: 'Enter password',
                      title: 'Password',
                      inputFieldType: InputFieldType.password,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: ClickableText(
                          'Forgot Password?',
                          onPressed: _openForgotPasswordScreen,
                        )),
                    SizedBox(height: 10),
                    CustomActionButton(
                        onPressed: _loginParent, title: 'Sign In'),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Don't have an account?",
                          style: TextStyles.smallRegular),
                      ClickableText('Sign Up',
                          onPressed: _openRegisterParentScreen)
                    ]),
                    Align(
                        alignment: Alignment.center,
                        child: Text('Or',
                            style:
                                TextStyles.smallBold.copyWith(fontSize: 16))),
                    SizedBox(height: 10),
                    ClickableText('Sign In As Child',
                        onPressed: _openLoginChildScreen),
                    SizedBox(height: 100)
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _loginParent() {
    EasyLoading.show();
    _authService
        .loginUser(
            email: _emailController.text,
            password: _passwordController.text,
            userType: UserType.parent)
        .then((GroundedUser groundedUser) {
      EasyLoading.dismiss();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => BottomTabs(groundedUser: groundedUser)),
          (_) => false);
    }).catchError((onError) {
      EasyLoading.showError('Please confirm email and password and try again.');
    });
  }

  void _openRegisterParentScreen() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => RegisterParent()));
  }

  void _openLoginChildScreen() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginChild()));
  }

  void _openForgotPasswordScreen() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => ForgotPassword()));
  }
}
