import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/custom_theme_extension.dart';
import '../utils/app_colors.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    backgroundColor: AppColors.backgroundLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    extensions: [
      CustomThemeExtension.lightMode,
    ],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenLight,
        foregroundColor: AppColors.backgroundLight,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.backgroundLight,
      modalBackgroundColor: AppColors.backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greenLight,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: AppColors.greyLight,
      ),
    ),
  );
}
