import 'package:flutter/material.dart';

typedef AppDimensionsThemeExt = ThemeExtension<AppDimensionsTheme>;

class AppDimensionsTheme extends AppDimensionsThemeExt {
  final double verticalGap;
  final double horizontalGap;
  final double iconBorderRadius;
  final double buttonBorderRadius;
  final double inputBlockBorderRadius;
  final EdgeInsets inputBlockPadding;

  const AppDimensionsTheme._internal({
    required this.verticalGap,
    required this.horizontalGap,
    required this.iconBorderRadius,
    required this.buttonBorderRadius,
    required this.inputBlockBorderRadius,
    required this.inputBlockPadding,
  });

  factory AppDimensionsTheme.main() => const AppDimensionsTheme._internal(
        verticalGap: 8,
        horizontalGap: 8,
        iconBorderRadius: 8,
        buttonBorderRadius: 8,
        inputBlockBorderRadius: 16,
        inputBlockPadding: EdgeInsets.all(16),
      );

  @override
  ThemeExtension<AppDimensionsTheme> copyWith() => AppDimensionsTheme._internal(
        verticalGap: verticalGap,
        horizontalGap: horizontalGap,
        iconBorderRadius: iconBorderRadius,
        buttonBorderRadius: buttonBorderRadius,
        inputBlockBorderRadius: inputBlockBorderRadius,
        inputBlockPadding: inputBlockPadding,
      );

  @override
  AppDimensionsThemeExt lerp(
          covariant AppDimensionsThemeExt? other, double t) =>
      this;
}
