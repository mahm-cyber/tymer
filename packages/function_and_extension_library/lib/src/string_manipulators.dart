import 'dart:ui';

import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart';

final _arabicNumbers = [
  '٠',
  '١',
  '٢',
  '٣',
  '٤',
  '٥',
  '٦',
  '٧',
  '٨',
  '٩',
];

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeFirstOfEach() {
    final capitalizedSentence =
        split(' ').map((str) => str.capitalize()).toList().join(' ');
    return capitalizedSentence;
  }

  String toEnglishNumber() {
    final Map<String, String> numeralMap = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    return split('').map((e) => numeralMap[e] ?? e).join();
  }
}

extension IntToArabic on int? {
  String toArabicStrNumber() {
    return toString()
        .split('')
        .map((latinNumber) => _arabicNumbers[int.parse(latinNumber)])
        .join();
  }
}

extension NumberEnglishToArabic on String {
  String toArabicStrNumber() {
    return split('')
        .map((latinNumber) => _arabicNumbers[int.parse(latinNumber)])
        .join();
  }
}

extension DoubleToArabic on double? {
  String toArabicStrNumber() {
    return toString()
        .split('')
        .map((latinNumberString) => int.tryParse(latinNumberString) == null
            ? latinNumberString == '.'
                ? ','
                : latinNumberString // if it's not a number, return it as is
            : _arabicNumbers[int.parse(latinNumberString)])
        .join();
  }
}

extension EnglishTimeToArabicTime on String {
  // "09:00" should be "٠٩:٠٠ ص"
  // "18:00" should be "٠٦:٠٠ م"

  String convertToArabicTime() {
    List<String> parts = split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Convert minutes to Arabic digits
    String arabicMinutes = minutes.toArabicStrNumber();

    // Determine if it's AM or PM
    String period = (hours < 12) ? 'ص' : 'م';

    // Adjust hours for PM time
    if (hours > 12) {
      hours -= 12;
    }

    // Convert adjusted hours to Arabic digits
    String arabicAdjustedHours = hours.toArabicStrNumber();

    // Construct Arabic time string
    String arabicTime = '$arabicAdjustedHours:$arabicMinutes $period';

    return arabicTime;
  }
}

extension EnglishDateToArabicDate on String {
  String toArabicMonth() {
    return arabicMonths[this] ?? '';
  }

  String convertEnglishDateToArabic() {
    // convert date of the format |2024-03-29| to arabic
    final splitDate = split('-');
    final year = int.parse(splitDate[0]).toArabicStrNumber();
    final month = splitDate[1].toArabicMonth();
    final day = int.parse(splitDate[2]).toArabicStrNumber();

    return '$day $month $year';
  }
}

extension StringArabicOrNot on String {
  bool isArabic() {
    for (int i = 0; i < length; i++) {
      int charCode = codeUnitAt(i);
      // Check if the character falls within the Unicode range of Arabic characters
      if (charCode >= 0x0600 && charCode <= 0x06FF) {
        return true; // Arabic character found
      }
    }
    return false; // No Arabic character found
  }
}

extension DateTimeToString on DateTime {
  String convertToTymerCompliantString() => '$year-$month-$day';

  String convertToTimestamp() => (millisecondsSinceEpoch ~/ 1000).toString();
}

DateTime? timestampToDateTime(String? date) {
  try {
    final isNormalDate = date != null && date.contains('-') && date.length < 11;

    final dateDM = date == null || date.isEmpty == true
        ? null
        : isNormalDate
            ? DateTime(
                int.parse(date.split('-')[0]), // year
                int.parse(date.split('-')[1]), // month
                int.parse(date.split('-')[2]) // day
                )
            : DateTime.fromMillisecondsSinceEpoch(int.parse(date) * 1000);
    return dateDM;
  } catch (e) {
    rethrow;
  }
}

String replaceSpacesWithUnderscores(String input) {
  return input.replaceAll(' ', '_');
}

String removeFirstThreeChars(String input) {
  if (input.length <= 3) {
    return '';
  }
  return input.substring(3);
}

extension CleanHtmlString on String {
  String cleanHtml() {
    final stringWithoutReturnsOrNewlines = replaceAll(RegExp(r'[\r\n]'), '');
    final cleanString = Bidi.stripHtmlIfNeeded(stringWithoutReturnsOrNewlines)
        .trim()
        .replaceAll(RegExp(r' $'), '');
    return cleanString;
  }
}

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}