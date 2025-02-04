import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:top_up_information/src/components/components.dart';
import 'package:top_up_information/top_up_information.dart';

class InstaPayInfo extends StatelessWidget {
  const InstaPayInfo({
    required this.instaPay,
    super.key,
  });

  final InstaPay instaPay;

  @override
  Widget build(BuildContext context) {
    final l10n = TopUpInformationLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Column(
      children: [
        MarkdownBody(
          data: isArabic ? instaPay.message.ar : instaPay.message.en,
        ),
        CopyableText(
          label: l10n.instantPaymentAddress,
          value: instaPay.instantPaymentAddress!,
        ),
      ],
    );
  }
}
