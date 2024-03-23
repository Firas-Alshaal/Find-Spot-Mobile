// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {
  final Widget? child;

  const DismissKeyboard({this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}