import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/components/home_components/empty_screen.dart';
import 'package:todo_app/const/const.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/widget/appdrawer.dart';
import 'package:todo_app/widget/bottom_appbar.dart';
import 'package:todo_app/widget/task_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();

  final signinController = Get.find<SigninController>();

  @override
  Widget build(BuildContext context) {
    CollectionReference querySnapshot = FirebaseFirestore.instance
        .collection('task_list')
        .doc(signinController.auth.currentUser!.uid)
        .collection('notes');

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: querySnapshot.snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData ) {
                  print("data not found");
                  return Center(
                    child: SvgPicture.asset(
                      Const().emptyImg,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          Map data = snapshot.data?.docs[index].data() as Map;
                          String task = data['task'];
                          bool isCompleted = data['isCompleted'];
                          return TaskTile(
                            taskName: task.toString(),
                            taskCompleted: isCompleted,
                            onChanged: (value) =>
                                homeController.checkBoxChanged(value, index),
                                
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
