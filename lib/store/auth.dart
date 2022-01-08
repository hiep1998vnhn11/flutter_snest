import 'package:get/get.dart';

class AuthController extends GetxController {
  var count = 0.obs;
  Rx<Map<String, dynamic>?> user = null.obs;
  Rx<String?> token = ''.obs;

  increate() => count++;
  setUser(Map<String, dynamic>? data) => user.update((value) {
        value = data;
      });
  setToken(String? data) => token.update((value) {
        value = data;
      });
}
