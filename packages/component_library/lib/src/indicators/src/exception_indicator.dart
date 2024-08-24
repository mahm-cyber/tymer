import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    this.title,
    this.message,
    this.onTryAgain,
    this.buttonLabel,
    this.isLoading = false,
    this.verticalPadding = 32,
    this.horizontalPadding = 16,
    super.key,
  });

  final String? title;
  final String? message;
  final VoidCallback? onTryAgain;
  final String? buttonLabel;
  final bool isLoading;
  final double verticalPadding;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 48,
            ),
            VerticalGap.large(),
            Text(title ?? l10n.generalExceptionMessage,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            if (message != null) ...[
              const SizedBox(
                height: 16,
              ),
              Text(
                message!,
                textAlign: TextAlign.center,
              ),
            ],
            if (onTryAgain != null) VerticalGap.xLarge(),
            if (onTryAgain != null)
              isLoading
                  ? TymerElevatedButton.inProgress(
                      label: buttonLabel ?? '',
                    )
                  : TymerElevatedButton(
                      onTap: onTryAgain,
                      label: buttonLabel ?? l10n.tryAgainButtonLabel,
                    ),
          ],
        ),
      ),
    );
  }
}
