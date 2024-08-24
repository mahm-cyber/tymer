import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class SuccessSnackBar extends SnackBar {
  SuccessSnackBar({
    super.key,
    this.message,
    this.marginalSpace,
    this.snackBarAction,
    this.icon,
    this.bgColor,
    this.messageColor,
    this.showClose = false,
    this.closeColor,
    required this.context,
  }) : super(
    content: SuccessSnackBarContent(
      message: message,
      icon: icon,
      messageColor: messageColor,
      action: snackBarAction,
    ),
    showCloseIcon: showClose,
    margin: marginalSpace,
    backgroundColor: bgColor ??
        TymerTheme.of(context).successContainerColor,
    closeIconColor: closeColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final EdgeInsets? marginalSpace;
  final String? message;
  final BuildContext context;
  final Widget? snackBarAction;
  final Widget? icon;
  final Color? bgColor;
  final Color? messageColor;
  final bool showClose;
  final Color? closeColor;
}

class SuccessSnackBarContent extends StatelessWidget {
  const SuccessSnackBarContent({
    super.key,
    this.message,
    this.icon,
    this.messageColor,
    this.action,
  });

  final String? message;
  final Widget? icon;
  final Color? messageColor;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon ??
            Icon(
              Icons.check_circle_outline,
              color: theme.orderedVoucherUsedStatusTextColor,
            ),
        HorizontalGap.xSmall(),
        Text(
          message ?? l10n.successSnackBarMessage,
          style: theme.materialThemeData.textTheme.titleSmall?.copyWith(
            color: messageColor ?? theme.orderedVoucherUsedStatusTextColor,
          ),
        ),
        if (action != null) ...[
          const Spacer(),
          action!
        ]
      ],
    );
  }
}
