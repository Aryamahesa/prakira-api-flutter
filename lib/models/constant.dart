import 'package:flutter/material.dart';

class Constant {
  final Color primaryColor = const Color(0xFF103783);
  final Color secondaryColor = const Color(0xFF9BAFD9);
  final Color thirdColor = const Color.fromARGB(255, 108, 148, 230);
  final Color getStartbuttonColor = const Color(0xFFFFC107);
  final Color barColor = const Color(0xFFFFFFFF);
  final Color textColor = const Color(0XFFFFFFFF);

  // Getter untuk dekorasi background get started page
  BoxDecoration get getStartedBgDecoration => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [primaryColor, thirdColor, primaryColor],
      stops: const [0.0, 0.5, 1.0],
    ),
  );

  // Getter untuk dekorasi background weather page
  BoxDecoration get menuPageBgDecoration => const BoxDecoration(
    gradient: RadialGradient(
      center: Alignment.center,
      radius: 1.11,
      colors: [Color(0xFF103783), Color(0xFF9BAFD9)],
    ),
  );

  BoxDecoration get weatherCardDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );
}
