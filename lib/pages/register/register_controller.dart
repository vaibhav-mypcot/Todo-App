import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/signup_model.dart';

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
  final FirebaseFirestore _registrationDb = FirebaseFirestore.instance;

  // registration(SignupModel signupModel) async {
  //   await _registrationDb
  //       .collection("SignupData")
  //       .add(signupModel.toJson())
  //       .whenComplete(
  //         () => Get.snackbar(
  //           "Success",
  //           "Your account has bee created",
  //           snackPosition: SnackPosition.BOTTOM,
  //           colorText: Colors.green,
  //         ),
  //       )
  //       .catchError((error, stackTarce) {
  //     Get.snackbar(
  //       "Error",
  //       "Smoething went wrong",
  //       snackPosition: SnackPosition.BOTTOM,
  //       colorText: Colors.red,
  //     );
  //   });
  // }

  // create user

  // Future<void> registerUser(SignupModel signupModel) async {
  //   UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //     email: email.text,
  //     password: confirmPassword.text,
  //   );

  //   await registration(signupModel);
  // }

  // void onSaveClicked() {
  //   if (registerFormKey.currentState!.validate()) {
  //     final userRegister = SignupModel(
  //       firstName: firstName.text.trim(),
  //       lastName: lastName.text.trim(),
  //       email: email.text.trim(),
  //       password: password.text.trim(),
  //       confirmPassword: confirmPassword.text.trim(),
  //     );
  //     registerUser(userRegister);
  //     // Get.toNamed(AppRoutes.addressScreen);
  //     print('Registration Successful');
  //   }
  // }

  Future<void> onCreateAccount() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: email.text, password: confirmPassword.text);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {}
        GetSnackBar(message: error.message ?? "Registration failed");
      }
    }
  }
}
