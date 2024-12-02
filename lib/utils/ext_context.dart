import 'package:flutter/material.dart';

extension BuildContextExtentions on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get xTextTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.sizeOf(this);

  TextStyle get labelLargeBold =>
      xTextTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold);
  TextStyle get labelMediumBold =>
      xTextTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold);
  TextStyle get labelSmallBold =>
      xTextTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold);
  TextStyle get titleLargeBold =>
      xTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold);
  TextStyle get titleMediumBold =>
      xTextTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold);
  TextStyle get titleSmallBold =>
      xTextTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold);
  TextStyle get formError =>
      xTextTheme.labelSmall!.copyWith(color: colorScheme.error);

  TextStyle get labelLarge => xTextTheme.labelLarge!;
  TextStyle get labelMedium => xTextTheme.labelMedium!;
  TextStyle get labelSmall => xTextTheme.labelSmall!;
  TextStyle get titleLarge => xTextTheme.titleLarge!;
  TextStyle get titleMedium => xTextTheme.titleMedium!;
  TextStyle get titleSmall => xTextTheme.titleSmall!;
}
