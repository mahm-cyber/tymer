import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:top_up_information/src/components/components.dart';
import 'package:top_up_information/top_up_information.dart';

class OrangeCashInfo extends StatelessWidget {
  const OrangeCashInfo({
    required this.orangeCash,
    super.key,
  });

  final OrangeCash orangeCash;

  @override
  Widget build(BuildContext context) {
    final l10n = TopUpInformationLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Column(
      children: [
        CopyableText(label: l10n.walletNumber, value: orangeCash.walletNumber),
        Text(
          isArabic ? orangeCash.message.ar : orangeCash.message.en,
        ),
      ],
    );
  }
}
