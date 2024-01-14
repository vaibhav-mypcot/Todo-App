import 'package:get/get.dart';
import 'package:todo_app/pages/add_task/add_task_binding.dart';
import 'package:todo_app/pages/add_task/add_task_screen.dart';
import 'package:todo_app/pages/create_new_password/create_new_password_binding.dart';
import 'package:todo_app/pages/create_new_password/create_new_password_screen.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_binding.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_screen.dart';
import 'package:todo_app/pages/home/home_binding.dart';
import 'package:todo_app/pages/home/home_screen.dart';
import 'package:todo_app/pages/profile_page/profile_binding.dart';
import 'package:todo_app/pages/profile_page/profile_screen.dart';
import 'package:todo_app/pages/register/register_binding.dart';
import 'package:todo_app/pages/register/register_screen.dart';
import 'package:todo_app/pages/signin/signin_binding.dart';
import 'package:todo_app/pages/signin/signin_screen.dart';
import 'package:todo_app/pages/verify_account/verify_ac_binding.dart';
import 'package:todo_app/pages/verify_account/verify_ac_screen.dart';
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
    GetPage(
      name: AppRoutes.verifyAccountScreen,
      page: () => VerifyAccountScreen(),
      binding: VerifyAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.createNewPasswordScreen,
      page: () => CreateNewPasswordScreen(),
      binding: CreateNewPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
