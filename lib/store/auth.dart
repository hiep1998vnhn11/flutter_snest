import 'package:get/get.dart';

class AuthController extends GetxController {
  var count = 0.obs;
  var user = null.obs as Map<String, String>?;
  var token = null.obs as String?;

  increate() => count++;
  setUser(Map<String, String>? data) => user = data;
  setToken(String? data) => token = data;
}
