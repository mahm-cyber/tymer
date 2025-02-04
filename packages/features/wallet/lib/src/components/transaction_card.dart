import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'package:wallet_repository/wallet_repository.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    final clL10n = ComponentLibraryLocalizations.of(context);
    Color getStatusColor() {
      switch (transaction.status) {
        case TransactionStatus.completed:
          return theme.primaryColor;
        case TransactionStatus.pending:
          return theme.secondaryIconColor;
        case TransactionStatus.failed:
          return theme.errorColor;
        case TransactionStatus.cancelled:
          return theme.errorColor;
        case TransactionStatus.underReview:
          return theme.secondaryColor;
        case TransactionStatus.refunded:
          return theme.secondaryColor;
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
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    transactionTypeToLocalizeString(
                      transaction.type,
                      clL10n,
                    ),
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${transaction.amount.localizeInt(locale)} ${clL10n.eyptianPoundLetters}',
                  style: textTheme.titleMedium?.copyWith(
                    color: transaction.type == TransactionType.earning ||
                            transaction.type == TransactionType.withdraw ||
                            transaction.type == TransactionType.topup
                        ? theme.primaryColor
                        : theme.errorColor,
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
                  style: textTheme.bodyMedium,
                ),
                Text(
                  transactionStatusToLocalizeString(
                    transaction.status,
                    clL10n,
                  ),
                  style: textTheme.bodyMedium?.copyWith(
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

String transactionStatusToLocalizeString(
  TransactionStatus status,
  ComponentLibraryLocalizations l10n,
) {
  switch (status) {
    case TransactionStatus.completed:
      return l10n.transactionStatusCompleted;
    case TransactionStatus.pending:
      return l10n.transactionStatusPending;
    case TransactionStatus.failed:
      return l10n.transactionStatusFailed;
    case TransactionStatus.cancelled:
      return l10n.transactionStatusCancelled;
    case TransactionStatus.underReview:
      return l10n.transactionStatusUnderReview;
    case TransactionStatus.refunded:
      return l10n.transactionStatusRefunded;
  }
}

String transactionTypeToLocalizeString(
  TransactionType type,
  ComponentLibraryLocalizations l10n,
) {
  switch (type) {
    case TransactionType.earning:
      return l10n.transactionTypeEarning;
    case TransactionType.payout:
      return l10n.transactionTypePayout;
    case TransactionType.topup:
      return l10n.transactionTypeTopup;
    case TransactionType.withdraw:
      return l10n.transactionTypeWithdrawal;
  }
}
