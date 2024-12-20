import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:fulfill_service_request/src/fulfill_service_request_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class ServiceFeeContainer extends StatelessWidget {
  const ServiceFeeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FulfillServiceRequestCubit, FulfillServiceRequestState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final l10n = FulfillServiceRequestLocalizations.of(context);
        final theme = TymerTheme.of(context);
        final clL10n = ComponentLibraryLocalizations.of(context);
        final locale = Localizations.localeOf(context);
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
                '${state.service!.totalPrice.localizeDouble(locale)} ${clL10n.eyptianPoundLetters}',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
