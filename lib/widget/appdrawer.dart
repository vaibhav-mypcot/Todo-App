import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/components/loader.dart';

class AppDrawerWidget extends StatefulWidget {
  AppDrawerWidget({super.key});

  @override
  State<AppDrawerWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawerWidget> {
  bool isLanguageEnabled = false;
  // String selectedLanguage = 'English';
  List<String> languageOptions = ['Hindi', 'English'];
  var isDark = false;

  final controller = Get.find<HomeController>();
  final signinController = Get.find<SigninController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kColorWhite,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              color: kColorPrimary,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(18.w, 26.h, 0.w, 0.h),
              child: Obx(() {
                String firstLetter = controller.userData["first_name"];
                String name = controller.userData["last_name"];
                String email = controller.userData["email"];
                String fullName = "$firstLetter $name";
                var firstChar = firstLetter[0].toUpperCase.toString;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.network(
                        controller.userData["image_url"],
                        fit: BoxFit.cover,
                        height: 40.h,
                        width: 40.h,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      fullName.toString(),
                      style: kTextStyleGabaritoMedium.copyWith(
                          fontSize: 18.sp, color: kColorWhite),
                    ),
                    Text(
                      email.toString(),
                      style: kTextStyleGabaritoRegular.copyWith(
                          fontSize: 14.sp, color: kColorGreyNeutral200),
                    ) //circleAvata
                  ],
                );
              }),
            ),
          ),
          // SizedBox(
          //   height: 60,
          // ),
          ListTile(
            leading: Icon(Icons.language_sharp),
            title: Text('Translate'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return DropdownButton<String>(
                    padding: EdgeInsets.zero,
                    underline: Container(),
                    value: controller.selectedLanguage.value,
                    items: languageOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.setLanguage(newValue!);

                        if (newValue == "Hindi") {
                          var locale = Locale('hi');
                          Get.updateLocale(locale);
                        } else if (newValue == "English") {
                          var locale = Locale('en');
                          Get.updateLocale(locale);
                        }
                      });
                    },
                  );
                }),
              ],
            ),
            onTap: () {
              Get.back(); // Close the drawer
            },
          ),
          Obx(() {
            return ListTile(
              leading: Icon(Icons.dark_mode),
              title: Row(
                children: [
                  const Text('Change Theme'),
                  const Spacer(),
                  Switch(
                    value: controller.isDark.value,
                    onChanged: (state) {
                      controller.changeTheme(state);
                    },
                  ),
                ],
              ),
              onTap: () {
                Get.back(); // Close the drawer
              },
            );
          }),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            onTap: () async {
              Utils.showLoader();
              await FirebaseAuth.instance.signOut();
              signinController.email.clear();
              signinController.password.clear();
              Get.back();
              Get.until((route) => Get.currentRoute == AppRoutes.signinScreen);
            },
          ),
        ],
      ),
    );
  }
}
