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
        primarySwatch: const MaterialColor(0xFFFFFFFF, {
          50: Color(0xFFFFFFEE),
          100: Color(0xFFFFEEFF),
          200: Color(0xFFFEEEFF),
          300: Color(0xFFEEEEEE),
          400: Color(0xFFFFFFFF),
          500: Color(0xFFFFFFFF),
          600: Color(0xFFFEEEFF),
          700: Color(0xFFFEEEFF),
          800: Color(0xFFFEEEFF),
          900: Color(0xFFFFFFFF),
        }),
        primaryColor: const Color(0x22222222),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
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
