import 'package:domain_models/domain_models.dart';
import 'package:request_service/src/components/components.dart';
import 'package:request_service/src/components/src/reservation_service_type_picker.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormFields extends StatefulWidget {
  const FormFields({
    super.key,
  });

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final isReservationServiceType =
            state.serviceType == ServiceType.reservation;
        return Expanded(
          child: ListView(
            children: [
                VerticalGap.xLarge(),
                VerticalGap.medium(),
              if (isReservationServiceType) ...[
                const ReservationServiceTypePicker(),
                VerticalGap.xSmall(),
                const ReservationNameTextField(),
                VerticalGap.xSmall(),
              ],
              const DatePickerTextField(),
              VerticalGap.xSmall(),
              const PlaceNameTextField(),
              VerticalGap.xSmall(),
              const AddressTextField(),
              VerticalGap.xSmall(),
              const LocationPickerTextField(),
              VerticalGap.xSmall(),
              const PricePickerTextField(),
              VerticalGap.xSmall(),
            ],
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
