import 'profile_localizations.dart';

/// The translations for English (`en`).
class ProfileLocalizationsEn extends ProfileLocalizations {
  ProfileLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Profile';

  @override
  String get myProfileTileTitle => 'My Profile';

  @override
  String get greetingTileTitle => 'Hello';

  @override
  String get settingsTileTitle => 'Settings';

  @override
  String get notificationsTileTitle => 'Notifications';

  @override
  String get infoTileTitle => 'Info';

  @override
  String get changeLanguageTileTitle => 'Language';

  @override
  String get logoutTileTitle => 'Logout';

  @override
  String get changePasswordTileTitle => 'Change Password';

  @override
  String get changePhoneTileTitle => 'Change Phone Number';
}
