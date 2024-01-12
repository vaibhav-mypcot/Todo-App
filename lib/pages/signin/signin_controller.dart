import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/widget/loader.dart';

class SigninController extends GetxController {
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  final hidePassword = true.obs;

  final email = TextEditingController();
  final password = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    final user = auth.currentUser;
    if (user != null) {
      await Future.delayed(Duration(seconds: 1));
      Get.toNamed(AppRoutes.homeScreen);
    } else {
      await Future.delayed(Duration(seconds: 1));
      Get.toNamed(AppRoutes.signinScreen);
    }
    super.onInit();
  }

  Future<void> onLoginClicked() async {
    if (signinFormKey.currentState!.validate()) {
      try {
        Utils.showLoader();
        final userCredential = await auth.signInWithEmailAndPassword(
          email: email.text.toString(),
          password: password.text.toString(),
        );
        Get.back();
        Get.toNamed(AppRoutes.homeScreen);
        Get.offAllNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        Get.back();
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

  void gotoHomeScreen() {}
}
