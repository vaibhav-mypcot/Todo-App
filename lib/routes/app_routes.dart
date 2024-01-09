import 'package:get/get.dart';
import 'package:todo_app/pages/add_task/add_task_binding.dart';
import 'package:todo_app/pages/add_task/add_task_screen.dart';
import 'package:todo_app/pages/home/home_binding.dart';
import 'package:todo_app/pages/home/home_screen.dart';
import 'package:todo_app/pages/register/register_binding.dart';

import 'package:todo_app/pages/register/register_screen.dart';
import 'package:todo_app/pages/signin/signin_binding.dart';
import 'package:todo_app/pages/signin/signin_screen.dart';
import 'package:todo_app/routes/app_page.dart';

class AppPages {
  static final List<GetPage> getPages = [
    GetPage(
      name: AppRoutes.registrationScreen,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.signinScreen,
      page: () => SigninScreen(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.addTaskScreen,
      page: () => AddTaskScreen(),
      binding: AddTaskBinding(),
    ),
  ];
}
