import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/components/snackbar_component.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  Rx<File?> pickedImageFile = Rx<File?>(null);

  // Initiazlizing Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? uniqueId;

  Future<void> onCreateAccount() async {
    if (registerFormKey.currentState!.validate()) {
      if (pickedImageFile.value == null) {
        Get.back();
        SnackbarCompnent.showSnackbar(
            "Attention!", "Please set profile image", Colors.red);
      }

      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: email.text, password: confirmPassword.text);

        // Store image
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user-images')
            .child('${userCredential.user!.uid}.jpg');

        await storageRef.putFile(pickedImageFile.value!);
        final imageURL = await storageRef.getDownloadURL();

        // Create firestore collection to store data

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {
            "unique_id": userCredential.user!.uid.toString(),
            "first_name": firstName.text.toString(),
            "last_name": lastName.text.toString(),
            "email": email.text.toString(),
            "password": password.text.toString(),
            "confirm_password": confirmPassword.text.toString(),
            "image_url": imageURL,
          },
        );

        // Showing Snackbar of Successfully account is created
        SnackbarCompnent.showSnackbar(
            "Congratulation", "Account created successfully", Colors.green);

        // Get.toNamed(AppRoutes.homeScreen);
        Get.offAllNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {}
        Get.back();
        SnackbarCompnent.showSnackbar(error.message ?? "Registration failed",
            "Please try again", Colors.red);
      }
    }
  }

  // image upload

  void uploadImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    pickedImageFile.value = File(pickedImage.path);
  }

  void uploadImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    pickedImageFile.value = File(pickedImage.path);
  }

  // Bottom Sheet
  void showOptionsBottomSheet() {
    Get.bottomSheet(
      backgroundColor: kColorWhite,
      Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            ListTile(
              leading: const Icon(
                Icons.camera,
                color: kColorPrimary,
              ),
              title: Text('Camera'),
              onTap: () {
                uploadImageFromCamera();
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo,
                color: kColorPrimary,
              ),
              title: Text('Gallery'),
              onTap: () {
                uploadImageFromGallery();
                Get.back();
              },
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
