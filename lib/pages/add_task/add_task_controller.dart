import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/pages/home/home_screen.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:uuid/uuid.dart';

class AddTaskController extends GetxController {
  GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();
  String currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());
  String currentTime = DateFormat.jm().format(DateTime.now());

  final task = TextEditingController();

  Future<void> onAddTaskClicked() async {
    if (taskFormKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String userId = user!.uid;

        var uuid = Uuid();

        // Generate a random unique string
        String randomString = uuid.v4();

        await FirebaseFirestore.instance
            .collection('task_list')
            .doc(userId)
            .collection('notes')
            .doc(randomString)
            .set({
          'task': task.text.toString(),
          'isCompleted': false,
          'date': currentDate,
          'time': currentTime,
        });

        Get.snackbar(
          "Congratulation",
          "Task task added successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          backgroundColor: Colors.white,
        );

        // taskFormKey.currentState!.reset();
        task.clear();
        Get.until((HomeScreen) => false);

        // Get.offAllNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        Get.snackbar(error.message ?? "task added failed", "Please try again",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white);
      }
    }
  }
}
