import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class EtisalatCashInfo extends StatelessWidget {
  const EtisalatCashInfo({
    required this.etisalatCash,
    super.key,
  });

  final EtisalatCash etisalatCash;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Column(
      children: [
        Padding(
           padding: EdgeInsets.fromLTRB(
          TymerTheme.of(context).screenMargin,
          0,
          TymerTheme.of(context).screenMargin,
          TymerTheme.of(context).screenMargin,
        ),
          child: MarkdownBody(
          data: isArabic ? etisalatCash.message.ar : etisalatCash.message.en,
        ),),
      ],
    );
  }
}
