import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryYellow = Color(0xFFFFD700); // Mobile screen
  static const Color primaryBlue = Color(0xFF004D99);   // "SHOPPING" gradient base
  static const Color primaryLightBlue = Color(0xFF0099FF); // "SHOPPING" highlight

  // Text & Shadow
  static const Color textGray = Color(0xFFD3D3D3);     // "ONLINE" text
  static const Color shadowGray = Color(0xFF333333);   // Text shadow/depth

  // Cart
  static const Color cartWhite = Color(0xFFFFFFFF);
  static const Color cartRed = Color(0xFFD32F2F);
  static const Color cartBlack = Color(0xFF000000);

  // Boxes
  static const Color boxBrown = Color(0xFFA67C52); // Cardboard box color
}

class AppTextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryBlue,
  );

  static const TextStyle subHeadline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryLightBlue,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.shadowGray,
  );

  static const TextStyle whiteText = TextStyle(
    fontSize: 16,
    color: AppColors.cartWhite,
  );

  static const TextStyle yellowText = TextStyle(
    fontSize: 16,
    color: AppColors.primaryYellow,
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryYellow,
    // scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryYellow,
      foregroundColor: AppColors.cartBlack,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.primaryBlue,
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headline,
      titleLarge: AppTextStyles.subHeadline,
      bodyMedium: AppTextStyles.body,
    ),
  );
}
