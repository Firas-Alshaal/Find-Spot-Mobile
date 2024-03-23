import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';

class CurvedLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: LeftClipper(),
      child: Container(
        height: 300.0,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorsFave.primaryColor,
              ColorsFave.secondaryColor,
            ],
          ),
        ),
      ),
    );
  }
}

class LeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(30, size.height, 40, size.height - 40);
    path.quadraticBezierTo(80, 80, size.width - 120, 70);
    path.quadraticBezierTo(size.width, 60, size.width, 0);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
