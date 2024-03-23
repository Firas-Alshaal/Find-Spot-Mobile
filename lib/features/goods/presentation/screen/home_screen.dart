import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/network/authrization.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/main_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsFave.whiteColor,
        appBar: AppBar(
          backgroundColor: ColorsFave.primaryColor,
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          title: Transform.translate(
            offset: const Offset(10, 0),
            child: Text(
              'Lost & Found',
              style: GoogleFonts.roboto(),
            ),
          ).animate().fadeIn(delay: .3.seconds, duration: .2.seconds),
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: GridDashboard());
  }
}
