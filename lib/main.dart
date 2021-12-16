import 'dart:async';

import 'package:base_caller/pages/home_page.dart';
import 'package:base_caller/pages/main_page.dart';
import 'package:base_caller/utils/MySharedPreferences.dart';
import 'package:base_caller/utils/routes.dart';
import 'package:base_caller/widgets/themes.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

bool darkThemeMode = false;
bool isOpenedFirstTime = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  isOpenedFirstTime =
      await MySharedPreferences.instance.getBooleanValue("firstTimeOpen");
  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      initialRoute:
          (isOpenedFirstTime) ? MyRoutes.homeRoute : MyRoutes.welcomeRoute,
      routes: {
        MyRoutes.welcomeRoute: (context) => MainPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
      },
    );
  }
}
