import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class ServiceFeeContainer extends StatelessWidget {
  const ServiceFeeContainer({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = TymerTheme.of(context);
    final locale = Localizations.localeOf(context);
    final l10n = ComponentLibraryLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.xSmall,
      ),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.borderColor),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: textTheme.bodyMedium,
          ),
          const Spacer(),
          const SvgAsset(AssetPathConstants.bankNotePath),
          HorizontalGap.small(),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 70,
              minWidth: 55
            ),
            child: Text(
              '${amount.localizeDouble(locale)} ${l10n.eyptianPoundLetters}',
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
