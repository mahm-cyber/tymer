import 'package:domain_models/domain_models.dart';
import 'package:request_service/src/components/components.dart';
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
                ReservationServiceTypePicker(),
                VerticalGap.xSmall(),
                ReservationNameTextField(),
                VerticalGap.xSmall(),
              ],
              DatePickerTextField(),
              VerticalGap.xSmall(),
              PlaceNameTextField(),
              VerticalGap.xSmall(),
              AddressTextField(),
              VerticalGap.xSmall(),
              LocationPickerTextField(),
              VerticalGap.xSmall(),
              PricePickerTextField(),
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
