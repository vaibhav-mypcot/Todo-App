import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/localization/localization_data.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_binding.dart';
import 'package:todo_app/pages/signin/signin_binding.dart';
import 'package:todo_app/pages/verify_account/verify_ac_binding.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/routes/app_routes.dart';
import 'package:todo_app/theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      child: GetMaterialApp(
        title: 'Flutter Demo',
        translations: Languages(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.signinScreen,
        getPages: AppPages.getPages,
        initialBinding: SigninBinding(),
        theme: ThemeData(
          primaryColor: kColorPrimary,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
      ),
    );
  }
}
