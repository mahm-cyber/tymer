import 'package:component_library/src/l10n/component_library_localizations.dart';
import 'package:flutter/material.dart';

class UserExpiredSnackBar extends SnackBar {
  const UserExpiredSnackBar({super.key})
      : super(
          content: const _UserExpiredSnackBarMessage(),
        );
}

class _UserExpiredSnackBarMessage extends StatelessWidget {
  const _UserExpiredSnackBarMessage();

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    return Text(
      l10n.userExpiredSnackBarErrorMessage,
    );
  }
}
