import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_check_box.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
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
      bubblePosition: BackgroundBubblePosition.topRight,
      appBar: CustomAppBar(title: "Notifications"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 30),
                CustomCheckBox(
                  title: "Notify me when my child completes a \ntask",
                  value: _parent?.notificationPreferences
                          .notifyWhenChildCompletesTask ??
                      false,
                  onChanged: (value) {
                    setState(() => _parent?.notificationPreferences
                        .notifyWhenChildCompletesTask = value!);
                    setNotificationPreference();
                  },
                ),
                CustomCheckBox(
                  title: "Notify me when my child comes online",
                  value: _parent?.notificationPreferences
                          .notifyWhenChildComesOnline ??
                      false,
                  onChanged: (value) {
                    setState(() => _parent?.notificationPreferences
                        .notifyWhenChildComesOnline = value!);
                    setNotificationPreference();
                  },
                ),
                CustomCheckBox(
                  title: "Notify me when my child goes offline",
                  value: _parent?.notificationPreferences
                          .notifyWhenChildGoesOffline ??
                      false,
                  onChanged: (value) {
                    setState(() => _parent?.notificationPreferences
                        .notifyWhenChildGoesOffline = value!);
                    setNotificationPreference();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setNotificationPreference() async {
    EasyLoading.show();

    await _firestoreService.updateParentInfo(parent: _parent!);
    await _localStorage.storeUserInfoToLocal(_parent!);

    EasyLoading.dismiss();
    EasyLoading.showSuccess("Notification preference set successfully");
  }

  void _getParentInfo() async {
    final result = await _localStorage.getUserInfoFromLocal();

    setState(() => _parent = result as Parent);
  }
}
