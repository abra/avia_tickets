import 'package:flutter/material.dart';

import 'app_colors_ext.dart';
import 'app_text_styles_ext.dart';

extension AppThemeExtGetters on BuildContext {
  AppColorsExt get appColors => Theme.of(this).extension<AppColorsExt>()!;

  AppTextStylesExt get appTextStyles =>
      Theme.of(this).extension<AppTextStylesExt>()!;
}
