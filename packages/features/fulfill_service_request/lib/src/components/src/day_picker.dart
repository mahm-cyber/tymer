import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class DayPicker extends StatefulWidget {
  const DayPicker({
    super.key,
    required this.onChanged,
    required this.isSubmissionInProgress,
    this.error,
    this.initialValue,
  });

  final ValueChanged<DateTime?> onChanged;
  final bool isSubmissionInProgress;
  final DynamicValidationError? error;
  final DateTime? initialValue;

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  DateTime? pickedDay;

  void updateField(DateTime? newValue) {
    pickedDay = newValue;
    setState(() {});
    widget.onChanged(newValue);
  }

  void pickDateAndTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: pickedDay ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      updateField(
        DateTime(
          date.year,
          date.month,
          date.day,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = FulfillServiceRequestLocalizations.of(context);
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final theme = TymerTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: widget.isSubmissionInProgress ? null : pickDateAndTime,
              child: TextField(
                enabled: false,
                textDirection: TextDirection.ltr,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                    fillColor: widget.isSubmissionInProgress
                        ? null
                        : colorScheme.surface,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.error != null
                            ? colorScheme.error
                            : theme.materialThemeData.inputDecorationTheme
                                .disabledBorder!.borderSide.color,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: pickedDay == null
                        ? const Icon(Icons.calendar_today)
                        : null,
                    labelText: l10n.dayTextFieldLabel,
                    errorText: widget.error != null
                        ? l10n.requiredFieldErrorMessage
                        : null),
                controller: TextEditingController(
                  //Date and time -- make hour and minute have 0 in the beignning if less than 10
                  text: widget.initialValue != null
                      ? widget.initialValue?.formattedDate
                      : pickedDay != null
                          ? pickedDay!.formattedDate
                          : '',
                ),
              ),
            ),
            if (pickedDay != null)
              PositionedDirectional(
                end: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: colorScheme.secondary,
                  ),
                  onPressed: widget.isSubmissionInProgress
                      ? null
                      : () => updateField(null),
                ),
              ),
          ],
        ),
        // if (widget.error != null) ...[
        //   VerticalGap.xSmall(),
        //   Padding(
        //     padding: const EdgeInsetsDirectional.only(start: Spacing.medium),
        //     child: Text(
        //       l10n.requiredFieldErrorMessage,
        //       style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
        //     ),
        //   ),
        // ],
      ],
    );
  }
}
