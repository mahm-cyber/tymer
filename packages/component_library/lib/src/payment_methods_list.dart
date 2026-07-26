import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class PaymentMethodsList extends StatelessWidget {
  const PaymentMethodsList({
    super.key,
    required this.onPaymentMethodTapped,
    required this.paymentMethods,
    required this.bankCardEnabled,
    required this.onViewHistoryTapped,
    required this.viewHistoryButtonLabel,
    this.shouldShowHint = false,
  });

  final Function(PaymentMethodType) onPaymentMethodTapped;
  final PaymentMethods paymentMethods;
  final bool bankCardEnabled;
  final Function() onViewHistoryTapped;
  final String viewHistoryButtonLabel;
  final bool shouldShowHint;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final clL10n = ComponentLibraryLocalizations.of(context);
    return ListView(
      shrinkWrap: true,
      children: [
        VerticalGap.mediumLarge(),
        if (bankCardEnabled)
          ListTile(
            title: Text(clL10n.bankCard),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            leading: const Icon(Icons.credit_card),
            onTap: () => onPaymentMethodTapped(PaymentMethodType.bankCard),
          ),
        if (paymentMethods.vodafoneCash.enabled)
          ListTile(
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 4.0,
              children: [
                Text(clL10n.vodafoneCash),
                if (!shouldShowHint)
                  Text(
                    clL10n.poweredByPaymob,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            leading: const Icon(Icons.phone_android),
            onTap: () => onPaymentMethodTapped(PaymentMethodType.vodafoneCash),
          ),
        if (paymentMethods.orangeCash.enabled)
          ListTile(
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 4.0,
              children: [
                Text(clL10n.orangeCash),
                if (!shouldShowHint)
                  Text(
                    clL10n.poweredByPaymob,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            leading: const Icon(Icons.phone_android),
            onTap: () => onPaymentMethodTapped(PaymentMethodType.orangeCash),
          ),
        if (paymentMethods.etisalatCash.enabled)
          ListTile(
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 4.0,
              children: [
                Text(clL10n.etisalatCash),
                if (!shouldShowHint)
                  Text(
                    clL10n.poweredByPaymob,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            leading: const Icon(Icons.phone_android),
            onTap: () => onPaymentMethodTapped(PaymentMethodType.etisalatCash),
          ),
        if (paymentMethods.instaPay.enabled)
          ListTile(
            title: Text(clL10n.instaPay),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            leading: const Icon(Icons.flash_on),
            onTap: () => onPaymentMethodTapped(PaymentMethodType.instaPay),
          ),
        if (paymentMethods.bankTransfer.enabled)
          ListTile(
            title: Text(clL10n.bankTransfer),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            leading: const Icon(Icons.account_balance),
            onTap: () => onPaymentMethodTapped(PaymentMethodType.bankTransfer),
          ),
        if (paymentMethods.telda.enabled)
          ListTile(
            title: Text(clL10n.telda),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            leading: const Padding(
              padding: EdgeInsetsDirectional.only(start: 3.0),
              child: Text(
                '~',
                style: TextStyle(fontSize: 40),
              ),
            ),
            onTap: () => onPaymentMethodTapped(PaymentMethodType.telda),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: theme.screenMargin,
                  horizontal: theme.screenMargin,
                ),
              ),
              onPressed: onViewHistoryTapped,
              icon: const Icon(Icons.history),
              label: Text(viewHistoryButtonLabel),
            ),
          ],
        ),
      ],
    );
  }
}
