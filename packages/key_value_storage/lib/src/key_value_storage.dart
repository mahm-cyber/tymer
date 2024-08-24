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
  static const _lowFreqAppDepBoxKey = 'low-freq-app-dep';
  static const _appUsersBoxKey = 'app-users';
  static const _appTasksBoxKey = 'app-tasks';
  static const _appContactsBoxKey = 'app-contacts';
  static const _appDealsBoxKey = 'app-deals';
  static const _appCompaniesBoxKey = 'app-companies';

  KeyValueStorage() : _hive = Hive {
    try {
      _hive
        ..registerAdapter(LocalePreferenceCMAdapter())
        ..registerAdapter(LowFrequencyAppDependenciesCMAdapter())
        ..registerAdapter(AppUsersCMAdapter())
        ..registerAdapter(AppTasksCMAdapter())
        ..registerAdapter(AppDealsCMAdapter())
        ..registerAdapter(AppContactsCMAdapter())
        ..registerAdapter(AppCompaniesCMAdapter())
        ..registerAdapter(UserCMAdapter())
        ..registerAdapter(TaskCMAdapter())
        ..registerAdapter(DealCMAdapter())
        ..registerAdapter(ContactCMAdapter())
        ..registerAdapter(CustomFieldCMAdapter())
        ..registerAdapter(CustomFieldTypeCMAdapter())
        ..registerAdapter(LifeCyclesCMAdapter())
        ..registerAdapter(CompanyCMAdapter())
        ..registerAdapter(DealStageCMAdapter());
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

  Future<Box<LowFrequencyAppDependenciesCM>> get lowFreqAppDepBoxKey =>
      _openHiveBox<LowFrequencyAppDependenciesCM>(
        _lowFreqAppDepBoxKey,
        isTemporary: false,
      );

  Future<Box<AppUsersCM>> get appUsersBoxKey => _openHiveBox<AppUsersCM>(
        _appUsersBoxKey,
        isTemporary: false,
      );

  Future<Box<AppTasksCM>> get appTasksBoxKey => _openHiveBox<AppTasksCM>(
        _appTasksBoxKey,
        isTemporary: false,
      );

  Future<Box<AppContactsCM>> get appContactsBoxKey =>
      _openHiveBox<AppContactsCM>(
        _appContactsBoxKey,
        isTemporary: false,
      );

  Future<Box<AppDealsCM>> get appDealsBoxKey => _openHiveBox<AppDealsCM>(
        _appDealsBoxKey,
        isTemporary: false,
      );

  Future<Box<AppCompaniesCM>> get appCompaniesBoxKey =>
      _openHiveBox<AppCompaniesCM>(
        _appCompaniesBoxKey,
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
