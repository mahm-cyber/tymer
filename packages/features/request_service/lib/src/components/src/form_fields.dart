import 'package:domain_models/domain_models.dart';
import 'package:form_fields/form_fields.dart';
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
        final isReservationService =
            state.serviceType == ServiceType.reservation;
        final cubit = context.read<RequestServiceCubit>();
        final theme = TymerTheme.of(context);
        return Expanded(
          child: ListView(
            children: [
              VerticalGap.xLarge(),
              VerticalGap.medium(),
              if (isReservationService) ...[
                const ReservationServiceTypePicker(),
                VerticalGap.small(),
                const ReservationNameTextField(),
                VerticalGap.small(),
              ],
              const DatePickerTextField(),
              VerticalGap.small(),
              if (state.date.value != null) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
                  child: TimePicker(
                    onChanged: cubit.onTimeChanged,
                    pickedDay: state.date.value,
                    isSubmissionInProgress: state.submissionStatus ==
                        FormzSubmissionStatus.inProgress,
                    shouldAllowPastTime: false,
                    error: state.time.error,
                    initialValue: null,
                    onBackButtonPressed: cubit.onBackButtonPressed,
                  ),
                ),
                VerticalGap.small(),
              ],
              const PlaceNameTextField(),
              VerticalGap.small(),
              const AddressTextField(),
              VerticalGap.small(),
              const LocationPickerTextField(),
              VerticalGap.small(),
              const PricePickerTextField(),
              VerticalGap.small(),
              const AdditionalCommentsTextField(),
              VerticalGap.small(),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
