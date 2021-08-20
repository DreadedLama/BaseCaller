import 'package:base_caller/pages/main_page.dart';
import 'package:base_caller/utils/routes.dart';
import 'package:base_caller/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:base_caller/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyApp> {
  bool darkThemeMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: MyTheme.darkThemeMode,
      darkTheme: MyTheme.darkTheme,
      routes: {
        MyRoutes.welcomeRoute: (context) => HomePage(),
        MyRoutes.homeRoute: (context) => MainPage().build(context),
      },
    );
  }
}

// //Get root permission
// Future<int> initRootRequest() async {
//   bool rootAccess = await RootAccess.requestRootAccess;
//   print('rootstatus - '+rootAccess.toString());
//   return readCounter();
// }
//
// Future<File> get _authFile async {
//   print('return truecaller');
//   // return File('/data/data/com.truecaller/files/account.v2.bak');
//   return File('/storage/emulated/0/data/Truecaller.json');
// }
//
// Future<int> readCounter() async {
//   try {
//     print('reading file');
//     final file = await _authFile;
//     print('Got the file');
//     final contents = await file.readAsString(); // Read the file
//     print('contents = '+contents);
//     return int.parse(contents);
//   } catch (e) {
//     print(e);
//     return 0; // If encountering an error, return 0
//   }
// }
