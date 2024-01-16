import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/routes/app_page.dart';

class WelcomeController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    final user = auth.currentUser;
    if (user != null) {
      Utils.showLoader();
      await Future.delayed(Duration(seconds: 1));
      Get.toNamed(AppRoutes.homeScreen);
      Get.back();
    } else {
      Utils.showLoader();
      await Future.delayed(Duration(seconds: 1));
      Get.toNamed(AppRoutes.welcomeScreen);
      Get.back();
    }
    super.onInit();
  }
}
