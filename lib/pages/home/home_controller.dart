import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/register/register_controller.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';

class HomeController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  var isDark = false.obs;

  final RxMap userData = {}.obs;

  RxBool hasInternet = true.obs;

  RxDouble width = 200.0.obs;
  RxDouble height = 50.0.obs;

  String? unique_id = RegisterController.uniqueId;

  void toggleSize() {
    // Change the width and height
    width.value = width.value == 200.0 ? 250.0 : 200.0;
    height.value = height.value == 50.0 ? 100.0 : 50.0;
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();

    // Retrieve the selected language from GetStorage when the controller is initialized
    // selectedLanguage.value = box.read('language') ?? 'English';
  }

  void setLanguage(String language) {
    selectedLanguage.value = language;
    // languageBox.write('language', language);
  }

  void changeTheme(state) {
    if (state == true) {
      isDark.value = true;
      Get.changeTheme(ThemeData.dark());
    } else {
      isDark.value = false;
      Get.changeTheme(ThemeData.light());
    }
  }

  // retrive userdata from firestore
  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        // User data exists, return it as a Map
        userData.value = userSnapshot.data() as Map<String, dynamic>;

      } else {
        // User data doesn't exist
        print("User data not found in Firestore");
        userData.value = {};
      }
    } catch (e) {
      print("Error retrieving user data from Firestore: $e");
      userData.value = {};
    }
  }  

  // Bottom Sheet

  
}
