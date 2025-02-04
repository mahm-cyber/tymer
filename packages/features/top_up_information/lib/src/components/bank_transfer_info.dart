import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:top_up_information/src/components/components.dart';
import 'package:top_up_information/top_up_information.dart';

class BankTransferInfo extends StatelessWidget {
  const BankTransferInfo({
    required this.bankTransfer,
    super.key,
  });

  final BankTransfer bankTransfer;

  @override
  Widget build(BuildContext context) {
    final l10n = TopUpInformationLocalizations.of(context);
    return Expanded(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MarkdownBody(
                data: _isArabic(context)
                    ? bankTransfer.message.ar
                    : bankTransfer.message.en,
              ),
            ],
          ),
          CopyableText(
            label: l10n.beneficiaryName,
            value: bankTransfer.beneficiaryName!,
          ),
          CopyableText(
            label: l10n.beneficiaryAddress,
            value: bankTransfer.beneficiaryAddress!,
          ),
          CopyableText(
            label: l10n.bankName,
            value: bankTransfer.bankName!,
          ),
          CopyableText(
            label: l10n.accountNumber,
            value: bankTransfer.beneficiaryAccountNumber!,
          ),
          CopyableText(
            label: l10n.iban,
            value: bankTransfer.iban!,
          ),
          CopyableText(
            label: l10n.swiftCode,
            value: bankTransfer.swiftCode!,
          ),
        ],
      ),
    );
  }
}

bool _isArabic(BuildContext context) {
  return Localizations.localeOf(context).languageCode == 'ar';
}
