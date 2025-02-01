import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:payment_history/src/l10n/payment_history_localizations.dart';
import 'package:wallet_repository/wallet_repository.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    required this.payment,
    super.key,
  });

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    String paymentMethodDetails() {
      if (payment.ibanNumber?.isNotEmpty == true &&
          payment.beneficiaryName?.isNotEmpty == true) {
        return '${PaymentHistoryLocalizations.of(context).ibanNumberLabel}: ${payment.ibanNumber}\n'
            '${PaymentHistoryLocalizations.of(context).beneficiaryNameLabel}: ${payment.beneficiaryName}';
      } else if (payment.walletNumber?.isNotEmpty == true) {
        return '${PaymentHistoryLocalizations.of(context).walletNumberLabel}: ${payment.walletNumber}';
      } else if (payment.instantPaymentAddress != null) {
        return '${PaymentHistoryLocalizations.of(context).instantPaymentAddressLabel}: ${payment.instantPaymentAddress}';
      }
      return '';
    }

    final textTheme = Theme.of(context).textTheme;
    final l10n = PaymentHistoryLocalizations.of(context);
    final status = paymentStatusToLocalizedString(
      payment.status,
      ComponentLibraryLocalizations.of(context),
    );
    final locale = Localizations.localeOf(context);
    final clL10n = ComponentLibraryLocalizations.of(context);
    
    Color getStatusColor(PaymentStatus status) {
      switch (status) {
        case PaymentStatus.pending:
          return Colors.orange;
        case PaymentStatus.approved:
          return Colors.green;
        case PaymentStatus.rejected:
          return Colors.red;
      }
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.small,
            horizontal: Spacing.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                '#${payment.id.localizeInt(locale)}',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              VerticalGap.small(),
              SelectableText(
                '${l10n.amountLabel}: ${payment.amount.localizeInt(locale)} ${clL10n.eyptianPoundLetters}',
                style: textTheme.bodyMedium,
              ),
              VerticalGap.xSmall(),
              if (paymentMethodDetails().isNotEmpty) ...[
                SelectableText(
                  paymentMethodDetails(),
                  style: textTheme.bodyMedium,
                ),
                VerticalGap.xSmall(),
              ],
              RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: '${l10n.statusLabel}: ',
                    ),
                    TextSpan(
                      text: status,
                      style: textTheme.bodyMedium?.copyWith(
                        color: getStatusColor(payment.status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalGap.xSmall(),
              SelectableText(
                '${l10n.dateLabel}: ${payment.updatedAt.toIso8601String().split('T').first.localizeDateString(locale)}',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String paymentStatusToLocalizedString(
  PaymentStatus paymentStatus,
  ComponentLibraryLocalizations l10n,
) {
  switch (paymentStatus) {
    case PaymentStatus.pending:
      return l10n.pending;
    case PaymentStatus.approved:
      return l10n.approved;
    case PaymentStatus.rejected:
      return l10n.rejected;
  }
}
