import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/clickable_text.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class CheckYourEmail extends StatelessWidget {
  final _emailController = TextEditingController();
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
              child: Text('Check you email',
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
                  SizedBox(height: 20),
                  PNGIcon(size: 145, icon: AppIcons.checkYourEmailPNG),
                  SizedBox(height: 30),
                  Text('Check Your Email',
                      style: TextStyles.bold.copyWith(fontSize: 26)),
                  SizedBox(height: 10),
                  Text(
                    "We have sent password recovery \ninstructions to your email",
                    style: TextStyles.regular,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  CustomActionButton(onPressed: () {}, title: 'Open Email App'),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ClickableText('Skip,', onPressed: () {}),
                    Text("Don't have an account?", style: TextStyles.regular)
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  //void _sendPasswordResetEmail() {
  //EasyLoading.show();
  //_authService
  //.sendPasswordResetEmail(email: _emailController.text)
  //.then((_) {})
  //.catchError((onError) {});
}
//}//