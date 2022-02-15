import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/local_storage/local_storage.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class Communications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommunicationsState();
}

class CommunicationsState extends State<Communications> {
  Parent? _parent;

  final _firestoreService = FirestoreService.instance;
  final _localStorage = LocalStorage.instance;

  @override
  void initState() {
    super.initState();

    _getParentInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: "Communications"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'We occasionally send you the latest products, news and promotional offers. \n \nWe will love to have you opted in so you can receive offers and newsletters.',
                  style: TextStyles.regular,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 45, left: 10),
                  child: Row(
                    children: [
                      Text('I want to receive offers and \nnewsletters',
                          style: TextStyles.regular),
                      Spacer(),
                      SizedBox(
                          width: 65,
                          height: 50,
                          child: Switch(
                              activeTrackColor: Colors.grey[650],
                              value: _parent?.wantsNewsletters ?? false,
                              activeColor: ThemeColors.primary,
                              onChanged: (value) {
                                setState(
                                    () => _parent?.wantsNewsletters = value);
                                setCommunicationPreference();
                              })),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void setCommunicationPreference() async {
    EasyLoading.show();

    await _firestoreService.updateParentInfo(parent: _parent!);
    await _localStorage.storeUserInfoToLocal(_parent!);

    EasyLoading.dismiss();
    EasyLoading.showSuccess("Communication preferences successfully set");
  }

  void _getParentInfo() async {
    final result = await _localStorage.getUserInfoFromLocal();

    setState(() => _parent = result as Parent);
  }
}
