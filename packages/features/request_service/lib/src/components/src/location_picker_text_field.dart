import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';

class LocationPickerTextField extends StatelessWidget {
  const LocationPickerTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<RequestServiceCubit>();
        final locationError =
            state.location.isNotValid ? state.location.error : null;
        final l10n = RequestServiceLocalizations.of(context);
        final theme = TymerTheme.of(context);
        final colorScheme = theme.materialThemeData.colorScheme;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: Stack(
            children: [
              IgnorePointer(
                child: TextField(
                  controller: TextEditingController(
                    text: state.location.value != null
                        ? l10n.locationPickedTextFieldLabel
                        : '',
                  ),
                  enabled: false,
                  style: TextStyle(
                    color: state.location.value != null
                        ? theme.primaryColor
                        : null,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.pin_drop_outlined,
                      size: 24,
                    ),
                    prefixIcon: state.location.value != null
                        ? Icon(
                            Icons.check_circle_outline,
                            size: 24,
                            color: theme.primaryColor,
                          )
                        : null,
                    errorText: locationError == DynamicValidationError.empty
                        ? l10n.requiredFieldErrorMessage
                        : null,
                    hintStyle: state.location.value != null
                        ? TextStyle(color: theme.primaryColor)
                        : null,
                    labelText: locationError != null
                        ? l10n.locationPickerTextFieldLabel
                        : l10n.locationPickerTextFieldLabel,
                    fillColor: colorScheme.surface,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: locationError != null
                            ? colorScheme.error
                            : theme.materialThemeData.inputDecorationTheme
                                .disabledBorder!.borderSide.color,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // labelStyle: TextStyle(
                    //   color: locationError != null
                    //       ? colorScheme.error
                    //       : colorScheme.onSurface,
                    // ),
                  ),
                  readOnly: true,
                ),
              ),
              GestureDetector(
                onTap: !isSubmissionInProgress
                    ? cubit.onLocationPickerTapped
                    : null,
                child: Container(
                  color: Colors.transparent,
                  height: 55,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
