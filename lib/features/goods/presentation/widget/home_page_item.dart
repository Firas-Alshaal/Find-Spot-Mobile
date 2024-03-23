import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/homeItem.dart';

class MainSectionWidget extends StatelessWidget {
  final Items data;

  const MainSectionWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, data.route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
            color: ColorsFave.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              data.img,
              width: 60,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              data.title,
              style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ).animate().scale(delay: .3.seconds, duration: .2.seconds),
    );
  }
}
