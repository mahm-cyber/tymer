import 'package:component_library/src/service_fee_container.dart';
import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class Receipt extends StatelessWidget {
  const Receipt({
    super.key,
    required this.service,
    required this.onViewServiceOnMap,
  });

  final Service service;
  final VoidCallback onViewServiceOnMap;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);

    return Expanded(
      child: ListView(
        children: [
          VerticalGap.mediumLarge(),
          if (service.details != null)
            ServiceRequestDetailsExpansionTile(
              service: service,
              onViewServiceOnMap: onViewServiceOnMap,
            ),
          VerticalGap.medium(),
          ServiceFeeContainer(
            title: l10n.servicePriceContainerLabel,
            amount: service.price!.toStringAsFixed(0),
          ),
          VerticalGap.medium(),
          ServiceFeeContainer(
            title: l10n.serviceFeesContainerLabel,
            amount: service.fee!.toStringAsFixed(0),
          ),
          VerticalGap.medium(),
          ServiceFeeContainer(
            title: l10n.serviceTotalPriceContainerLabel,
            amount: service.totalPrice.toStringAsFixed(0),
          ),
          VerticalGap.medium(),
        ],
      ),
    );
  }
}
