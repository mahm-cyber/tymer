import 'package:json_annotation/json_annotation.dart';

part 'associated_module_rm.g.dart';

@JsonSerializable(createToJson: false)
class AssociatedModuleRM {
  AssociatedModuleRM({
    required this.termId,
    required this.name,
  });

  @JsonKey(name: 'term_id')
  final int termId;
  @JsonKey(name: 'name')
  final String name;

  static const fromJson = _$AssociatedModuleRMFromJson;
}
