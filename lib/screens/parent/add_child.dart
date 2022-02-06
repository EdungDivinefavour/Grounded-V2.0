import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/screens/parent/home_parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/firebase/storage_service.dart';
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
  final _authService = AuthenticationService.instance;
  final _storageService = StorageService.instance;

  final _imagePicker = ImagePicker();
  File? _pickedImage;
  String? pickedUploadedPhotoUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
    } else if (result == "camera") {
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
        photoUrl: uploadedPhotoUrl, parentID: _authService.currentUser!.uid);

    EasyLoading.showInfo("Profile photo uploaded successfully");
    pickedUploadedPhotoUrl = uploadedPhotoUrl;
  }

  void _addChild(BuildContext context) async {
    EasyLoading.show();
    final child = Child.newChild(
      name: _nameController.text,
      parentID: _authService.currentUser!.uid,
      age: int.parse(_ageController.text),
      grade: int.parse(_gradeController.text),
    );

    await _firestoreService.storeChildInfo(newChild: child);

    EasyLoading.showSuccess("Child added successfully");
    Navigator.pop(context);
  }
}
