import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  ColorScheme get themeColor => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
