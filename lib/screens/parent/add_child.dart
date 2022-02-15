import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/firebase/storage_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/string_utils.dart';
import 'package:image_picker/image_picker.dart';

class AddChild extends StatefulWidget {
  final Parent parent;
  AddChild({required this.parent});

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  final _firestoreService = FirestoreService.instance;
  final _authService = AuthenticationService.instance;
  final _storageService = StorageService.instance;

  final _imagePicker = ImagePicker();
  File? _pickedImage;
  String? pickedUploadedPhotoUrl;

  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: "Add New Child"),
      bubblePosition: BackgroundBubblePosition.centerRight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 35),
              InkWell(
                  onTap: _openPickImageSheet,
                  child: UserImage(imageURL: pickedUploadedPhotoUrl)),
              SizedBox(height: 30),
              InputField(
                title: "Name",
                controller: _nameController,
                hintText: "Enter your child's name",
              ),
              InputField(
                title: "Age",
                controller: _ageController,
                hintText: 'Enter the child age',
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Grade'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    sliderValue.toInt().toString(),
                    style: TextStyles.regular,
                  ),
                  Slider(
                      thumbColor: ThemeColors.primary,
                      activeColor: ThemeColors.primary,
                      inactiveColor: ThemeColors.lightBackground,
                      divisions: 10,
                      value: sliderValue,
                      max: 10,
                      onChanged: (value) {
                        setState(() => sliderValue = value);
                      }),
                ],
              ),
              SizedBox(height: 60),
              CustomActionButton(onPressed: _addChild, title: "Proceed")
            ],
          ),
        ),
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
    setState(() {
      pickedUploadedPhotoUrl = uploadedPhotoUrl;
    });
  }

  void _addChild() async {
    EasyLoading.show();
    final parentID = _authService.currentUser!.uid;
    final loginToken = generateLoginToken;
    final email = loginToken + "fromParent" + parentID + "@gmail.com";

    final child = await _authService.registerChild(
        email: email,
        password: loginToken,
        loginToken: loginToken,
        name: _nameController.text,
        parentID: _authService.currentUser!.uid,
        age: int.parse(_ageController.text),
        grade: sliderValue.toInt());

    // This signs in the parent again  because firebase auth by default signs in a new user upon creation
    // TODO: Make firebase functions to create user instead
    await _authService.loginUser(
        email: widget.parent.email,
        password: widget.parent.password,
        userType: widget.parent.userType);
    EasyLoading.showSuccess("Child added successfully");
    Navigator.pop(context, child);
  }
}
