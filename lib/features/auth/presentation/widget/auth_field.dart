import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final IconData icon;
  final String text;
  final bool? isPassword;
  final List<TextInputFormatter>? textInputFormatter;

  const AuthTextFieldItem(
      {Key? key,
      required this.controller,
      this.isPassword,
      this.textInputFormatter,
      required this.icon,
      required this.text,
      required this.textInputType,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextFormField(
        style: const TextStyle(fontSize: 22.0),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: textInputFormatter,
        controller: controller,
        keyboardType: textInputType,
        obscureText: isPassword == null ? false : isPassword!,
        validator: validator,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: -1, fontSize: 0),
          errorText: null,
          errorBorder: InputBorder.none,
          error: null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          icon: Icon(
            icon,
            size: 26.0,
          ),
          hintText: text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
