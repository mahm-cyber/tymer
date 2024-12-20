import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

extension FormatedDateTime on DateTime {
  String get formattedDate {
    //if day or month are less than 10 add 0 at the beignning
    final day = this.day < 10 ? '0${this.day}' : '${this.day}';
    final month = this.month < 10 ? '0${this.month}' : '${this.month}';
    final year = this.year;
    return '$year-$month-$day';
  }

  String? formatDateTimeTo12Hour() {
    // Extract hour and minute
    int hour = this.hour;
    int minute = this.minute;

    // Determine AM or PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    int twelveHour = hour % 12;
    twelveHour = twelveHour == 0 ? 12 : twelveHour; // Handle 12 AM/PM

    // Format minute to always be two digits
    String formattedMinute = minute.toString().padLeft(2, '0');

    return '$twelveHour:$formattedMinute $period';
  }
}

extension FormattedTimeOfDay on TimeOfDay {
  String get twelveHrFormat {
    //if hour or minute are less than 10 add 9 at the beignning
    // final hour = this.hour < 10 ? '0${this.hour}' : '${this.hour}';
    final minute = this.minute < 10 ? '0${this.minute}' : '${this.minute}';
    // convert to 12 hr format and add am or pm
    final formattedHour = hour > 12 ? hour - 12 : hour;
    final amOrPm = hour > 12 ? 'PM' : 'AM';
    return '$formattedHour:$minute $amOrPm';
  }

  String get twelveHrFormatArabic {
    //if hour or minute are less than 10 add 9 at the beignning
    // final hour = this.hour < 10 ? '0${this.hour}' : '${this.hour}';
    final minute = this.minute < 10 ? '0${this.minute}' : '${this.minute}';
    // convert to 12 hr format and add am or pm
    final formattedHour = hour > 12 ? hour - 12 : hour;
    final formattedHourArabic = formattedHour.latinNumberToArabicString();
    final minuteArabic = int.parse(minute).latinNumberToArabicString();
    final amOrPm = hour > 12 ? 'م' : 'ص';
    return '$minuteArabic:$formattedHourArabic $amOrPm';
  }

  String localizedTimeOfDay(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    return isArabic ? twelveHrFormatArabic : twelveHrFormat;
  }

  String get twentyFourHrFormat {
    //if hour or minute are less than 10 add 9 at the beignning
    final hour = this.hour < 10 ? '0${this.hour}' : '${this.hour}';
    final minute = this.minute < 10 ? '0${this.minute}' : '${this.minute}';
    return '$hour:$minute:00';
  }
}
