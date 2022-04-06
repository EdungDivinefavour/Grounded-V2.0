import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/components/small_input_field.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class LoginChild extends StatefulWidget {
  @override
  State<LoginChild> createState() => _LoginChildState();
}

class _LoginChildState extends State<LoginChild> {
  final _firestoreService = FirestoreService.instance;
  final _authService = AuthenticationService.instance;

  String? _enteredToken;

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
                    title: "Sign In As Child", isWhiteForeground: true),
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
                      child: Text('Hey There',
                          style: TextStyles.bold.copyWith(fontSize: 26)),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter the token given to you by your parent",
                        style: TextStyles.regular,
                      ),
                    ),
                    PNGIcon(size: 280, icon: AppIcons.phoneInHandPNG),
                    _buildInputBoxes,
                    SizedBox(height: 100),
                    CustomActionButton(
                        title: 'Proceed', onPressed: _loginChild),
                    SizedBox(height: 200),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget get _buildInputBoxes {
    return SmallInputField(
      fieldWidth: 55,
      numberOfFields: 5,
      hasCustomInputDecoration: true,
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: ThemeColors.lightBackground,
      ),
      borderColor: ThemeColors.primary,
      onSubmit: (value) {
        _enteredToken = value;
      },
    );
  }

  void _loginChild() async {
    if (_enteredToken == null) {
      EasyLoading.showError('Please enter a valid login token and try again');
      return;
    }

    EasyLoading.show();
    final result = await _firestoreService.getChildInfoFromLoginToken(
      _enteredToken!,
    );

    if (result == null) {
      EasyLoading.showError('Please confirm login token and try again.');
      return;
    }

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
    });
  }
}
