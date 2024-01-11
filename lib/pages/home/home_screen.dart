import 'package:audioplayers/audioplayers.dart';
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

  final player = AudioPlayer();

  Future<void> playAudio() async {
    String audioPath = "assets/audio/bubble_click.wav";
    String url =
        "https://codeskulptor-demos.commondatastorage.googleapis.com/pang/pop.mp3";

    await player.play(
      UrlSource(url),
    );

    // await player.play(
    //   AssetSource(audioPath),
    // );
  }

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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          Map data = snapshot.data?.docs[index].data() as Map;
                          String task = data['task'];
                          bool isCompleted = data['isCompleted'];
    
                          QueryDocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          String docID = documentSnapshot.reference.id;
    
                          return Dismissible(
                            key: Key(docID),
                            background: const Card(
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  "Deleted",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              FirebaseFirestore.instance
                                  .collection('task_list')
                                  .doc(signinController.auth.currentUser!.uid)
                                  .collection('notes')
                                  .doc(docID)
                                  .delete();
                            },
                            child: TaskTile(
                                taskName: task.toString(),
                                taskCompleted: isCompleted,
                                onChanged: (value) {
                                  homeController.checkBoxChanged(value, index);
                                  playAudio();
                                }),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(top: 90.h),
                    child: Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            Const().emptyImg,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "What do you want to do today?",
                            style: kTextStyleGabaritoMedium.copyWith(
                                fontSize: 18, color: kColorGreyNeutral600),
                          ),
                          Text(
                            "Tap + to add your task",
                            style: kTextStyleGabaritoMedium.copyWith(
                                fontSize: 16, color: kColorGreyNeutral400),
                          )
                        ],
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
