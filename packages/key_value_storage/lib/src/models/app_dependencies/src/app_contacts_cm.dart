import 'package:hive/hive.dart';
import 'package:key_value_storage/src/models/app_dependencies/src/contact_cm.dart';

part 'app_contacts_cm.g.dart';

@HiveType(typeId: 3)
class AppContactsCM {
  const AppContactsCM({

    required this.list,
  });


  @HiveField(3)
  final List<ContactCM>  list;


}
