import 'package:component_library/src/theme/tymer_theme_data.dart';
import 'package:flutter/material.dart';

class TymerTheme extends InheritedWidget {
  const TymerTheme({
    required super.child,
    required BuildContext context,
    required this.lightTheme,
    required this.darkTheme,
    super.key,
  });

  final TymerThemeData lightTheme;
  final TymerThemeData darkTheme;

  @override
  bool updateShouldNotify(
    TymerTheme oldWidget,
  ) =>
      oldWidget.lightTheme != lightTheme || oldWidget.darkTheme != darkTheme;

  static TymerThemeData of(BuildContext context) {
    final TymerTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<TymerTheme>();
    assert(inheritedTheme != null, 'No TymerTheme found in context');
    final currentBrightness = Theme.of(context).brightness;
    return currentBrightness == Brightness.dark
        ? inheritedTheme!.darkTheme
        : inheritedTheme!.lightTheme;
  }
}
