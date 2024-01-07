import 'package:get/get.dart';
import 'package:todo_app/pages/register/register_binding.dart';
import 'package:todo_app/pages/register/register_controller.dart';
import 'package:todo_app/pages/register/register_screen.dart';
import 'package:todo_app/routes/app_page.dart';

class AppPages {
  static final List<GetPage> getPages = [
    GetPage(
        name: AppRoutes.registrationScreen,
        page: () => RegisterScreen(),
        binding: RegisterBinding())
  ];
}
