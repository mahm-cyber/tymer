import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeFirstOfEach() {
    final capitalizedSentence =
        split(' ').map((str) => str.capitalize()).toList().join(' ');
    return capitalizedSentence;
  }

  String cleanHtml() {
    final stringWithoutReturnsOrNewlines = replaceAll(RegExp(r'[\r\n]'), '');
    final cleanString = Bidi.stripHtmlIfNeeded(stringWithoutReturnsOrNewlines)
        .trim()
        .replaceAll(RegExp(r' $'), '');
    return cleanString;
  }

  DateTime? timestampToDateTime() {
    try {
      final isNormalDate = contains('-') && length < 11;

      final dateDM = isEmpty == true
          ? null
          : isNormalDate
              ? DateTime(
                  int.parse(split('-')[0]), // year
                  int.parse(split('-')[1]), // month
                  int.parse(split('-')[2]) // day
                  )
              : DateTime.fromMillisecondsSinceEpoch(int.parse(this) * 1000);
      return dateDM;
    } catch (e) {
      rethrow;
    }
  }

  //2024-12-24
  String localizeDateString(Locale locale) {
    //assert that string is in this format 2024-12-24
    assert(contains('-') && length < 11,
        'String must be in the format of yyyy-mm-dd');
    final isArabic = locale.languageCode == 'ar';
    final localizedDate = split('-').map((number) {
      final intNumber = int.parse(number);
      return isArabic ? NumberFormat('##', 'ar_EG').format(intNumber) : number;
    }).join('-');
    return localizedDate;
  }

  bool isFirstLetterArabic() {
    // Ensure the string is not empty
    if (isEmpty) {
      return false;
    }

    // Get the first character of the string
    String firstChar = this[0];

    // Check if the first character is an Arabic letter by comparing its Unicode value
    // Arabic letters are in the Unicode range: 0x0600 to 0x06FF
    int codeUnit = firstChar.codeUnitAt(0);
    return codeUnit >= 0x0600 && codeUnit <= 0x06FF;
  }
}

extension DoubleExtension on double {
  String localizeDouble(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    final localizedDouble =
        isArabic ? NumberFormat('#.##', 'ar_EG').format(this) : toStringAsFixed(0);
    return localizedDouble;
  }
}

extension IntExtension on int {
  String latinNumberToArabicString() {
    final arabicNumbers = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };
    return toString().split('').map((char) => arabicNumbers[char]!).join('');
  }

  String localizeInt(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    final localizedInt =
        isArabic ? NumberFormat('#', 'ar_EG').format(this) : toString();
    return localizedInt;
  }
}
