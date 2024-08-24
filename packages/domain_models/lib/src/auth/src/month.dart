
enum Month {
  jan,
  feb,
  mar,
  apr,
  may,
  jun,
  jul,
  aug,
  sep,
  oct,
  nov,
  dec;

  String arabicName() {
    switch (this) {
      case jan:
        return 'يناير';
      case feb:
        return 'فبراير';
      case mar:
        return 'مارس';
      case apr:
        return 'أبريل';
      case may:
        return 'مايو';
      case jun:
        return 'يونيو';
      case jul:
        return 'يوليو';
      case aug:
        return 'أغسطس';
      case sep:
        return 'سبتمبر';
      case oct:
        return 'أكتوبر';
      case nov:
        return 'نوفمبر';
      case dec:
        return 'ديسمبر';
      default:
        return 'Invalid month number';
    }
  }
}

Map<String, String> arabicMonths = {
  '01': Month.jan.arabicName(),
  '02': Month.feb.arabicName(),
  '03': Month.mar.arabicName(),
  '04': Month.apr.arabicName(),
  '05': Month.may.arabicName(),
  '06': Month.jun.arabicName(),
  '07': Month.jul.arabicName(),
  '08': Month.aug.arabicName(),
  '09': Month.sep.arabicName(),
  '10': Month.oct.arabicName(),
  '11': Month.nov.arabicName(),
  '12': Month.dec.arabicName()
};

