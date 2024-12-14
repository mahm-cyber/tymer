import 'package:key_value_storage/key_value_storage.dart';

class UserLocalStorage {
  UserLocalStorage({
    required this.noSqlStorage,
  });

  final KeyValueStorage noSqlStorage;

  Future<void> upsertLocalePreference(LocalePreferenceCM preference) async {
    final box = await noSqlStorage.localePreferenceBox;
    await box.put(0, preference);
  }

  Future<LocalePreferenceCM?> getLocalePreference() async {
    final box = await noSqlStorage.localePreferenceBox;
    return box.get(0);
  }

  Future<void> upsertReservationServiceTypes(
      ReservationServiceTypesCM reservationServiceTypes) async {
    final box = await noSqlStorage.reservationServiceTypesBox;
    await box.put(0, reservationServiceTypes);
  }

  Future<ReservationServiceTypesCM?> getReservationServiceTypes() async {
    final box = await noSqlStorage.reservationServiceTypesBox;
    return box.get(0);
  }

  Future<void> upsertPricingSettings(PricingSettingsCM pricingSettings) async {
    final box = await noSqlStorage.pricingSettingsBoxKey;
    await box.put(0, pricingSettings);
  }

  Future<PricingSettingsCM?> getPricingSettings() async {
    final box = await noSqlStorage.pricingSettingsBoxKey;
    return box.get(0);
  }
}
