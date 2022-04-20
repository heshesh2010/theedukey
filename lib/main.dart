import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/modules/auth/bindings/auth_binding.dart';
import 'package:theedukey/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:theedukey/app/modules/language/bindings/language_binding.dart';
import 'package:theedukey/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:theedukey/app/modules/splash/bindings/splash_binding.dart';
import 'package:theedukey/config/app_config.dart' as config;
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/modules/auth/views/auth_view.dart';
import 'app/modules/contact_us/controllers/contact_us_controller.dart';
import 'app/modules/contact_us/views/contact_us_view.dart';
import 'app/modules/edit_profile/views/edit_profile_view.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/language/views/language_view.dart';
import 'app/modules/notifications/views/notifications_view.dart';
import 'app/modules/splash/views/splash_view.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'core/langs/translations.dart';
import 'core/values/constants/route_list.dart';

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
      getPages: [
        GetPage(
            name: '/',
            page: () => const SplashView(),
            binding: SplashBinding()),
        GetPage(name: '/home', page: () => HomeView(), binding: HomeBinding()),
        GetPage(name: '/auth', page: () => AuthView(), binding: AuthBinding()),
        GetPage(
          name: RouteList.contactUs,
          page: () => ContactUsView(),
          binding: BindingsBuilder(() {
            Get.lazyPut<ContactUsController>(() => ContactUsController());
          }),
        ),
        GetPage(
            name: '/edit-profile',
            page: () => EditProfileView(),
            binding: EditProfileBinding()),
        GetPage(
            name: '/LanguageView',
            page: () => LanguageView(),
            binding: LanguageBinding()),
        GetPage(
            name: '/notifications',
            page: () => const NotificationsView(),
            binding: NotificationsBinding()),
      ],
      title: 'The Edukey',
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ar', 'SA'),
      translations: Translation(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Color(0xFF076996)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xEEEEEEEE)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF076996)),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(const Color(0xFF19BAB2)),
          splashRadius: 15,
          fillColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.grey),
          side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(color: Color(0xEEEEEEEE))),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        primaryColor: config.AppColors().mainColor(1),
        focusColor: config.AppColors().secondColor(1), // black
        //   hintColor: config.AppColors().mainColor(1), //
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black),
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(
              headline1: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: config.AppColors().mainColor(1)),
              headline5: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: config.AppColors().mainColor(1)),
            )
            .apply(
              fontFamily: 'Jannat',
            ),

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashView(),
    );
  }
}
