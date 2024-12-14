import 'package:key_value_storage/key_value_storage.dart';
import 'package:path_provider/path_provider.dart';

/// Wraps [Hive] so that we can register all adapters and manage all keys in a
/// single place.
///
/// To use this class, simply unwrap one of its exposed boxes, like
/// [quoteListPageBox], and execute operations in it, for example:
///
/// ```
/// (await quoteListPageBox).clear();
/// ```
///
/// Storing non-primitive types in Hive requires us to use incremental [typeId]s.
/// Having all these models and boxes' keys in a single package allows us to
/// avoid conflicts.
class KeyValueStorage {
  static const _localePreferenceBoxKey = 'locale-preference';
  static const _reservationTypesBoxKey = 'reservation-service-types';
  static const _pricingSettingsBoxKey = 'pricing-settings';

  KeyValueStorage() : _hive = Hive {
    try {
      _hive
        ..registerAdapter(ReservationServiceTypeCMAdapter())
        ..registerAdapter(ReservationServiceTypesCMAdapter())
        ..registerAdapter(NameCMAdapter())
        ..registerAdapter(PricingSettingsCMAdapter())
        ..registerAdapter(LocalePreferenceCMAdapter());
    } catch (error) {
      throw Exception(error);
    }
  }

  final HiveInterface _hive;

  Future<Box<LocalePreferenceCM>> get localePreferenceBox =>
      _openHiveBox<LocalePreferenceCM>(
        _localePreferenceBoxKey,
        isTemporary: false,
      );

  Future<Box<ReservationServiceTypesCM>> get reservationServiceTypesBox =>
      _openHiveBox<ReservationServiceTypesCM>(
        _reservationTypesBoxKey,
        isTemporary: false,
      );

  Future<Box<PricingSettingsCM>> get pricingSettingsBoxKey =>
      _openHiveBox<PricingSettingsCM>(
        _pricingSettingsBoxKey,
        isTemporary: false,
      );

  Future<Box<T>> _openHiveBox<T>(
    String boxKey, {
    required bool isTemporary,
  }) async {
    if (_hive.isBoxOpen(boxKey)) {
      return _hive.box(boxKey);
    } else {
      final directory = await (isTemporary
          ? getTemporaryDirectory()
          : getApplicationDocumentsDirectory());
      return _hive.openBox<T>(
        boxKey,
        path: directory.path,
      );
    }
  }
}
