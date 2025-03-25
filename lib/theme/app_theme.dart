import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4373E5);
  static const Color secondaryColor = Color(0xFF4FCCF9);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF333333);
  static const Color subtextColor = Color(0xFF737373);
  static const Color dividerColor = Color(0xFFEEEEEE);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: cardColor,
      background: backgroundColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: primaryColor,
      unselectedLabelColor: subtextColor,
      indicatorColor: primaryColor,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: textColor),
      bodyMedium: TextStyle(fontSize: 14, color: textColor),
      bodySmall: TextStyle(fontSize: 12, color: subtextColor),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 1,
      space: 1,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: subtextColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
