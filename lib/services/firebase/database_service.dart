import 'package:firebase_database/firebase_database.dart';
import 'package:grounded/constants/enums/online_presence.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService _instance = DatabaseService._();
  static DatabaseService get instance => _instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<void> updateRealTimeDbPresence(
      {String? userId, required OnlinePresence onlinePresence}) {
    if (userId == null) return Future.value();

    return _databaseReference.child("users").child(userId).update({
      "onlinePresence": onlinePresence.value,
      'lastSeenAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> listenForAppDisconnected({String? userId}) {
    if (userId == null) return Future.value();
    return _databaseReference
        .child("users")
        .child(userId)
        .onDisconnect()
        .update({
      "onlinePresence": OnlinePresence.offline.value,
      'lastSeenAt': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
