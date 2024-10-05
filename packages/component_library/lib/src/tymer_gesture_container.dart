import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class TymerGestureContainer extends StatelessWidget {
  const TymerGestureContainer({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final VoidCallback onTap;
  final Widget icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(Spacing.xSmall),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: icon,
            ),
            HorizontalGap.medium(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.surface,
                      fontSize: 20,
                    )),
                if (subtitle != null) ...[
                  VerticalGap.xSmall(),
                  Text(
                    subtitle!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.surface.withOpacity(0.6),
                    ),
                  ),
                ],
              ],
            ),
            HorizontalGap.medium(),
            RotatedBox(
              quarterTurns: isArabic ? 2 : 0,
              child: const SvgAsset(
                AssetPathConstants.arrowRightSquarePath,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
