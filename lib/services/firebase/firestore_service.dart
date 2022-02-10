import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grounded/models/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class FirebaseDocuments {
  static const users = 'users';
  static const tasks = 'tasks';
}

class FirestoreService {
  FirestoreService._();
  static final FirestoreService _instance = FirestoreService._();
  static FirestoreService get instance => _instance;

  final LocalStorage _localStorage = LocalStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Parent> getParentInfo(String parentId) {
    return _firestore
        .collection(FirebaseDocuments.users)
        .doc(parentId)
        .get()
        .then((snapshot) => Parent.fromJson(snapshot.data()!));
  }

  Future<Parent> getParentInfoForLoginToken(String loginToken) {
    return _firestore
        .collection(FirebaseDocuments.users)
        .where("childrenLoginTokens", arrayContains: loginToken)
        .get()
        .then((snapshot) => Parent.fromJson(snapshot.docs[0].data()));
  }

  Future<void> storeParentInfo({Parent? parent, String? parentId}) async {
    final parentInfo = parent ?? await getParentInfo(parentId!);

    return _firestore
        .collection(FirebaseDocuments.users)
        .doc(parentId)
        .set({"id": parentId, ...parentInfo.toJson()});
  }

  Future<void> storeChildInfo({required Child newChild}) async {
    await _firestore
        .collection(FirebaseDocuments.users)
        .doc(newChild.parentID)
        .update({
      "childrenLoginTokens": FieldValue.arrayUnion([newChild.loginToken]),
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

  Future<void> storeTask({required GroundedTask task}) async {
    await _firestore
        .collection(FirebaseDocuments.tasks)
        .doc(task.id)
        .set(task.toJson());
  }

  Future<void> storeToken(String userId, String token) async {
    return _firestore.collection(FirebaseDocuments.users).doc(userId).update({
      'firebaseToken': token,
    });
  }
}
