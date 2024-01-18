import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/localization/localization_data.dart';
import 'package:todo_app/pages/welcome_page/welcome_binding.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/routes/app_routes.dart';
import 'package:todo_app/storage/local_storage.dart';
import 'package:todo_app/theme/colors.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  String? getLang() {
    return lang.read('lang');
  }

  @override
  Widget build(BuildContext context) {
    String? savedLang = getLang();

    // If the saved language is not null, update the app's locale
    if (savedLang != null) {
      Locale locale = Locale(savedLang);
      Get.updateLocale(locale);
    }
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      child: GetMaterialApp(
        title: 'Flutter Demo',
        translations: Languages(),
        locale: Locale(savedLang ?? 'en'),
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.streamBuilderPage,
        getPages: AppPages.getPages,
        initialBinding: WelcomeBindings(),
        theme: ThemeData(
          primaryColor: kColorPrimary,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
      ),
    );
  }
}
