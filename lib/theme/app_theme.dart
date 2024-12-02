import 'package:flutter/material.dart';
import 'package:sansgen/theme/app_colors.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      // background: ColorLight.whitePrimary,
      // onBackground: ColorLight.blackPrimary, // Text on background color
      primary: ColorLight.whitePrimary,
      onPrimary: ColorLight.textPrimary, // Text on primary color
      secondary: ColorLight.textSecondary,
      onSecondary: ColorLight.blueGrey, // Text on secondary color
      surface: ColorLight.greenPrimary,
      onSurface: ColorLight.textPrimary, // Text on surface color
      tertiary: ColorLight.textPrimary,
      secondaryContainer: ColorLight.greyPrymery,
      onSecondaryContainer: ColorLight.greenDark,
      primaryContainer: ColorLight.greenLight,
      error: ColorLight.redPrimary,
    ),
  );
}
