import 'package:get/get.dart';

class AuthController extends GetxController {
  var count = 0.obs;
  Rx<Map<String, dynamic>> user = Rx<Map<String, dynamic>>({});
  Rx<String?> token = ''.obs;

  increate() => count++;
  setUser(Map<String, dynamic> data) => user.value = data;
  setToken(String data) => token.value = data;
}
