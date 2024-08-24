enum LocalePreferenceDM {
  english,
  arabic;

  String get kName =>
      this == LocalePreferenceDM.english ? 'EN - English' : 'AR - عربى';
}

LocalePreferenceDM strToLocalePreferenceDM(String str) {
  final localeInitials = str.split('_')[0];
  switch (localeInitials) {
    case 'ar':
      return LocalePreferenceDM.arabic;
    case 'en':
      return LocalePreferenceDM.english;
    default:
      return LocalePreferenceDM.english;
  }
}
