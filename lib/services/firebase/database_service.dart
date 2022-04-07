import 'package:firebase_database/firebase_database.dart';
import 'package:grounded/constants/enums/online_presence.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/firebase/messaging_service.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class DatabaseReferences {
  static const parents = 'parents';
  static const children = 'children';
}

class DatabaseService {
  DatabaseService._();
  static final DatabaseService _instance = DatabaseService._();
  static DatabaseService get instance => _instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  final _localStorage = LocalStorage.instance;

  final _firestoreService = FirestoreService.instance;
  final _messagingService = MessagingService.instance;

  Future<void> updateRealTimeDbPresence({
    required String userId,
    required OnlinePresence onlinePresence,
  }) async {
    final userInfo = await _localStorage.getUserInfoFromLocal();
    final reference = userInfo!.userType == UserType.parent
        ? DatabaseReferences.parents
        : DatabaseReferences.children;

    if (userInfo!.userType == UserType.child) {
      final parentInfo =
          await _firestoreService.getParentInfo(userInfo.parentID);
      await _messagingService.sendRemoteMessage(
          receiverToken: parentInfo.firebaseToken,
          title: 'Hey ${parentInfo.name}',
          body: '${userInfo.name} " is now ${onlinePresence.value}');
    }

    await _databaseReference.child(reference).child(userId).update({
      "onlinePresence": onlinePresence.value,
      'lastSeenAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> listenForAppDisconnected({required String userId}) async {
    final userInfo = await _localStorage.getUserInfoFromLocal();
    final reference = userInfo!.userType == UserType.parent
        ? DatabaseReferences.parents
        : DatabaseReferences.children;

    return _databaseReference
        .child(reference)
        .child(userId)
        .onDisconnect()
        .update({
      "onlinePresence": OnlinePresence.offline.value,
      'lastSeenAt': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
