import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar({
    super.key,
    this.message,
    required this.context,
    this.snackBarAction,
    this.marginalSpace,
  }) : super(
          content: ErrorSnackBarContent(
            message: message,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFFFF0ED),
          margin: marginalSpace??TymerTheme.of(context).snackBarMargin,
          action: snackBarAction,
        );

  final String? message;
  final BuildContext context;
  final SnackBarAction? snackBarAction;
  final EdgeInsets? marginalSpace;
}

class ErrorSnackBarContent extends StatelessWidget {
  const ErrorSnackBarContent({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: colorScheme.error,
        ),
        HorizontalGap.small(),
        Expanded(
          child: Text(
            message ?? l10n.generalExceptionMessage,
            style: theme.materialThemeData.textTheme.titleSmall?.copyWith(
              color: colorScheme.error,
            ),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
