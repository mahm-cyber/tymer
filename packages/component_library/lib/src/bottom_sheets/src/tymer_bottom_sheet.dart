import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class TymerBottomSheet extends StatelessWidget {
  const TymerBottomSheet({
    super.key,
    this.height,
    required this.title,
    required this.child,
    this.hasBack = false,
  });

  final double? height;
  final String title;
  final Widget child;
  final bool hasBack;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.medium),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            height: 35,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (hasBack)
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: theme.materialThemeData.colorScheme.surface,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: theme.materialThemeData.colorScheme.surface,
                  ),
                ),
                const Spacer(),
                if (!hasBack)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 25,
                      height: 25,
                      color: Colors.transparent,
                      child: Icon(
                        Icons.close,
                        color: theme.materialThemeData.colorScheme.surface,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
