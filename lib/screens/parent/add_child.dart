import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar.dart';
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
import 'package:number_picker_dialog/number_picker_dialog.dart';

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
  String? _pickedUploadedPhotoUrl;

  int _ageValue = 0;
  int _gradeValue = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: "Add New Child"),
      bubblePosition: BackgroundBubblePosition.centerRight,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 25),
            InkWell(
              onTap: _openPickImageSheet,
              child: _pickedImage == null
                  ? UserImage(imageURL: _pickedUploadedPhotoUrl)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(150.0),
                      child: Image.file(_pickedImage!,
                          height: 150, width: 150, fit: BoxFit.cover),
                    ),
            ),
            SizedBox(height: 30),
            InputField(
              title: "Name",
              hintText: "Enter your child's name",
              controller: _nameController,
              hasBorder: true,
            ),
            SizedBox(height: 35),
            InputField(
              title: "Age",
              hintText: 'Enter the child age',
              controller: _ageController,
              onTap: _showAgeDialog,
              hasBorder: true,
            ),
            SizedBox(height: 35),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Grade',
                        style: TextStyles.semiBold.copyWith(
                          color: ThemeColors.darkBackground,
                          fontSize: 15,
                        ),
                      )),
                ),
                Text("$_gradeValue", style: TextStyles.regular),
                Slider(
                  min: 0,
                  thumbColor: ThemeColors.primaryDark,
                  activeColor: ThemeColors.primaryDark,
                  divisions: 10,
                  value: _gradeValue.toDouble(),
                  max: 12,
                  onChanged: (value) {
                    setState(() => _gradeValue = value.round());
                  },
                ),
              ],
            ),
            Spacer(),
            CustomActionButton(
                title: "Proceed", onPressed: _addChild, isRedButton: true),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showAgeDialog() {
    showMaterialNumberPicker(
      context: context,
      title: "Pick your child's age",
      headerColor: ThemeColors.primary,
      headerTextStyle: TextStyles.bold
          .copyWith(fontSize: 22.0, color: ThemeColors.lightElement),
      scrollItemTextStyle: TextStyles.regular,
      selectedItemTextStyle:
          TextStyles.bold.copyWith(color: ThemeColors.primary, fontSize: 20),
      confirmTextStyle: TextStyles.regular.copyWith(color: ThemeColors.primary),
      cancelTextStyle: TextStyles.regular.copyWith(color: ThemeColors.primary),
      bottomBorderColor: ThemeColors.darkBackground,
      maxNumber: 20,
      minNumber: 1,
      maxLongSide: 370,
      selectedNumber: _ageValue,
      onChanged: (value) => setState(() {
        _ageValue = value;
        _ageController.text = _ageValue.toString();
      }),
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

    EasyLoading.showInfo("Profile photo uploaded successfully");
    setState(() {
      _pickedUploadedPhotoUrl = uploadedPhotoUrl;
    });
  }

  void _addChild() async {
    if (_nameController.text.isEmpty || _ageValue == 0 || _gradeValue == 0) {
      EasyLoading.showError("Please ensure that no fields are left empty");
      return;
    }

    if (_pickedUploadedPhotoUrl == null) {
      EasyLoading.showError("Please upload a photo to proceed");
      return;
    }

    EasyLoading.show();
    final parentID = _authService.currentUser!.uid;
    final loginToken = generateLoginToken;
    final email = '${loginToken}fromParent$parentID@gmail.com';

    final child = await _authService.registerChild(
      email: email,
      password: 'x$loginToken',
      loginToken: loginToken,
      name: _nameController.text,
      photoUrl: _pickedUploadedPhotoUrl!,
      parentID: _authService.currentUser!.uid,
      age: int.parse(_ageController.text),
      grade: _gradeValue,
    );

    await _firestoreService.updateChildProfilePhoto(
        photoUrl: _pickedUploadedPhotoUrl!,
        childID: _authService.currentUser!.uid);

    await _authService.loginUser(
        email: widget.parent.email,
        password: widget.parent.password,
        userType: widget.parent.userType);
    EasyLoading.showSuccess("Child added successfully");
    Navigator.pop(context, child);
  }
}
