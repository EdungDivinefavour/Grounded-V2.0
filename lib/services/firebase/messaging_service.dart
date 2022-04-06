import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/constants/strings/keys.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/http/http_service.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class MessagingService {
  MessagingService._();
  static final MessagingService _instance = MessagingService._();
  static MessagingService get instance => _instance;

  final _auth = FirebaseAuth.instance;
  final _messaging = FirebaseMessaging.instance;
  final _firestoreService = FirestoreService.instance;
  final _localStorage = LocalStorage.instance;

  final _httpService = HttpService.instance;

  UserType? userType;

  Future<void> getAndSetTokens() async {
    String? token = await _messaging.getToken();
    await _saveTokenToDatabase(token!);

    _messaging.onTokenRefresh.listen(_saveTokenToDatabase);
  }

  Future<void> sendRemoteMessage({
    required String receiverToken,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) {
    return _httpService.post('https://fcm.googleapis.com/fcm/send', headers: {
      "Content-Type": "application/json",
      "authorization": fcmServerKey
    }, body: {
      "to": receiverToken,
      "mutable_content": true,
      "notification": {"title": title, "body": body},
      "data": {
        "content": {
          "id": Random().nextInt(400) + 1,
          "channelKey": "app_channel",
          "title": title,
          "body": title,
          "showWhen": true,
          "autoCancel": true,
          "displayOnForeground": false,
          "notificationLayout": "BigText",
          "privacy": "Private",
          "payload": payload
        },
      }
    });
  }

  Future<void> _saveTokenToDatabase(String token) async {
    final userInfo = await _localStorage.getUserInfoFromLocal();

    _firestoreService.storeToken(
        userInfo!.userType, _auth.currentUser!.uid, token);
  }
}
