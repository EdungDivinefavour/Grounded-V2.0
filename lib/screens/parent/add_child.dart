import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/screens/parent/home_parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/firebase/storage_service.dart';
import 'package:grounded/services/local_storage/local_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddChild extends StatefulWidget {
  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _gradeController = TextEditingController();

  final _firestoreService = FirestoreService.instance;
  final _authenticationService = AuthenticationService.instance;
  final _storageService = StorageService.instance;
  final _localStorage = LocalStorage.instance;

  final _imagePicker = ImagePicker();
  File? _pickedImage;

  Child? _child;

  @override
  void initState() {
    super.initState();

    _child = Child.newChild(
        name: "",
        parentID: _authenticationService.currentUser!.uid,
        age: 0,
        grade: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(onTap: _openPickImageSheet, child: UserImage()),
        ],
      ),
    );
  }

  void _openPickImageSheet() async {
    final result = await showModalActionSheet<String>(
        context: context,
        title: "Select source",
        actions: [
          SheetAction(key: "gallery", label: "Pick from Gallery"),
          SheetAction(key: "camera", label: "Capture with camera"),
        ]);

    if (result == "gallery") {
      _uploadChildProfilePhoto(ImageSource.gallery);
    } else {
      _uploadChildProfilePhoto(ImageSource.camera);
    }
  }

  void _uploadChildProfilePhoto(ImageSource imageSource) async {
    final pickedFile = await _imagePicker.pickImage(source: imageSource);
    if (pickedFile == null) return;

    setState(() {
      _pickedImage = File(pickedFile.path);
      _uploadToFirebase();
    });
  }

  void _uploadToFirebase() async {
    EasyLoading.show();
    final uploadedPhotoUrl =
        await _storageService.uploadProfilePhoto(_pickedImage!);

    await _firestoreService.updateChildProfilePhoto(
        photoUrl: uploadedPhotoUrl, parentID: _child!.parentID);

    EasyLoading.showInfo("Profile photo uploaded successfully");
    _child?.profilePhoto = uploadedPhotoUrl;
  }

  void _addChild(BuildContext context) async {
    EasyLoading.show();
    _child!.name = _nameController.text;
    _child!.age = int.parse(_ageController.text);
    _child!.grade = int.parse(_gradeController.text);

    _firestoreService.storeChildInfo(newChild: _child!).then((_) {
      EasyLoading.showSuccess("Child added successfully");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeParent()));
    }).catchError((onError) {
      EasyLoading.showError(
          'Unable to create your account at this time. Please try again later');
    });
  }
}
