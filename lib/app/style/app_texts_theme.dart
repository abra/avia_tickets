import 'package:flutter/material.dart';

typedef AppTextThemeExt = ThemeExtension<AppTextsTheme>;

class AppTextsTheme extends AppTextThemeExt {
  static const _baseFontFamily = 'SFProDisplay';

  final TextStyle title1;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle title4;
  final TextStyle text1;
  final TextStyle text2;
  final TextStyle buttonText1;
  final TextStyle tabText;

  const AppTextsTheme._internal({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.text1,
    required this.text2,
    required this.buttonText1,
    required this.tabText,
  });

  factory AppTextsTheme.main() => const AppTextsTheme._internal(
        title1: TextStyle(
          fontFamily: _baseFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 22,
          height: 1.2,
        ),
        title2: TextStyle(
          fontFamily: _baseFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          height: 1.2,
        ),
        title3: TextStyle(
          fontFamily: _baseFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.2,
        ),
        title4: TextStyle(
          fontFamily: _baseFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.2,
        ),
        text1: TextStyle(
          fontFamily: _baseFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.2,
        ),
        text2: TextStyle(
          fontFamily: _baseFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.2,
        ),
        buttonText1: TextStyle(
          fontFamily: _baseFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.3,
        ),
        tabText: TextStyle(
          fontFamily: _baseFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 10,
          height: 1.1,
        ),
      );

  @override
  AppTextThemeExt copyWith() {
    return AppTextsTheme._internal(
      title1: title1,
      title2: title2,
      title3: title3,
      title4: title4,
      text1: text1,
      text2: text2,
      buttonText1: buttonText1,
      tabText: tabText,
    );
  }

  @override
  AppTextThemeExt lerp(covariant AppTextThemeExt? other, double t) => this;
}
