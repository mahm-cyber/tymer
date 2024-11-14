import 'package:flutter/material.dart';

extension FormatedDateTime on DateTime {
  String get formattedDate {
    //if day or month are less than 10 add 0 at the beignning
    final day = this.day < 10 ? '0${this.day}' : '${this.day}';
    final month = this.month < 10 ? '0${this.month}' : '${this.month}';
    final year = this.year;
    return '$year-$month-$day';
  }


}

extension FormattedTimeOfDay on TimeOfDay {
  String get twelveHrFormat {
    //if hour or minute are less than 10 add 9 at the beignning
    // final hour = this.hour < 10 ? '0${this.hour}' : '${this.hour}';
    final minute = this.minute < 10 ? '0${this.minute}' : '${this.minute}';
    // convert to 12 hr format and add am or pm
    final formattedHour = hour > 12 ? hour - 12 : hour;
    final amOrPm = hour > 12 ? 'pm' : 'am';
    return '$formattedHour:$minute $amOrPm';
  }

  String get twentyFourHrFormat {
    //if hour or minute are less than 10 add 9 at the beignning
    final hour = this.hour < 10 ? '0${this.hour}' : '${this.hour}';
    final minute = this.minute < 10 ? '0${this.minute}' : '${this.minute}';
    return '$hour:$minute:00';
  }
}