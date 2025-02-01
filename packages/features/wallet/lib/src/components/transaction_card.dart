import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:wallet/src/l10n/wallet_localizations.dart';

import 'package:wallet_repository/wallet_repository.dart';


class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
  });

  final InAppTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = WalletLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final clL10n = ComponentLibraryLocalizations.of(context);
    Color getStatusColor() {
      switch (transaction.status) {
        case InAppTransactionStatus.completed:
          return theme.colorScheme.secondary;
        case InAppTransactionStatus.pending:
          return theme.colorScheme.primary;
        case InAppTransactionStatus.rejected:
          return theme.colorScheme.error;
      
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: Spacing.medium,
        vertical: Spacing.small,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${transaction.id.localizeInt(locale)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    transaction.type == InAppTransactionType.earning
                        ? l10n.earning
                        : l10n.payout,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${transaction.amount.localizeInt(locale)} ${clL10n.eyptianPoundLetters}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: transaction.type == InAppTransactionType.earning
                        ? theme.colorScheme.primary
                        : theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            VerticalGap.small(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.updatedAt
                      .toIso8601String()
                      .split('T')
                      .first
                      .localizeDateString(locale),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  transaction.status.toString().split('.').last.capitalize(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: getStatusColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

