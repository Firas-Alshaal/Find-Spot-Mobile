import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';

class TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final GestureTapCallback? onTap;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final IconData icon;
  final bool? readOnly;

  const TextFieldItem(
      {Key? key,
      required this.controller,
      required this.icon,
      this.onTap,
      this.readOnly,
      required this.labelText,
      required this.textInputType,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: textInputType,
        readOnly: readOnly == null ? false : readOnly!,
        onTap: onTap,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsFave.blackColor, width: 1.0)),
          border: const OutlineInputBorder(borderSide: BorderSide()),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(icon),
          labelText: labelText,
        ),
      ),
    );
  }
}
