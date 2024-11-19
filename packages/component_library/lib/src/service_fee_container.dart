import 'package:domain_models/domain_models.dart';

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class ServiceFeeContainer extends StatelessWidget {
  const ServiceFeeContainer({
    super.key,
    required this.service
  });
  final Service service;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    final theme = TymerTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.xSmall,
      ),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.borderColor),
      ),
      child: Row(
        children: [
          Text(
            l10n.serviceFeesContainerLabel,
            style: textTheme.bodyMedium,
          ),
          const Spacer(),
          const SvgAsset(AssetPathConstants.bankNotePath),
          HorizontalGap.small(),
          Text(
            '${service.price.toStringAsFixed(0)} EGP',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
