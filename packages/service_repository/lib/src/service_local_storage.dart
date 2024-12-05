import 'package:key_value_storage/key_value_storage.dart';

class ServiceLocalStorage {
  ServiceLocalStorage({
    required this.noSqlStorage,
  });

  final KeyValueStorage noSqlStorage;
}
