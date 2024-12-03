import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';



class WalletButton extends StatelessWidget {
  const WalletButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.mediumLarge,
          vertical: Spacing.medium,
        ),
        decoration: BoxDecoration(
          color: theme.materialThemeData.colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            HorizontalGap.medium(),
            Text(
              title,
              style: theme.materialThemeData.textTheme.titleMedium?.copyWith(
                color: theme.materialThemeData.colorScheme.surface,
                fontSize: 16,
                // fontWeight: FontWeight.w500,
              ),
            ),
            HorizontalGap.medium(),
            const SvgAsset(
              AssetPathConstants.arrowRightSquarePath,
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
