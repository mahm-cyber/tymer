import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:top_up_information/src/components/components.dart';
import 'package:top_up_information/top_up_information.dart';

class TeldaInfo extends StatelessWidget {
  const TeldaInfo({
    required this.telda,
    super.key,
  });

  final Telda telda;

  @override
  Widget build(BuildContext context) {
    final l10n = TopUpInformationLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Column(
      children: [
        Text(
          isArabic ? telda.message.ar : telda.message.en,
        ),
        CopyableText(
          label: l10n.teldaUsername,
          value: telda.username!,
        ),
      ],
    );
  }
}
