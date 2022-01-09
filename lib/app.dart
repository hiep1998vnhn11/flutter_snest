import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snest/store/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snest/home.dart';
import 'package:snest/screens/auth/login.dart';
import 'package:snest/util/http.dart';

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  MyApp({Key? key}) : super(key: key);

  Future<Map<String, dynamic>?> _getUser() async {
    try {
      final Map<String, dynamic> user = await HttpService.post('/auth/me');
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<String> _calculation() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      authController.setToken(token);
      if (authController.user.value == null) {
        Map<String, dynamic> user = await HttpService.post('/auth/me');
        // print(user);
        authController.setUser(user);
        print(authController.user.value);
      }
    }
    return token ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return snapshot.data != '' ? const Home() : const Login();
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Đang chuẩn bị dữ liệu',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              )
            ];
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
