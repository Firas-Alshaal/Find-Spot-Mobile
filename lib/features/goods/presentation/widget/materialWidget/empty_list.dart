import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open,
                size: 60, color: ColorsFave.primaryColor),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'There are no items',
                style: GoogleFonts.lato(fontSize: 20),
              ),
            )
          ]),
    );
  }
}
