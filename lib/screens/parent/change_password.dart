import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/services/firebase/authentication_service.dart';

class ChangePassword extends StatelessWidget {
  final _authenticationService = AuthenticationService.instance;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(title: "Change password"),
        bubblePosition: BackgroundBubblePosition.topRight,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 25),
                InputField(
                  title: "Current Password",
                  controller: _currentPasswordController,
                  inputFieldType: InputFieldType.password,
                  hintText: 'Enter your current password',
                ),
                SizedBox(height: 35),
                InputField(
                  title: "New Password",
                  controller: _newPasswordController,
                  inputFieldType: InputFieldType.password,
                  hintText: 'Enter your new password',
                ),
                SizedBox(height: 35),
                InputField(
                  title: "Confirm New Password",
                  controller: _confirmNewPasswordController,
                  inputFieldType: InputFieldType.password,
                  hintText: 'Confirm your current password',
                ),
                SizedBox(height: 60),
                CustomActionButton(
                    onPressed: () {
                      _updatePassword(context);
                    },
                    title: 'Change Password')
              ],
            ),
          ),
        ));
  }

  void _updatePassword(BuildContext context) {
    if (!_allFieldsPassedValidation) {
      EasyLoading.showError(
          "Please fill out all the empty fields and confirm that the new password has been confirmed in the confirm password box");
      return;
    }

    EasyLoading.show();
    _authenticationService
        .updatePassword(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
    )
        .then((_) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Password updated successfully!');

      Navigator.pop(context);
    }).catchError((onError) {
      EasyLoading.dismiss();
      EasyLoading.showError(
          "This operation is sensitive and requires recent authentication. Please login again to confirm you own this account");
    });
  }

  bool get _allFieldsPassedValidation {
    if (_currentPasswordController.text == "") {
      return false;
    } else if (_newPasswordController.text == "") {
      return false;
    } else if (_confirmNewPasswordController.text == "") {
      return false;
    } else if (_newPasswordController.text !=
        _confirmNewPasswordController.text) {
      return false;
    }

    return true;
  }
}
