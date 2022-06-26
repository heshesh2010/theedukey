import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:theedukey/app/modules/home/bindings/home_binding.dart';

import 'app/core/langs/translations.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/utils/local_storage.dart';
import 'app/modules/splash/views/splash_view.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/route_list.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      getPages: AppPages.routes,
      // showPerformanceOverlay: true,
      title: 'The Edukey',
      locale: Locale(LocalStorage().getlanguageSelected() ?? "ar", ""),
      fallbackLocale: const Locale('ar', 'SA'),
      translations: Translation(),
      initialRoute: RouteList.splashScreen,
      theme: Get.isDarkMode ? ThemeData.dark() : appThemeDataLight,
      home: const SplashView(),
    );
  }
}
