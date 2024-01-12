import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_controller.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/theme/colors.dart';

class CreateNewPasswordController extends GetxController {
  GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();

  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final email = ForgotPasswordController.verifyEmail;

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  void onResetPasswordClick() {
    if (newPasswordFormKey.currentState!.validate()) {
      Get.snackbar(
        'Congratulation',
        'You enetred valid otp',
        colorText: kColorPrimary,
      );
    }
    chnagePassword(ForgotPasswordController.verifyEmail.text.toString());

    // getPassword(ForgotPasswordController.verifyEmail.text.toString());
  }

  void chnagePassword(String enteredEmail) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    String? storedPassword;

    try {
      // Query the users collection to get the document with the entered email
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: enteredEmail).get();

      // Check if a document with the entered email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Extract the first document (assuming email is unique) and get the password
        storedPassword = querySnapshot.docs.first.get('password');
        print("your password is: $storedPassword");
      } else {
        //
        print("No user found with the entered email");
      }
    } catch (e) {
      print('Error authenticating user: $e');
    }

    print("This is your email: ${enteredEmail} ");
    print("This is your password: ${storedPassword} ");

    // var cred = EmailAuthProvider.credential(email: email, password: password)
  }

  // void getPassword(String enteredEmail) async {
  //   final CollectionReference usersCollection =
  //       FirebaseFirestore.instance.collection('users');

  //   QuerySnapshot querySnapshot =
  //       await usersCollection.where('email', isEqualTo: enteredEmail).get();

  //   print("Here is your email :$querySnapshot");
  // }
}
