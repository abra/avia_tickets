import 'package:flutter/material.dart';

import 'app_colors_ext.dart';
import 'app_text_styles_ext.dart';

class AppTheme {
  static const _baseFontFamily = 'SFProDisplay';
  static const _fontSize10 = 10.0;
  static const _fontSize14 = 14.0;
  static const _fontSize16 = 16.0;
  static const _fontSize20 = 20.0;
  static const _fontSize22 = 22.0;
  static const _lineHeight110 = 1.1;
  static const _lineHeight120 = 1.2;
  static const _lineHeight130 = 1.3;
  static const _fontWeight400 = FontWeight.w400;
  static const _fontWeight500 = FontWeight.w500;
  static const _fontWeight600 = FontWeight.w600;

  static const appColors = AppColorsExt(
    black: Color(0xFF0C0C0C),
    grey1: Color(0xFF1D1E20),
    grey2: Color(0xFF242529),
    grey3: Color(0xFF2F3035),
    grey4: Color(0xFF3E3F43),
    grey5: Color(0xFF5E5F61),
    grey6: Color(0xFF9F9F9F),
    grey7: Color(0xFFDBDBDB),
    white: Color(0xFFFFFFFF),
    blue: Color(0xFF2261BC),
    darkBlue: Color(0xFF00427D),
    green: Color(0xFF3A633B),
    darkGreen: Color(0xFF1E341F),
    red: Color(0xFFFF5E5E),
    orange: Color(0xFFF36E36),
  );

  static const appStyles = AppTextStylesExt(
    title1: TextStyle(
      fontFamily: _baseFontFamily,
      fontWeight: _fontWeight600,
      fontSize: _fontSize22,
      height: _lineHeight120,
    ),
    title2: TextStyle(
      fontFamily: _baseFontFamily,
      fontWeight: _fontWeight600,
      fontSize: _fontSize20,
      height: _lineHeight120,
    ),
    title3: TextStyle(
      fontFamily: _baseFontFamily,
      fontWeight: _fontWeight600,
      fontSize: _fontSize16,
      height: _lineHeight120,
    ),
    title4: TextStyle(
      fontFamily: _baseFontFamily,
      fontWeight: _fontWeight500,
      fontSize: _fontSize14,
      height: _lineHeight120,
    ),
    text1: TextStyle(
      fontFamily: _baseFontFamily,
      fontWeight: _fontWeight400,
      fontSize: _fontSize16,
      height: _lineHeight120,
    ),
    text2: TextStyle(
      fontFamily: _baseFontFamily,
      fontWeight: _fontWeight400,
      fontSize: _fontSize14,
      height: _lineHeight120,
    ),
    buttonText: TextStyle(
      fontFamily: _baseFontFamily,
      fontWeight: _fontWeight600,
      fontSize: _fontSize16,
      height: _lineHeight130,
    ),
    tabText: TextStyle(
      fontFamily: _baseFontFamily,
      fontWeight: _fontWeight500,
      fontSize: _fontSize10,
      height: _lineHeight110,
    ),
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: appColors.black,
    splashColor: Colors.transparent,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      hintStyle: appStyles.buttonText.copyWith(
        color: appColors.grey6,
        fontWeight: FontWeight.w600,
      ),
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
    ),
    textTheme: TextTheme(
      displayLarge: appStyles.title1.copyWith(
        color: appColors.white,
      ),
      displayMedium: appStyles.title2.copyWith(
        color: appColors.white,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      surfaceTintColor: Colors.transparent,
      backgroundColor: appColors.grey2,
      modalBackgroundColor: appColors.grey2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: appColors.black,
      selectedItemColor: appColors.blue,
      unselectedItemColor: appColors.grey6,
      selectedLabelStyle: appStyles.tabText.copyWith(
        color: appColors.blue,
      ),
      unselectedLabelStyle: appStyles.tabText.copyWith(
        color: appColors.grey6,
      ),
    ),
    extensions: [
      appColors,
      appStyles,
    ],
  );
}
