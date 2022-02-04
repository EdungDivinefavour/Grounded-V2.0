import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class FirebaseDocuments {
  static const users = 'users';
}

class FirestoreService {
  FirestoreService._();
  static final FirestoreService _instance = FirestoreService._();
  static FirestoreService get instance => _instance;

  final LocalStorage _localStorage = LocalStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Parent> getParentInfo(String userId) {
    return _firestore
        .collection(FirebaseDocuments.users)
        .doc(userId)
        .get()
        .then((snapshot) => Parent.fromJson(snapshot.data()!));
  }

  Future<void> storeParentInfo({Parent? parent, String? userId}) async {
    final parentInfo = parent ?? await getParentInfo(userId!);

    return _firestore
        .collection(FirebaseDocuments.users)
        .doc(userId)
        .set({"id": userId, ...parentInfo.toJson()});
  }

  Future<void> storeChildInfo({required Child newChild}) async {
    await _firestore
        .collection(FirebaseDocuments.users)
        .doc(newChild.parentID)
        .update({
      "children": FieldValue.arrayUnion([newChild.toJson()])
    });

    final parent = await getParentInfo(newChild.parentID);
    await _localStorage.storeUserInfoToLocal(parent);
  }

  Future<void> updateChildProfilePhoto({
    required String photoUrl,
    required String parentID,
  }) async {
    // await _firestore.collection(FirebaseDocuments.users).doc(parentID).update({
    //   "children": FieldValue.arrayUnion([newChild.toJson()])
    // });

    final parent = await getParentInfo(parentID);
    await _localStorage.storeUserInfoToLocal(parent);
  }

  Future<void> storeToken(String userId, String token) async {
    return _firestore.collection(FirebaseDocuments.users).doc(userId).update({
      'firebaseToken': token,
    });
  }
}
