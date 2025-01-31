import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:top_up_information/src/components/components.dart';
import 'package:top_up_information/top_up_information.dart';

class VodafoneCashInfo extends StatelessWidget {
  const VodafoneCashInfo({
    required this.vodafoneCash,
    super.key,
  });

  final VodafoneCash vodafoneCash;

  @override
  Widget build(BuildContext context) {
    final l10n = TopUpInformationLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Column(
      children: [
        Text(
          isArabic ? vodafoneCash.message.ar : vodafoneCash.message.en,
        ),
        CopyableText(
            label: l10n.walletNumber, value: vodafoneCash.walletNumber),
      ],
    );
  }
}
