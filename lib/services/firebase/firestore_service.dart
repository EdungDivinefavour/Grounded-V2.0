import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class FirebaseDocuments {
  static const parents = 'parents';
  static const children = 'children';
}

class FirestoreService {
  FirestoreService._();
  static final FirestoreService _instance = FirestoreService._();
  static FirestoreService get instance => _instance;

  final LocalStorage _localStorage = LocalStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeParentInfo({Parent? parent, String? parentId}) async {
    final parentInfo = parent ?? await getParentInfo(parentId!);

    return _firestore
        .collection(FirebaseDocuments.parents)
        .doc(parentId)
        .set({"id": parentId, ...parentInfo.toJson()});
  }

  Future<void> updateParentInfo({required Parent parent}) async {
    return _firestore
        .collection(FirebaseDocuments.parents)
        .doc(parent.id)
        .update(parent.toJson());
  }

  Future<Parent> getParentInfo(String parentId) {
    return _firestore
        .collection(FirebaseDocuments.parents)
        .doc(parentId)
        .get()
        .then((snapshot) => Parent.fromJson(snapshot.data()!));
  }

  Future<void> storeChildInfo({Child? child, String? childId}) async {
    final childInfo = child ?? await getChildInfo(childId!);

    return _firestore
        .collection(FirebaseDocuments.children)
        .doc(childId)
        .set({"id": childId, ...childInfo.toJson()});
  }

  Future<Child> getChildInfo(String childId) {
    return _firestore
        .collection(FirebaseDocuments.children)
        .doc(childId)
        .get()
        .then((snapshot) => Child.fromJson(snapshot.data()!));
  }

  Future<Child?> getChildInfoFromLoginToken(String loginToken) async {
    final querySnapshot = await _firestore
        .collection(FirebaseDocuments.children)
        .where("loginToken", isEqualTo: loginToken)
        .get();
    if (querySnapshot.docs.isEmpty) return null;

    return Child.fromJson(querySnapshot.docs[0].data());
  }

  Future<List<Child>> getChildrenForParent(Parent parent) {
    return _firestore
        .collection(FirebaseDocuments.children)
        .where("parentID", isEqualTo: parent.id)
        .get()
        .then((snapshot) => Child.fromJsonList(
              snapshot.docs.map((x) => x.data()).toList(),
            ));
  }

  Future<void> updateChildProfilePhoto({
    required String photoUrl,
    required String childID,
  }) async {
    await _firestore
        .collection(FirebaseDocuments.children)
        .doc(childID)
        .update({"profilePhoto": photoUrl});

    final child = await getChildInfo(childID);
    await _localStorage.storeUserInfoToLocal(child);
  }

  Future<void> deleteChild(Child child) async {
    await _firestore
        .collection(FirebaseDocuments.children)
        .doc(child.id)
        .delete();
  }

  Future<void> storeTask({
    required GroundedTask task,
    required Child child,
  }) async {
    await _firestore
        .collection(FirebaseDocuments.children)
        .doc(child.id)
        .update({
      "tasks": FieldValue.arrayUnion([task.toJson()])
    });
  }

  Future<void> updateTasks({
    required List<GroundedTask> tasks,
    required Child child,
  }) async {
    await _firestore
        .collection(FirebaseDocuments.children)
        .doc(child.id)
        .update({
      "tasks": tasks.map((x) => x.toJson()).toList(),
    });
  }

  Future<void> storeToken(
    UserType userType,
    String userId,
    String token,
  ) async {
    final collection = userType == UserType.parent
        ? FirebaseDocuments.parents
        : FirebaseDocuments.children;

    return _firestore.collection(collection).doc(userId).update({
      'firebaseToken': token,
    });
  }

  Future<void> storePassword(String userId, String password) async {
    return _firestore.collection(FirebaseDocuments.parents).doc(userId).update({
      'password': password,
    });
  }
}
