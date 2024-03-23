import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';

class ButtonApp extends StatelessWidget {
  String text;
  Function onPressed;
  double? width;

  ButtonApp({Key? key, required this.text, required this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsFave.primaryColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.5)),
        ),
        onPressed: () {
          onPressed();
        },
        child: FittedBox(
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: ColorsFave.whiteColor)),
        ),
      ),
    );
  }
}
