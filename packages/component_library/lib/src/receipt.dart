import 'package:component_library/src/service_fee_container.dart';
import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class Receipt extends StatelessWidget {
  const Receipt({
    super.key,
    required this.service,
    required this.onViewServiceOnMap,
    required this.userToken,
  });

  final Service service;
  final VoidCallback onViewServiceOnMap;
  final String? userToken;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);

    return Expanded(
      child: ListView(
        children: [
          if (service.requestDetails != null) ...[
            ServiceRequestDetailsExpansionTile(
              service: service,
              onViewServiceOnMap: onViewServiceOnMap,
            ),
            VerticalGap.medium(),
          ],
          if (service.responseDetails != null && userToken != null) ...[
            ServiceResponseDetailsExpansionTile(
              service: service,
              userToken: userToken!,
            ),
            VerticalGap.medium(),
          ],
          ServiceFeeContainer(
            title: l10n.servicePriceContainerLabel,
            amount: service.price!,
          ),
          VerticalGap.medium(),
          ServiceFeeContainer(
            title: l10n.serviceFeesContainerLabel,
            amount: service.fee!,
          ),
          VerticalGap.medium(),
          ServiceFeeContainer(
            title: l10n.serviceTotalPriceContainerLabel,
            amount: service.totalPrice,
          ),
          VerticalGap.medium(),
        ],
      ),
    );
  }
}
