import 'package:base_caller/pages/home_page.dart';
import 'package:base_caller/pages/main_page.dart';
import 'package:base_caller/utils/routes.dart';
import 'package:base_caller/widgets/themes.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

void main() async {
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
  bool darkThemeMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      routes: {
        MyRoutes.welcomeRoute: (context) => MainPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
      },
    );
  }
}
