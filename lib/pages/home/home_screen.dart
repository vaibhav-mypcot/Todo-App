import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/home_components/empty_screen.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/widget/appdrawer.dart';
import 'package:todo_app/widget/bottom_appbar.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();

  void _showModelBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext  context) {
      return Container(
        height: 100,
        color: Colors.redAccent,
       child: Column(
        children: [
          CustomTextField(
            hintText: 'Enter your task',
            hintStyle: kTextStyleGabaritoRegular.copyWith(fontSize: 14, color: kColorGreyNeutral200,),
          ),
        ],
       ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        title: Text(
          'Index',
          style: kTextStyleGabaritoMedium.copyWith(
            fontSize: 21,
            color: kColorBlackNeutral800,
          ),
        ),
        centerTitle: true,
        backgroundColor: kColorWhite,
      ),
      drawer: AppDrawerWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 75.h),
              // Show this screen when there is no task
              const EmptyScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppbarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addTaskScreen),
        backgroundColor: kColorPrimary,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: kColorWhite,
          size: 24.h,
        ),
      ),
    );
  }
}
