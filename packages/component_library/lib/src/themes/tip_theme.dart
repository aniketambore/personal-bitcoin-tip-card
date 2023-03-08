import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class TipTheme extends InheritedWidget {
  const TipTheme({
    super.key,
    required Widget child,
    required this.lightTheme,
    required this.darkTheme,
  }) : super(
          child: child,
        );

  final TipThemeData lightTheme;
  final TipThemeData darkTheme;

  @override
  bool updateShouldNotify(TipTheme oldWidget) =>
      oldWidget.lightTheme != lightTheme || oldWidget.darkTheme != darkTheme;

  static TipThemeData of(BuildContext context) {
    final TipTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<TipTheme>();
    assert(inheritedTheme != null, 'No TipTheme found in context');

    final currentBrightness = Theme.of(context).brightness;

    return currentBrightness == Brightness.dark
        ? inheritedTheme!.darkTheme
        : inheritedTheme!.lightTheme;
  }
}
