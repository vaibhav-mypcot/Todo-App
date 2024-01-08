import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/routes/app_page.dart';

class SigninController extends GetxController {
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  final hidePassword = true.obs;

  final email = TextEditingController();
  final password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    final user = _auth.currentUser;
    if (user != null) {
      await Get.toNamed(AppRoutes.homeScreen);
    } else {
      await Get.toNamed(AppRoutes.signinScreen);
    }
    super.onInit();
  }

  Future<void> onLoginClicked() async {
    if (signinFormKey.currentState!.validate()) {
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text.toString(),
          password: password.text.toString(),
        );
        Get.toNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {}
        Get.snackbar(
          error.message ?? "Registration failed",
          "Please try again",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.white,
        );
      }
    }
  }
}
