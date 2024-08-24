import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class NextPageExceptionIndicator extends StatelessWidget {
  const NextPageExceptionIndicator({
    this.title,
    this.message,
    this.onTryAgain,
    super.key,
  });

  final String? title;
  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
            left: Spacing.mediumLarge,
            right: Spacing.mediumLarge,
            bottom: Spacing.mediumLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.error,
              size: 48,
              color: colorScheme.error,

            ),
            Text(
              title ?? 'حدث خطأ ما. اضغط للمحاولة مرة أخرى.',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
            if (onTryAgain != null) ...[
                VerticalGap.small(),
              GestureDetector(
                onTap: onTryAgain,
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Icon(
                      Icons.refresh,
                      color: colorScheme.onPrimary,
                    )),
              )

            ],
          ],
        ),
      ),
    );
  }
}
