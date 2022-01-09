import 'package:flutter/material.dart';
// import 'package:snest/home.dart';
// import 'package:snest/screens/auth/login.dart';
import 'package:snest/app.dart';
import 'package:get/get.dart';
// import 'package:snest/screens/test.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Snest',
      theme: ThemeData(
          brightness: Brightness.light,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          secondaryHeaderColor: Colors.red),
      themeMode: ThemeMode.light,
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}
