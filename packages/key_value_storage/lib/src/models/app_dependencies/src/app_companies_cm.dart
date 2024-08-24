import 'package:hive/hive.dart';
import 'package:key_value_storage/src/models/app_dependencies/src/company_cm.dart';

part 'app_companies_cm.g.dart';

@HiveType(typeId: 2)
class AppCompaniesCM {
  const AppCompaniesCM({
    required this.list,
  });

  @HiveField(0)
  final List<CompanyCM> list;
}
