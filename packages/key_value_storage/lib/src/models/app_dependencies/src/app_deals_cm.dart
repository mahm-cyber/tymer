import 'package:hive/hive.dart';
import 'package:key_value_storage/src/models/app_dependencies/src/deal_cm.dart';

part 'app_deals_cm.g.dart';

@HiveType(typeId: 4)
class AppDealsCM {
  const AppDealsCM({

    required this.list,

  });


  @HiveField(2)
  final List<DealCM>  list;


}
