import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle h1(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge!;
  }

  static TextStyle h2(BuildContext context) {
    return Theme.of(context).textTheme.displayMedium!;
  }

  static TextStyle h3(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!;
  }

  static TextStyle bodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle menuItem(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
  }

  static TextStyle price(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );
  }

  static TextStyle button(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
  }
}