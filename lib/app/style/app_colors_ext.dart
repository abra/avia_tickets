import 'package:flutter/material.dart';

class AppColorsExt extends ThemeExtension<AppColorsExt> {
  const AppColorsExt({
    required this.black,
    required this.grey1,
    required this.grey2,
    required this.grey3,
    required this.grey4,
    required this.grey5,
    required this.grey6,
    required this.grey7,
    required this.white,
    required this.blue,
    required this.darkBlue,
    required this.green,
    required this.darkGreen,
    required this.red,
    required this.orange,
  });

  final Color black;
  final Color grey1;
  final Color grey2;
  final Color grey3;
  final Color grey4;
  final Color grey5;
  final Color grey6;
  final Color grey7;
  final Color white;
  final Color blue;
  final Color darkBlue;
  final Color green;
  final Color darkGreen;
  final Color red;
  final Color orange;

  @override
  ThemeExtension<AppColorsExt> copyWith({
    Color? black,
    Color? grey1,
    Color? grey2,
    Color? grey3,
    Color? grey4,
    Color? grey5,
    Color? grey6,
    Color? grey7,
    Color? white,
    Color? blue,
    Color? darkBlue,
    Color? green,
    Color? darkGreen,
    Color? red,
    Color? orange,
  }) => AppColorsExt(
      black: black ?? this.black,
      grey1: grey1 ?? this.grey1,
      grey2: grey2 ?? this.grey2,
      grey3: grey3 ?? this.grey3,
      grey4: grey4 ?? this.grey4,
      grey5: grey5 ?? this.grey5,
      grey6: grey6 ?? this.grey6,
      grey7: grey7 ?? this.grey7,
      white: white ?? this.white,
      blue: blue ?? this.blue,
      darkBlue: darkBlue ?? this.darkBlue,
      green: green ?? this.green,
      darkGreen: darkGreen ?? this.darkGreen,
      red: red ?? this.red,
      orange: orange ?? this.orange,
    );

  @override
  ThemeExtension<AppColorsExt> lerp(
      ThemeExtension<AppColorsExt>? other, double t) {
    if (other is! AppColorsExt) {
      return this;
    }
    return AppColorsExt(
      black: Color.lerp(black, other.black, t)!,
      grey1: Color.lerp(grey1, other.grey1, t)!,
      grey2: Color.lerp(grey2, other.grey2, t)!,
      grey3: Color.lerp(grey3, other.grey3, t)!,
      grey4: Color.lerp(grey4, other.grey4, t)!,
      grey5: Color.lerp(grey5, other.grey5, t)!,
      grey6: Color.lerp(grey6, other.grey6, t)!,
      grey7: Color.lerp(grey7, other.grey7, t)!,
      white: Color.lerp(white, other.white, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      darkBlue: Color.lerp(darkBlue, other.darkBlue, t)!,
      green: Color.lerp(green, other.green, t)!,
      darkGreen: Color.lerp(darkGreen, other.darkGreen, t)!,
      red: Color.lerp(red, other.red, t)!,
     orange: Color.lerp(orange, other.orange, t)!,
    );
  }
}
