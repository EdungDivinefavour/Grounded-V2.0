import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grounded/services/firebase/firestore_service.dart';

class MessagingService {
  MessagingService._();
  static final MessagingService _instance = MessagingService._();
  static MessagingService get instance => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

  Future<void> saveTokenToDatabase(String token) async {
    _firestoreService.storeToken(_auth.currentUser!.uid, token);
  }

  Future<void> getAndSetTokens() async {
    String? token = await _messaging.getToken();
    await saveTokenToDatabase(token!);
    _messaging.onTokenRefresh.listen(saveTokenToDatabase);
  }
}
