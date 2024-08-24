import 'package:key_value_storage/key_value_storage.dart';

part 'low_frequency_app_dependencies_cm.g.dart';

@HiveType(typeId: 10)
class LowFrequencyAppDependenciesCM {
  const LowFrequencyAppDependenciesCM({
    required this.jobTitles,
    required this.stages,
    required this.priorities,
    required this.lifeCycles,
    required this.status,
    required this.contactCustomFields,
    required this.dealCustomFields,
    required this.companyCustomFields,
  });

  @HiveField(0)
  final List<String> jobTitles;
  @HiveField(1)
  final List<DealStageCM> stages;
  @HiveField(2)
  final List<String> priorities;
  @HiveField(3)
  final LifeCyclesCM lifeCycles;
  @HiveField(4)
  final List<String> status;
  @HiveField(5)
  final List<CustomFieldCM> contactCustomFields;
  @HiveField(6)
  final List<CustomFieldCM> dealCustomFields;
  @HiveField(7)
  final List<CustomFieldCM> companyCustomFields;
}
