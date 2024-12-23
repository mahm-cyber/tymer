import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    required this.onChanged,
    required this.isSubmissionInProgress,
    this.error,
    this.initialValue,
    this.shouldAllowPastTime = true,
    this.pickedDay,
  });

  final ValueChanged<TimeOfDay?> onChanged;
  final bool isSubmissionInProgress;
  final DynamicValidationError? error;
  final TimeOfDay? initialValue;
  final bool shouldAllowPastTime;
  final DateTime? pickedDay;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? pickedTime;
  ValueNotifier<bool?> isTimeInPast = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    pickedTime = widget.initialValue;
    setState(() {});
    isTimeInPast.addListener(
      () {
        final l10n = ComponentLibraryLocalizations.of(context);
        if (isTimeInPast.value == true) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.timeInPastErrorMessage,
            ),
          );
        }
      },
    );
  }

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
    final isPickedDayToday = widget.pickedDay?.day == DateTime.now().day &&
        widget.pickedDay?.month == DateTime.now().month &&
        widget.pickedDay?.year == DateTime.now().year;
    final shouldShowTimeInPastErrorMessage = time != null &&
        !widget.shouldAllowPastTime &&
        isPickedDayToday &&
        (time.hour < DateTime.now().hour ||
            (time.minute < DateTime.now().minute &&
                time.hour == DateTime.now().hour));

    if (shouldShowTimeInPastErrorMessage) {
      isTimeInPast.value = true;
      setState(() {});
      isTimeInPast.value = false;
      return;
    }

    if (time != null) {
      isTimeInPast.value = false;
      setState(() {});
      updateField(TimeOfDay(
        hour: time.hour,
        minute: time.minute,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final theme = TymerTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);

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
                  color: widget.initialValue!= null ? null:colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  fillColor: widget.isSubmissionInProgress? null:colorScheme.surface,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.error != null
                          ? colorScheme.error
                          : theme.materialThemeData.inputDecorationTheme
                              .disabledBorder!.borderSide.color,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon:
                      pickedTime == null || widget.initialValue!= null ? const Icon(Icons.access_time) : null,
                  labelText: l10n.timeTextFieldLabel,
                  errorText: /*isTimeInPast.value == true
                      ? l10n.timeInPastErrorMessage
                      : */
                      widget.error != null
                          ? l10n.requiredFieldErrorMessage
                          : null,
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
            if (pickedTime != null && widget.initialValue == null)
              PositionedDirectional(
                end: 0,
                top: 4,
                child: Align(
                  alignment: Alignment.center,
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
              ),
          ],
        ),
        // if (widget.error != null || isTimeInPast.value == true) ...[
        //   VerticalGap.xSmall(),
        //   Padding(
        //     padding: const EdgeInsetsDirectional.only(start: Spacing.medium),
        //     child: Text(
        //       isTimeInPast.value == true
        //           ? 'l10n.timeInPastErrorMessage'
        //           : l10n.requiredFieldErrorMessage,
        //       style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
        //     ),
        //   ),
      ],
      // ],
    );
  }
}
