import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/screens/parent/login_parent.dart';
import 'package:open_mail_app/open_mail_app.dart';

class CheckEmail extends StatefulWidget {
  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: Container());
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
