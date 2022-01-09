import 'package:get/get.dart';

class AuthController extends GetxController {
  var count = 0.obs;
  Rx<dynamic> user = null.obs;
  Rx<String?> token = ''.obs;

  increate() => count++;
  setUser(dynamic data) => user.value = data;
  setToken(String? data) => token.value = data;
}
