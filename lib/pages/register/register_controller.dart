import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/routes/app_page.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final hidePassword = true.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // Initiazlizing Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> onCreateAccount() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: email.text, password: confirmPassword.text);

        // Create firestore collection to store data

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          "first_name": firstName.text.toString(),
          "last_name": lastName.text.toString(),
          "email": email.text.toString(),
          "password": password.text.toString(),
          "confirm_password": confirmPassword.text.toString(),
        });

        // Showing Snackbar of Successfully account is created
        Get.snackbar(
          "Congratulation",
          "Account created successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          backgroundColor: Colors.white,
        );

        Get.toNamed(AppRoutes.signinScreen);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {}
        Get.snackbar(error.message ?? "Registration failed", "Please try again",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white);
        // GetSnackBar(message: error.message ?? "Registration failed");
      }
    }
  }
}
