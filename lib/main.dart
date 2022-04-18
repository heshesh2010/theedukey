import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/config/app_config.dart' as config;
import 'package:theedukey/screens/splash_screen.dart';
import 'package:theedukey/utils/langs/translations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'binding.dart';

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
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ar', 'SA'),
      translations: Translation(),
      title: 'The edu key',
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
      home: const SplashScreen(),
    );
  }
}
