import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({
    super.key,
    this.textColor,
    required this.onRefresh,
  });

  final Color? textColor;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);

    final textTheme = Theme.of(context).textTheme;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Expanded(
        child: ListView(
          children: [
            VerticalGap.xxxLarge(),
            VerticalGap.xxxLarge(),
            VerticalGap.xxxLarge(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
              child: Center(
                child: Text(
                  l10n.emptyListIndicatorText,
                  style: textTheme.titleLarge?.copyWith(
                      color: textColor ?? theme.primaryColor,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
