import 'package:component_library/component_library.dart';
import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceNameTextField extends StatefulWidget {
  const PlaceNameTextField({
    super.key,
  });

  @override
  State<PlaceNameTextField> createState() => _PlaceNameTextFieldState();
}

class _PlaceNameTextFieldState extends State<PlaceNameTextField> {
  final _placeNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpPlaceNameFieldFocusListener();
  }

  void _setUpPlaceNameFieldFocusListener() {
    final cubit = context.read<RequestServiceCubit>();
    _placeNameFocusNode.addListener(() {
      if (!_placeNameFocusNode.hasFocus) {
        cubit.onPlaceNameUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final cubit = context.read<RequestServiceCubit>();
        final l10n = RequestServiceLocalizations.of(context);
        final placeNameError =
            state.placeName.isNotValid ? state.placeName.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final theme = TymerTheme.of(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: TextField(
            enabled: !isSubmissionInProgress,
            focusNode: _placeNameFocusNode,
            onChanged: cubit.onPlaceNameChanged,
            decoration: InputDecoration(
              labelText: l10n.placeNameTextFieldLabel,
              hintText: l10n.placeNameTextFieldLabel,
              helperText: '',
              errorText: placeNameError == DynamicValidationError.empty
                  ? l10n.requiredFieldErrorMessage
                  : null,
            ),
          ),
        );
      },
    );
  }
}
