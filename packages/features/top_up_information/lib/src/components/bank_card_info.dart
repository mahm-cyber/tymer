// import 'package:component_library/component_library.dart';
// import 'package:flutter/material.dart';
// import 'package:top_up_information/src/l10n/top_up_information_localizations.dart';
// import 'package:domain_models/domain_models.dart';

// class BankCardInfo extends StatelessWidget {
//   const BankCardInfo({
//     required this.bankCard,
//     super.key,
//   });

//   final BankCard bankCard;

//   @override
//   Widget build(BuildContext context) {
//     final l10n = TopUpInformationLocalizations.of(context);
//     return Column(
//       children: [
//         CopyableText(label: l10n.bankCardNumber, value: bankCard.cardNumber),
//         CopyableText(
//           label: l10n.messageAr,
//           value: _isArabic(context) ? bankCard.message.ar : bankCard.message.en,
//         ),
//       ],
//     );
//   }

//   bool _isArabic(BuildContext context) {
//     return Localizations.localeOf(context).languageCode == 'ar';
//   }
// } 