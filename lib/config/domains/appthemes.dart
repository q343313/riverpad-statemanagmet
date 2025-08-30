


import 'package:flutter/material.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';

class AppThemes {
  static final ThemeData lightthemedata = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldlightmode,
    brightness: Brightness.light,
    textTheme: TextTheme(bodyLarge: TextStyle(color: AppColors.textlightmode),
      bodyMedium: TextStyle(color: AppColors.textlightmode),
      bodySmall: TextStyle(color: AppColors.textlightmode)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonlightmode,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29))
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldlightmode,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold")
    )
  );

  static final ThemeData darkthemedata = ThemeData(
      scaffoldBackgroundColor: AppColors.scaffolddarkmode,
      brightness: Brightness.dark,
      textTheme: TextTheme(bodyLarge: TextStyle(color: AppColors.textdarkmode),
          bodyMedium: TextStyle(color: AppColors.textdarkmode),
          bodySmall: TextStyle(color: AppColors.textdarkmode)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttondarkmode,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29))
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.scaffolddarkmode,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold")
      )
  );
}