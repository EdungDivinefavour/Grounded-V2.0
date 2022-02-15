import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/clickable_text.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/screens/parent/login_parent.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:open_mail_app/open_mail_app.dart';

class CheckEmail extends StatefulWidget {
  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
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
                    CustomActionButton(
                        onPressed: () {}, title: 'Open Email App'),
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
        ));
  }

  void _openLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginParent()));
  }

  void _openEmailApp() async {
    var result = await OpenMailApp.openMailApp();
    if (result.didOpen && result.canOpen) {
      showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(mailApps: result.options);
        },
      );
      return;
    }

    EasyLoading.showError("No mail apps found");
  }
}
