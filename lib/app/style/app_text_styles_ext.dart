import 'package:flutter/material.dart';

class AppTextStylesExt extends ThemeExtension<AppTextStylesExt> {
  const AppTextStylesExt({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.text1,
    required this.text2,
    required this.buttonText,
    required this.tabText,
  });

  final TextStyle title1;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle title4;
  final TextStyle text1;
  final TextStyle text2;
  final TextStyle buttonText;
  final TextStyle tabText;

  @override
  ThemeExtension<AppTextStylesExt> copyWith({
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? title3,
    TextStyle? title4,
    TextStyle? text1,
    TextStyle? text2,
    TextStyle? buttonText,
    TextStyle? tabText,
  }) {
    return AppTextStylesExt(
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      title4: title4 ?? this.title4,
      text1: text1 ?? this.text1,
      text2: text2 ?? this.text2,
      buttonText: buttonText ?? this.buttonText,
      tabText: tabText ?? this.tabText,
    );
  }

  @override
  ThemeExtension<AppTextStylesExt> lerp(
    ThemeExtension<AppTextStylesExt>? other,
    double t,
  ) {
    if (other is! AppTextStylesExt) {
      return this;
    }
    return AppTextStylesExt(
      title1: TextStyle.lerp(title1, other.title1, t)!,
      title2: TextStyle.lerp(title2, other.title2, t)!,
      title3: TextStyle.lerp(title3, other.title3, t)!,
      title4: TextStyle.lerp(title4, other.title4, t)!,
      text1: TextStyle.lerp(text1, other.text1, t)!,
      text2: TextStyle.lerp(text2, other.text2, t)!,
      buttonText: TextStyle.lerp(buttonText, other.buttonText, t)!,
      tabText: TextStyle.lerp(tabText, other.tabText, t)!,
    );
  }

}
