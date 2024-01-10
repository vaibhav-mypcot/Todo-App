import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/home_components/empty_screen.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/widget/appdrawer.dart';
import 'package:todo_app/widget/bottom_appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      bottomNavigationBar: BottomAppbarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeController.gotoAddNewTaskScreen();
          print("length of list: ${homeController.userTaskData.length}");
        },
        backgroundColor: kColorPrimary,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: kColorWhite,
          size: 24.h,
        ),
      ),
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
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 75.h),
              // Show this screen when there is no task

              homeController.userTaskList.isEmpty
                  ? const EmptyScreen()
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: homeController.userTaskList.length,
                      itemBuilder: (context, index) {
                        // Access individual document fields using documents[index].data()

                        // Display data in ListTile or any other widget
                        print(
                            "${homeController.userTaskList[index].toString()}");
                        return ListTile(
                          title: Text(
                              homeController.userTaskList[index].toString()),
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
