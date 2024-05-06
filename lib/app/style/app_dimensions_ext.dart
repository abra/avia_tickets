import 'dart:ui';

import 'package:flutter/material.dart';

class AppDimensionsExt extends ThemeExtension<AppDimensionsExt> {
  const AppDimensionsExt({
    required this.verticalGap,
    required this.horizontalGap,
    required this.iconBorderRadius,
    required this.buttonBorderRadius,
    required this.inputBlockBorderRadius,
    required this.inputBlockPadding,
  });

  final double verticalGap;
  final double horizontalGap;
  final double iconBorderRadius;
  final double buttonBorderRadius;
  final double inputBlockBorderRadius;
  final EdgeInsets inputBlockPadding;

  @override
  ThemeExtension<AppDimensionsExt> copyWith({
    double? verticalGap,
    double? horizontalGap,
    double? iconBorderRadius,
    double? buttonBorderRadius,
    double? inputBlockBorderRadius,
    EdgeInsets? inputBlockPadding,
  }) {
    return AppDimensionsExt(
      verticalGap: verticalGap ?? this.verticalGap,
      horizontalGap: horizontalGap ?? this.horizontalGap,
      iconBorderRadius: iconBorderRadius ?? this.iconBorderRadius,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      inputBlockBorderRadius:
          inputBlockBorderRadius ?? this.inputBlockBorderRadius,
      inputBlockPadding: inputBlockPadding ?? this.inputBlockPadding,
    );
  }

  @override
  ThemeExtension<AppDimensionsExt> lerp(
    ThemeExtension<AppDimensionsExt>? other,
    double t,
  ) {
    if (other is! AppDimensionsExt) {
      return this;
    }
    return AppDimensionsExt(
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      horizontalGap: lerpDouble(horizontalGap, other.horizontalGap, t)!,
      iconBorderRadius:
          lerpDouble(iconBorderRadius, other.iconBorderRadius, t)!,
      buttonBorderRadius:
          lerpDouble(buttonBorderRadius, other.buttonBorderRadius, t)!,
      inputBlockBorderRadius:
          lerpDouble(inputBlockBorderRadius, other.inputBlockBorderRadius, t)!,
      inputBlockPadding:
          EdgeInsets.lerp(inputBlockPadding, other.inputBlockPadding, t)!,
    );
  }

}
