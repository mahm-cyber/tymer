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

  Future<void> upsertLowFrequencyAppDependenciesCM(
      LowFrequencyAppDependenciesCM lowFreqAppDependencies) async {
    final box = await noSqlStorage.lowFreqAppDepBoxKey;
    await box.put(0, lowFreqAppDependencies);
  }

  Future<LowFrequencyAppDependenciesCM?> getLowFreqAppDep() async {
    final box = await noSqlStorage.lowFreqAppDepBoxKey;
    return box.get(0);
  }

  void deleteLowFreqAppDependencies() async {
    final box = await noSqlStorage.lowFreqAppDepBoxKey;
    box.clear();
  }

  Future<void> upsertAppUsersCM(AppUsersCM appUsers) async {
    final box = await noSqlStorage.appUsersBoxKey;
    await box.put(0, appUsers);
  }

  Future<AppUsersCM?> getAppUsers() async {
    final box = await noSqlStorage.appUsersBoxKey;
    return box.get(0);
  }

  void deleteAppUsers() async {
    final box = await noSqlStorage.appUsersBoxKey;
    box.clear();
  }

  Future<void> upsertAppTasksCM(AppTasksCM appTasks) async {
    final box = await noSqlStorage.appTasksBoxKey;
    await box.put(0, appTasks);
  }

  Future<AppTasksCM?> getAppTasks() async {
    final box = await noSqlStorage.appTasksBoxKey;
    return box.get(0);
  }

  void deleteAppTasks() async {
    final box = await noSqlStorage.appTasksBoxKey;
    box.clear();
  }

  Future<void> upsertAppContactsCM(AppContactsCM appContacts) async {
    final box = await noSqlStorage.appContactsBoxKey;
    await box.put(0, appContacts);
  }

  Future<AppContactsCM?> getAppContacts() async {
    final box = await noSqlStorage.appContactsBoxKey;
    return box.get(0);
  }

  void deleteAppContacts() async {
    final box = await noSqlStorage.appContactsBoxKey;
    box.clear();
  }

  Future<void> upsertAppDealsCM(AppDealsCM appDeals) async {
    final box = await noSqlStorage.appDealsBoxKey;
    await box.put(0, appDeals);
  }

  Future<AppDealsCM?> getAppDeals() async {
    final box = await noSqlStorage.appDealsBoxKey;
    return box.get(0);
  }

  void deleteAppDeals() async {
    final box = await noSqlStorage.appDealsBoxKey;
    box.clear();
  }

  Future<void> upsertAppCompaniesCM(AppCompaniesCM appCompanies) async {
    final box = await noSqlStorage.appCompaniesBoxKey;
    await box.put(0, appCompanies);
  }

  Future<AppCompaniesCM?> getAppCompanies() async {
    final box = await noSqlStorage.appCompaniesBoxKey;
    return box.get(0);
  }

  void deleteAppCompanies() async {
    final box = await noSqlStorage.appCompaniesBoxKey;
    box.clear();
  }
}
