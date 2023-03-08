import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

abstract class TipThemeData {
  ThemeData get materialThemeData;
}

class LightTipThemeData extends TipThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        brightness: Brightness.light,
        primarySwatch: persianBlue.toMaterialColor(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: trout,
        ),
      );
}

class DarkTipThemeData extends TipThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        brightness: Brightness.dark,
        primarySwatch: persianBlue.toMaterialColor(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: wildSand,
        ),
      );
}

extension on Color {
  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );
}
