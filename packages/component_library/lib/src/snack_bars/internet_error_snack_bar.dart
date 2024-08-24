import 'package:component_library/src/l10n/component_library_localizations.dart';
import 'package:flutter/material.dart';

class InternetErrorSnackBar extends SnackBar {
  const InternetErrorSnackBar({super.key})
      : super(
          content: const _InternetErrorSnackBarMessage(),
        );
}

class _InternetErrorSnackBarMessage extends StatelessWidget {
  const _InternetErrorSnackBarMessage();

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    return Text(
      l10n.noInternetConnectionSnackBarErrorMessage,
    );
  }
}
