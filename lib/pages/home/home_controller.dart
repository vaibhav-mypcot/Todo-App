import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/routes/app_page.dart';

class HomeController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  var isDark = false.obs;

  final RxMap userData = {}.obs;
  final RxMap userTaskData = {}.obs;
  List userTaskList = [].obs;

  RxBool taskCompleted = false.obs;

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
    getUserData();
    // getUserTaskData();
    fetchData();

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

  // Future<QuerySnapshot> usersTasks = FirebaseFirestore.instance
  //         .collection('task_list')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('notes').get();

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

  //////////////////////
  ///
  final RxList<DocumentSnapshot> notes = <DocumentSnapshot>[].obs;
  Future<void> fetchData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('task_list')
          .doc(userId)
          .collection('notes')
          .get();

      notes.assignAll(querySnapshot.docs);
      print("new data printed: ${notes}");
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void gotoAddNewTaskScreen() {
    Get.toNamed(AppRoutes.addTaskScreen);
  }

  void checkBoxChanged(bool? value, index) async {
    Map<String, dynamic> data = notes[index].data() as Map<String, dynamic>;

    // Now you can access individual fields
    String title = data['task'];
    bool taskCompleted = data['isCompleted'];

    taskCompleted = !taskCompleted;
    SystemSound.play(SystemSoundType.click);
    print("here is your boolean value: ${taskCompleted}${value}");
    // taskCompleted.value = !taskCompleted.value;

    // try to update value in fire store
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid;

      await FirebaseFirestore.instance
          .collection('task_list')
          .doc(userId) // Replace with the actual user ID
          .collection('notes')
          .doc(notes[index]
              .id) // Assuming you have an 'id' property in your documents
          .update({'isCompleted': value});
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }
}
