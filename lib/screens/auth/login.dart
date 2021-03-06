// import 'dart:convert';
// import 'dart:io';
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:snest/util/animations.dart';
import 'package:snest/util/const.dart';
import 'package:snest/util/enum.dart';
import 'package:snest/util/router.dart';
import 'package:snest/util/validations.dart';
import 'package:snest/home.dart';
import 'package:snest/widgets/custom_button.dart';
import 'package:snest/widgets/custom_text_field.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snest/util/http.dart';
import 'package:get/get.dart';
import 'package:snest/store/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  bool validate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String email, password, name = '';
  FocusNode nameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  FormMode formMode = FormMode.login;
  AuthController authController = Get.put(AuthController());

  Future<bool> ayncLogin() async {
    try {
      Map<String, dynamic> data = await HttpService.post('/auth/login', {
        'email': email,
        'password': password,
      });
      final String token = data['access_token'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      authController.setToken(token);
      var user = await HttpService.post('/auth/me');
      // authController.setUser(user);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  submit() async {
    try {
      setState(() {
        loading = true;
      });
      FormState? form = formKey.currentState;
      form?.save();
      if (!form!.validate()) {
        setState(() {
          validate = true;
        });
        return toastError('H??y ??i???n ?????y ????? th??ng tin!');
      }
      final bool isLogin = await ayncLogin();
      if (isLogin) {
        Navigate.pushPageReplacement(context, const Home());
      } else {
        return toastError('Th??ng tin ????ng nh???p kh??ng ch??nh x??c!');
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void toastError(String value) {
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: [
          buildLottieContainer(),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: buildFormContainer(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildLottieContainer() {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      width: screenWidth < 700 ? 0 : screenWidth * 0.5,
      duration: const Duration(milliseconds: 500),
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      child: Center(
        child: Lottie.asset(
          AppAnimations.chatAnimation,
          height: 400,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  buildFormContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Image(
          image: AssetImage('images/facebook.png'),
          width: 100,
        ),
        Text(
          Constants.appName,
          style: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 70.0),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: buildForm(),
        ),
        Visibility(
          visible: formMode == FormMode.login,
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      formMode = FormMode.forgorPassword;
                    });
                  },
                  child: const Text('Qu??n m???t kh???u?',
                      style: TextStyle(color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        buildButton(),
        Visibility(
          visible: formMode == FormMode.login,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('B???n ch??a c?? t??i kho???n?'),
              TextButton(
                onPressed: () {
                  setState(() {
                    formMode = FormMode.register;
                  });
                },
                child: const Text('????ng k?? ngay',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
        Visibility(
          visible: formMode != FormMode.login,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('???? c?? t??i kho???n?'),
              TextButton(
                onPressed: () {
                  setState(() {
                    formMode = FormMode.login;
                  });
                },
                child: const Text('????ng nh???p',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        formMode == FormMode.register
            ? Column(
                children: [
                  CustomTextField(
                    enabled: !loading,
                    hintText: "T??n c???a b???n",
                    textInputAction: TextInputAction.next,
                    validateFunction: Validations.validateName,
                    onSaved: (String? val) {
                      name = val ?? '';
                    },
                    focusNode: nameFN,
                    nextFocusNode: emailFN,
                  ),
                  const SizedBox(height: 20.0),
                ],
              )
            : const SizedBox(height: 0.0),
        CustomTextField(
          enabled: !loading,
          hintText: "T??i kho???n",
          textInputAction: TextInputAction.next,
          onSaved: (String? val) {
            email = val ?? '';
          },
          focusNode: emailFN,
          nextFocusNode: passFN,
        ),
        formMode != FormMode.forgorPassword
            ? Column(
                children: [
                  const SizedBox(height: 20.0),
                  CustomTextField(
                    enabled: !loading,
                    hintText: "M???t kh???u",
                    textInputAction: TextInputAction.done,
                    validateFunction: Validations.validatePassword,
                    submitAction: submit,
                    obscureText: true,
                    onSaved: (String? val) {
                      password = val ?? '';
                    },
                    focusNode: passFN,
                  ),
                ],
              )
            : const SizedBox(height: 0.0)
      ],
    );
  }

  buildButton() {
    return CustomButton(
      label: getButtonName(),
      onPressed: submit,
      loading: loading,
    );
  }

  getButtonName() {
    if (formMode == FormMode.login) {
      return "????ng nh???p";
    } else if (formMode == FormMode.register) {
      return "????ng k??";
    } else if (formMode == FormMode.forgorPassword) {
      return "L???y l???i m???t kh???u";
    }
    return "";
  }
}
