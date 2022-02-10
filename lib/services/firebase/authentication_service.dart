import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/constants/enums/online_presence.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/services/firebase/database_service.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/firebase/messaging_service.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class AuthenticationService {
  AuthenticationService._();
  static final AuthenticationService _instance = AuthenticationService._();
  static AuthenticationService get instance => _instance;

  final FirestoreService _firestoreService = FirestoreService.instance;
  final DatabaseService _databaseService = DatabaseService.instance;
  final MessagingService _messagingService = MessagingService.instance;

  final LocalStorage _localStorage = LocalStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<Parent> registerParent({
    required String email,
    required String password,
    required String name,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final newParent = Parent.newParent(
        id: result.user!.uid, name: name, email: email, password: password);

    await _firestoreService.storeParentInfo(
        parentId: result.user!.uid, parent: newParent);

    await _databaseService.updateRealTimeDbPresence(
        userId: newParent.id, onlinePresence: OnlinePresence.online);

    await _messagingService.getAndSetTokens();
    await _localStorage.storeUserInfoToLocal(newParent);

    return newParent;
  }

  Future<Parent> loginParent({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final parentInfo = await _firestoreService.getParentInfo(result.user!.uid);

    await _databaseService.updateRealTimeDbPresence(
        userId: parentInfo.id, onlinePresence: OnlinePresence.online);

    await _messagingService.getAndSetTokens();
    await _localStorage.storeUserInfoToLocal(parentInfo);

    return parentInfo;
  }

  Future<Child> loginChild({required String loginToken}) async {
    final parent =
        await _firestoreService.getParentInfoForLoginToken(loginToken);

    return parent.children.firstWhere((x) => x.loginToken == loginToken);
  }

  Future<void> updatePassword({required String password}) async {
    final userInfo = await _firestoreService.getParentInfo(currentUser!.uid);
    if (password != userInfo.password) {
      EasyLoading.showError(
          'Incorrect password!. Please input the correct password linked to ths account');
      return;
    }

    await currentUser!.updatePassword(password);
    EasyLoading.showSuccess('Password updated successfully!"');
  }

  Future<void> sendPasswordResetEmail({required String email}) {
    return _auth.sendPasswordResetEmail(email: email).then((_) {
      EasyLoading.showInfo("Password reset email sent to " + email);
    }).catchError((_) {
      EasyLoading.showError(
          "There was an error. Please check that the given email is attached to a registered account");
    });
  }

  void terminateLogin({required String message}) {
    signOutUser();
    EasyLoading.showError(message);
    return;
  }

  void signOutUser() {
    _auth.signOut();
    _localStorage.clearUserInfoFromLocal();
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
