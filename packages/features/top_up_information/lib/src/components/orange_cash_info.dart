import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class OrangeCashInfo extends StatelessWidget {
  const OrangeCashInfo({
    required this.orangeCash,
    super.key,
  });

  final OrangeCash orangeCash;

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
            
            data: isArabic ? orangeCash.message.ar : orangeCash.message.en,
          ),
        ),
      ],
    );
  }
}
