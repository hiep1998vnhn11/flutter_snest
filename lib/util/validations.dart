class Validations {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Hãy nhập tên của bạn.';
    final RegExp nameExp = RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Tên của bạn không được chứa ký tự đặc biệt!';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Hãy nhập email của bạn.';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,2"
        r"53}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-z"
        r"A-Z0-9])?)*$");
    if (!nameExp.hasMatch(value)) return 'Email không hợp lệ';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự.';
    }
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // RegExp passwordExp = RegExp(pattern);
    // if (!passwordExp.hasMatch(value)) {
    //   return 'Mật khẩu phải có ít nhất một ký tự đặc biệt, một chữ hoa, một chữ thường và một số.';
    // }
    return null;
  }
}
