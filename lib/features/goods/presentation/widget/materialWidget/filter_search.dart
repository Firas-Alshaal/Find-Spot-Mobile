import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';

class FilterButton extends StatelessWidget {
  final GestureTapCallback onTap;

  final ItemType selectedButton;
  final ItemType buttonType;

  const FilterButton(
      {Key? key,
      required this.onTap,
      required this.selectedButton,
      required this.buttonType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: selectedButton == buttonType ? ColorsFave.buttonColor : null,
            border: Border.all(),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              buttonType.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(),
            ),
          ),
        ),
      ),
    );
  }
}
