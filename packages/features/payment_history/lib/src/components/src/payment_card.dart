import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:payment_history/src/l10n/payment_history_localizations.dart';
import 'package:wallet_repository/wallet_repository.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    required this.payment,
    this.userToken,
    super.key,
  });

  final Payment payment;
  final String? userToken;
  @override
  Widget build(BuildContext context) {
    final l10n = PaymentHistoryLocalizations.of(context);
    String paymentMethodDetails() {
      if (payment.ibanNumber?.isNotEmpty == true &&
          payment.beneficiaryName?.isNotEmpty == true) {
        return '${l10n.ibanNumberLabel}: ${payment.ibanNumber}\n'
            '${l10n.beneficiaryNameLabel}: ${payment.beneficiaryName}';
      } else if (payment.walletNumber?.isNotEmpty == true) {
        return '${l10n.walletNumberLabel}: ${payment.walletNumber}';
      } else if (payment.instantPaymentAddress != null) {
        return '${l10n.instantPaymentAddressLabel}: ${payment.instantPaymentAddress}';
      }
      return '';
    }

    final textTheme = Theme.of(context).textTheme;
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
          child: Row(
            children: [
              Column(
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
                    '${l10n.amountLabel}: ${payment.amount.localizeDouble(locale)} ${clL10n.eyptianPoundLetters}',
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
              if (payment.proofImageUrl != null && userToken != null) ...[
                const Spacer(),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: InteractiveViewer(
                          panEnabled: true,
                          minScale: 0.5,
                          maxScale: 4,
                          child: Image.network(payment.proofImageUrl!),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        payment.proofImageUrl!,
                        headers: {
                          "Authorization": "Bearer $userToken",
                          "X-API-Key":
                              const String.fromEnvironment('x-api-key'),
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
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
      return l10n.pendingPaymentStatus;
    case PaymentStatus.approved:
      return l10n.approvedPaymentStatus;
    case PaymentStatus.rejected:
      return l10n.rejectedPaymentStatus;
  }
}
