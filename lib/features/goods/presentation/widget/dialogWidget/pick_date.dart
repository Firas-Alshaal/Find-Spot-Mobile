import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lost_find_tracker/core/utils/theme_color.dart';

Future pickDateProject(BuildContext context) async {
  DateTime selectedDateTime = DateTime.now();
  final initialDate = DateTime.now();
  final newDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 10),
    lastDate: initialDate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: ColorsFave.primaryColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: ColorsFave.primaryColor, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (newDate == null) return;
  if (!context.mounted) return;
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedDateTime),
  );
  if (pickedTime != null) {
    selectedDateTime = DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  return intl.DateFormat.yMd().add_Hm().format(selectedDateTime);
}

String convertDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  String formattedDateTime = intl.DateFormat('d/M/yyyy hh:mm').format(dateTime);

  return formattedDateTime;
}
