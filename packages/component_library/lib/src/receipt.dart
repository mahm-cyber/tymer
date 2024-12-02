import 'package:component_library/src/service_fee_container.dart';
import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class Receipt extends StatelessWidget {
  const Receipt({
    super.key,
    required this.service,
    this.onViewServiceOnMap,
  });

  final Service service;
  final VoidCallback? onViewServiceOnMap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final l10n = ComponentLibraryLocalizations.of(context);

    return Expanded(
      child: ListView(
        children: [
          if (service.details != null)
            ExpansionTile(
              title: Text(
                l10n.serviceDetailsTitle,
                style: textTheme.titleMedium,
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: colorScheme.secondary,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: colorScheme.secondary,
                ),
              ),
              children: [
                ServiceDetailsWidget(
                  service: service,
                  onViewServiceOnMap: onViewServiceOnMap ?? () {},
                  physics: const NeverScrollableScrollPhysics(),
                ),
                VerticalGap.medium(),
              ],
            ),
          VerticalGap.medium(),
          ServiceFeeContainer(
            service: service,
          ),
          VerticalGap.medium(),
          ServiceFeeContainer(
            service: service,
          ),
          VerticalGap.medium(),
          ServiceFeeContainer(
            service: service,
          ),
          VerticalGap.medium(),
        ],
      ),
    );
  }
}
