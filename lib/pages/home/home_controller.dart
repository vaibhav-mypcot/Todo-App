import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  var isDark = false.obs;

  RxBool hasInternet = true.obs;

  RxDouble width = 200.0.obs;
  RxDouble height = 50.0.obs;

  void toggleSize() {
    // Change the width and height
    width.value = width.value == 200.0 ? 250.0 : 200.0;
    height.value = height.value == 50.0 ? 100.0 : 50.0;
  }

  @override
  void onInit() {
    super.onInit();

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

  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        // User data exists, return it as a Map
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        // User data doesn't exist
        print("User data not found in Firestore");
        return {};
      }
    } catch (e) {
      print("Error retrieving user data from Firestore: $e");
      return {};
    }
  }

  //

  RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;

  Future<void> fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      dataList.assignAll(querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) {
        return document.data()!;
      }).toList());
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
