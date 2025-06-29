
import 'package:flutter/material.dart';

const String baseURL = "https://jsonplaceholder.typicode.com";

// App Colors
class AppColors {
  static const Color primary = Colors.deepPurple;
  static const Color primaryLight = Color(0xFF9575CD);
  static const Color primaryDark = Color(0xFF512DA8);
  
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color textHint = Color(0xFF9E9E9E);
  
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFBDBDBD);
  
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  
  // Additional colors for forms and UI elements
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color greyWithOpacity = Color(0x1A9E9E9E); // grey with 0.1 opacity
  static const Color primaryWithOpacity = Color(0x1A673AB7); // primary with 0.1 opacity
  static const Color red400 = Color(0xFFEF5350);
  static const Color red600 = Color(0xFFE53935);
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}