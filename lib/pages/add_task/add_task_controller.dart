import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController{
  GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();

  final task = TextEditingController();

  Future<void> onLoginClicked() async {
    if(taskFormKey.currentState!.validate()){
      Get.back();
    }
  }
}