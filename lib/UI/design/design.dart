import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF5669FF);
  static const Color txt_light = Color(0xFF1C1C1C);
  static const Color txt_dark = Color(0xFFF4EBDC);
  static const Color bg_light = Color(0xFFF2FEFF);
  static const Color bg_dark = Color(0xFF101127);
  static const Color sub_txt_light = Color(0xFF7B7B7B);
  static const Color sub_txt_dark = Color(0xFFF4EBDC);
}

class AppImages {
  static const String logo = "assets/images/app_logo.png";
  static const String onboarding_1 = "assets/images/onboarding_1.png";
  static const String gaming = "assets/images/Gaming.jpg";
  static const String birthday = "assets/images/Birthday.jpg";
  static const String sports = "assets/images/Sport.jpg";
  static const String workshop = "assets/images/Workshop.jpg";
}

class AppIcons {
  // static const String ic_quran = "assets/icons/quran.svg";
}

class AppTheme {
  static var lightTheme = ThemeData(
    colorScheme: ColorScheme.light(primary: AppColors.primary),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.jockeyOne(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
      titleMedium: GoogleFonts.jockeyOne(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.txt_light,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primary,
      selectedItemColor: AppColors.bg_light,
      selectedIconTheme: IconThemeData(color: AppColors.bg_light, size: 24),
      unselectedItemColor: AppColors.bg_light,
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.primary),

    scaffoldBackgroundColor: AppColors.bg_light,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.bg_light,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: TextStyle(
          color: AppColors.bg_light,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    appBarTheme: AppBarTheme(
      elevation: 3,
      backgroundColor: AppColors.bg_light,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      centerTitle: true,
    ),

      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.bg_light,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.sub_txt_light,
              width: 1,
            ),
          ),
          labelStyle: TextStyle(
            color: AppColors.sub_txt_light,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIconColor: AppColors.sub_txt_light,
          suffixIconColor: AppColors.sub_txt_light,

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.5,
            ),

          )

      )
  );

  static var darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(primary: AppColors.primary),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.jockeyOne(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
      titleMedium: GoogleFonts.jockeyOne(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
      bodyMedium: GoogleFonts.jockeyOne(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.txt_dark,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primary,
      selectedItemColor: AppColors.bg_light,
      selectedIconTheme: IconThemeData(color: AppColors.bg_light, size: 24),
      unselectedItemColor: AppColors.bg_light,
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.primary),

    scaffoldBackgroundColor: AppColors.bg_dark,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.bg_light,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: TextStyle(
          color: AppColors.bg_light,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    appBarTheme: AppBarTheme(
      elevation: 3,
      backgroundColor: AppColors.bg_dark,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      centerTitle: true,
    ),

      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.bg_dark,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.sub_txt_dark,
              width: 1,
            ),
          ),
          labelStyle: TextStyle(
            color: AppColors.sub_txt_dark,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIconColor: AppColors.sub_txt_dark,
          suffixIconColor: AppColors.sub_txt_dark,

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.5,
            ),

          )

      )
  );
}
