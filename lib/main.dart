import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'app/core/langs/translations.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/utils/local_storage.dart';
import 'app/data/service/locator.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/splash/views/splash_view.dart';
import 'app/providers.dart/firebase_provider.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';
import 'app/services/settngs_service.dart';

void initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  // await Get.putAsync(() => GlobalService().init());

  await Firebase.initializeApp();

  // await Firebase.initializeApp();
  // await Get.putAsync(() => AuthService().init());
  // await Get.putAsync(() => LaravelApiClient().init());
  await Get.putAsync(() => FirebaseProvider().init());
  // await Get.putAsync(() => SettingsService().init());
  // await Get.putAsync(() => TranslationService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => SettingsService().init());
  Get.log('All services started...');
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  initServices();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupLocator();
  await GetStorage.init();
  runApp(Sizer(
    builder: (context, orientation, deviceType) {
      return const MyApp();
    },
  ));
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
      initialRoute: Routes.splashScreen,
      theme: Get.isDarkMode ? ThemeData.dark() : appThemeDataLight,
      home: const SplashView(),
    );
  }
}
