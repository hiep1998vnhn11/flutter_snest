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
  FormMode formMode = FormMode.LOGIN;

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
        toastError('Hãy điền đầy đủ thông tin!');
      } else {
        Navigate.pushPageReplacement(context, const Home());
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
      color: Theme.of(context).accentColor.withOpacity(0.3),
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
          visible: formMode == FormMode.LOGIN,
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      formMode = FormMode.FORGOT_PASSWORD;
                    });
                  },
                  child: const Text('Quên mật khẩu?',
                      style: TextStyle(color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        buildButton(),
        Visibility(
          visible: formMode == FormMode.LOGIN,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bạn chưa có tài khoản?'),
              FlatButton(
                onPressed: () {
                  setState(() {
                    formMode = FormMode.REGISTER;
                  });
                },
                child: const Text('Đăng ký ngay',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
        Visibility(
          visible: formMode != FormMode.LOGIN,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Đã có tài khoản?'),
              FlatButton(
                onPressed: () {
                  setState(() {
                    formMode = FormMode.LOGIN;
                  });
                },
                child: const Text('Đăng nhập',
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
        formMode == FormMode.REGISTER
            ? Column(
                children: [
                  CustomTextField(
                    enabled: !loading,
                    hintText: "Tên của bạn",
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
          hintText: "Email",
          textInputAction: TextInputAction.next,
          validateFunction: Validations.validateEmail,
          onSaved: (String? val) {
            email = val ?? '';
          },
          focusNode: emailFN,
          nextFocusNode: passFN,
        ),
        formMode != FormMode.FORGOT_PASSWORD
            ? Column(
                children: [
                  const SizedBox(height: 20.0),
                  CustomTextField(
                    enabled: !loading,
                    hintText: "Mật khẩu",
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
    return loading
        ? const Center(child: CircularProgressIndicator())
        : CustomButton(
            label: getButtonName(),
            onPressed: submit,
          );
  }

  getButtonName() {
    if (formMode == FormMode.LOGIN) {
      return "Đăng nhập";
    } else if (formMode == FormMode.REGISTER) {
      return "Đăng ký";
    } else if (formMode == FormMode.FORGOT_PASSWORD) {
      return "Lấy lại mật khẩu";
    }
    return "";
  }
}
