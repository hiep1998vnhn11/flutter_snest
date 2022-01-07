import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? initialValue;
  final bool enabled;
  final String? hintText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool obscureText;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String?)? onSaved, onChange;
  @override
  // ignore: overridden_fields
  const CustomTextField(
      {Key? key,
      this.initialValue,
      this.enabled = true,
      this.hintText,
      this.textInputType,
      this.controller,
      this.textInputAction,
      this.focusNode,
      this.nextFocusNode,
      this.submitAction,
      this.obscureText = false,
      this.validateFunction,
      this.onSaved,
      this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        onChanged: onChange,
        style: const TextStyle(
          fontSize: 15.0,
        ),
        key: key,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        validator: validateFunction,
        onSaved: onSaved,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: (String term) {
          if (nextFocusNode != null) {
            focusNode?.unfocus();
            FocusScope.of(context).requestFocus(nextFocusNode);
          } else {
            submitAction!();
          }
        },
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            border: border(),
            focusedBorder: border(),
            disabledBorder: border()),
      ),
    );
  }

  border() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Color(0xffB3ABAB),
        width: 1.0,
      ),
    );
  }
}