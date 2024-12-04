import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    required this.onChanged,
    required this.isSubmissionInProgress,
    this.error,
    this.initialValue,
  });

  final ValueChanged<TimeOfDay?> onChanged;
  final bool isSubmissionInProgress;
  final DynamicValidationError? error;
  final TimeOfDay? initialValue;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? pickedTime;

  void updateField(TimeOfDay? newValue) {
    pickedTime = newValue;
    setState(() {});
    widget.onChanged(newValue);
  }

  void pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: pickedTime == null
          ? TimeOfDay.now()
          : TimeOfDay(
              hour: pickedTime!.hour,
              minute: pickedTime!.minute,
            ),
    );
    if (time != null) {
      updateField(TimeOfDay(
        hour: time.hour,
        minute: time.minute,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = FulfillServiceRequestLocalizations.of(context);
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final theme = TymerTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: widget.isSubmissionInProgress ? null : pickTime,
              child: TextField(
                enabled: false,
                textDirection: TextDirection.ltr,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  fillColor: colorScheme.surface,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.error != null
                          ? colorScheme.error
                          : theme.materialThemeData.inputDecorationTheme
                              .disabledBorder!.borderSide.color,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: pickedTime == null
                      ? const Icon(Icons.calendar_today)
                      : null,
                  labelText: l10n.timeTextFieldLabel,
                  labelStyle: TextStyle(
                    color: widget.error != null
                        ? colorScheme.error
                        : colorScheme.onSurface,
                  ),
                ),
                controller: TextEditingController(
                  //Date and time -- make hour and minute have 0 in the beignning if less than 10
                  text: widget.initialValue != null
                      ? widget.initialValue?.twelveHrFormat
                      : pickedTime != null
                          ? pickedTime!.twelveHrFormat
                          : '',
                ),
              ),
            ),
            if (pickedTime != null)
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
        if (widget.error != null) ...[
          VerticalGap.xSmall(),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: Spacing.medium),
            child: Text(
              l10n.requiredFieldErrorMessage,
              style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
            ),
          ),
        ],
      ],
    );
  }
}
