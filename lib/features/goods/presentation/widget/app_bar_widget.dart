import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final Widget? leading;

  const AppBarWidget({Key? key, required this.title, required this.appBar,this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsFave.primaryColor,
      leading: leading,
      toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      title: Transform.translate(
        offset: const Offset(10, 0),
        child: Text(
          title,
          style: GoogleFonts.roboto(),
        ),
      ).animate().fadeIn(delay: .3.seconds, duration: .2.seconds),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
