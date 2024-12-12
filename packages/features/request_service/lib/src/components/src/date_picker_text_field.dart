import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';

class DatePickerTextField extends StatelessWidget {
  const DatePickerTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<RequestServiceCubit>();
        final dateError = state.date.isNotValid ? state.date.error : null;
        final l10n = RequestServiceLocalizations.of(context);
        final theme = TymerTheme.of(context);
        onTap() async {
          final dateTime = await showDatePicker(
            context: context,
            initialDate: state.date.value,
            firstDate: DateTime.now(),
            lastDate: DateTime(2040),
          );
          if (dateTime != null) cubit.onDatePicked(dateTime);
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: Stack(
            children: [
              IgnorePointer(
                child: TextField(
                  controller: TextEditingController(
                      text: state.date.value
                              ?.toIso8601String()
                              .substring(0, 10) ??
                          ''),
                  enabled: false,
                  style: TextStyle(
                    color: state.date.value != null ? theme.primaryColor : null,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      size: 24,
                    ),
                    prefixIcon: state.date.value != null
                        ? Icon(
                            Icons.check_circle_outline,
                            size: 24,
                            color: theme.primaryColor,
                          )
                        : null,
                    helperText: '',
                    errorText: dateError == DynamicValidationError.empty
                        ? l10n.requiredFieldErrorMessage
                        : null,
                    hintText: l10n.datePickerTextFieldLabel,
                    labelText: l10n.datePickerTextFieldLabel,
                    // labelStyle: dateError != null
                    //     ? TextStyle(color: theme.errorColor)
                    //     : null,
                    fillColor: colorScheme.surface,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: dateError != null
                            ? colorScheme.error
                            : theme.materialThemeData.inputDecorationTheme
                                .disabledBorder!.borderSide.color,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // labelStyle: TextStyle(
                    //   color: dateError != null
                    //       ? colorScheme.error
                    //       : colorScheme.onSurface,
                    // ),
                  ),
                  readOnly: true,
                ),
              ),
              GestureDetector(
                onTap: !isSubmissionInProgress ? onTap : null,
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
