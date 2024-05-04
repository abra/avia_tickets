import 'package:flutter/material.dart';

typedef AppColorsThemeExt = ThemeExtension<AppColorsTheme>;

class AppColorsTheme extends AppColorsThemeExt {
  static const _black = Color(0xFF0C0C0C);
  static const _grey1 = Color(0xFF1D1E20);
  static const _grey2 = Color(0xFF242529);
  static const _grey3 = Color(0xFF2F3035);
  static const _grey4 = Color(0xFF3E3F43);
  static const _grey5 = Color(0xFF5E5F61);
  static const _grey6 = Color(0xFF9F9F9F);
  static const _grey7 = Color(0xFFDBDBDB);
  static const _white = Color(0xFFFFFFFF);
  static const _blue = Color(0xFF2261BC);
  static const _darkBlue = Color(0xFF00427D);
  static const _green = Color(0xFF3A633B);
  static const _darkGreen = Color(0xFF015905);
  static const _red = Color(0xFFFF5E5E);
  static const _orange = Color(0xFFF36E36);

  final Color black = _black;
  final Color grey1 = _grey1;
  final Color grey2 = _grey2;
  final Color grey3 = _grey3;
  final Color grey4 = _grey4;
  final Color grey5 = _grey5;
  final Color grey6 = _grey6;
  final Color grey7 = _grey7;
  final Color white = _white;
  final Color blue = _blue;
  final Color darkBlue = _darkBlue;
  final Color green = _green;
  final Color darkGreen = _darkGreen;
  final Color red = _red;
  final Color orange = _orange;

  // actual colors used in app
  const AppColorsTheme._internal({
    required Color black,
    required Color grey1,
    required Color grey2,
    required Color grey3,
    required Color grey4,
    required Color grey5,
    required Color grey6,
    required Color grey7,
    required Color white,
    required Color blue,
    required Color darkBlue,
    required Color green,
    required Color darkGreen,
    required Color red,
    required Color orange,
  });

  factory AppColorsTheme.dark() => const AppColorsTheme._internal(
        black: _black,
        grey1: _grey1,
        grey2: _grey2,
        grey3: _grey3,
        grey4: _grey4,
        grey5: _grey5,
        grey6: _grey6,
        grey7: _grey7,
        white: _white,
        blue: _blue,
        darkBlue: _darkBlue,
        green: _green,
        darkGreen: _darkGreen,
        red: _red,
        orange: _orange,
      );

  @override
  AppColorsThemeExt copyWith() {
    return AppColorsTheme.dark();
  }

  @override
  AppColorsThemeExt lerp(covariant AppColorsThemeExt? other, double t) => this;
}
