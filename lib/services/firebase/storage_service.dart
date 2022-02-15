import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class StorageLocation {
  static const profilePhotos = "profilePhotos";
}

class StorageService {
  StorageService._();
  static final StorageService _instance = StorageService._();
  static StorageService get instance => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebase_storage.FirebaseStorage _firebaseStorage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadProfilePhoto(File file) async {
    final imageRef = _firebaseStorage
        .ref(StorageLocation.profilePhotos)
        .child(file.path + _auth.currentUser!.uid + ".jpg");

    return _uploadAndGetDownloadUrl(imageRef, file);
  }

  Future<String> _uploadAndGetDownloadUrl(
    Reference reference,
    File file,
  ) async {
    await reference.putFile(file);
    final downloadUrl = reference.getDownloadURL();

    return downloadUrl;
  }
}
