import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController{
  GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();
  final taskList = [];

  final task = TextEditingController();

 
  Future<void> onAddTaskClicked() async {
    if(taskFormKey.currentState!.validate()){
     try {
       User? user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid;
      taskList.add(task.text.toString());
      
       await FirebaseFirestore.instance
            .collection('task_list').doc(userId).update({
              'task' : FieldValue.arrayUnion(taskList),
            });

       Get.snackbar(
          "Congratulation",
          "Account task added successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          backgroundColor: Colors.white,
        );
            
     } on FirebaseAuthException catch (error) {
       Get.snackbar(error.message ?? "task added failed", "Please try again",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white);
     }
    }
  }
}