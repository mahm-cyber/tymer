import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class CenteredCircularProgressIndicator extends StatelessWidget {
  const CenteredCircularProgressIndicator({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        TymerTheme.of(context).materialThemeData.colorScheme;
    return Center(
      child: CircularProgressIndicator(color: color ?? colorScheme.primary),
    );
  }
}
