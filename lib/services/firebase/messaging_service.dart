import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class MessagingService {
  MessagingService._();
  static final MessagingService _instance = MessagingService._();
  static MessagingService get instance => _instance;

  final _auth = FirebaseAuth.instance;
  final _messaging = FirebaseMessaging.instance;
  final _firestoreService = FirestoreService.instance;
  final _localStorage = LocalStorage.instance;

  UserType? userType;

  Future<void> saveTokenToDatabase(String token) async {
    final userInfo = await _localStorage.getUserInfoFromLocal();

    _firestoreService.storeToken(
        userInfo!.userType, _auth.currentUser!.uid, token);
  }

  Future<void> getAndSetTokens() async {
    String? token = await _messaging.getToken();
    await saveTokenToDatabase(token!);

    _messaging.onTokenRefresh.listen(saveTokenToDatabase);
  }
}
