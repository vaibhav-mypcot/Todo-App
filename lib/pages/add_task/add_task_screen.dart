import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/add_task/add_task_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';

class AddTaskScreen extends StatelessWidget with ValidationsMixin {
  AddTaskScreen({super.key});

  final taskController = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: taskController.taskFormKey,
            child: Column(
              children: [
                 CustomAppbar(press: () => Get.back(),),

                // Task form
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  child: Row(
                    children: [
                      // First Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add your task',
                              style: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorBlackNeutral800,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextField(
                              controller: taskController.task,
                              hintText: 'Enter your task',
                              hintStyle: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorGreyNeutral400,
                              ),
                              radius: 8,
                              style: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorGreyNeutral600,
                              ),
                              textInputType: TextInputType.emailAddress,
                              validator: validateTask,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 150.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomButton(
                    label: "Add Task",
                    press: () => taskController.onAddTaskClicked(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
