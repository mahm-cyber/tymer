import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class AppBarTitleContainer extends StatelessWidget {
  const AppBarTitleContainer({
    super.key,
    required this.title,
    this.widgetTitle,
    this.icon,
    this.top = 135,
    this.height = 50,
  });

  final String title;
  final Widget? widgetTitle;
  final Widget? icon;
  final double top;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Positioned(
      top: MediaQuery.of(context).padding.top + top,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
        decoration: BoxDecoration(
          color: theme.materialThemeData.colorScheme.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: kElevationToShadow[1],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              HorizontalGap.small(),
            ],
            widgetTitle ??
                Text(
                  title,
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
          ],
        ),
      ),
    );
  }
}
