import 'package:json_annotation/json_annotation.dart';

part 'add_activity_rm.g.dart';


@JsonSerializable(createFactory: false)
class AddActivityRM {
  const AddActivityRM({
    required this.name,
    this.description,
    this.date,
    required this.logType,
    this.contactId,
    this.companyName,
    this.dealName,
    this.taskId,
  });

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'date', includeIfNull: false)
  final String? date;
  @JsonKey(name: 'typeName')
  final String logType;
  @JsonKey(name: 'contactId', includeIfNull: false)
  final String? contactId;
  @JsonKey(name: 'companyId', includeIfNull: false)
  final String? companyName;
  @JsonKey(name: 'deal', includeIfNull: false)
  final String? dealName;
  @JsonKey(name: 'task_id', includeIfNull: false)
  final String? taskId;

  Map<String, dynamic> toJson() => _$AddActivityRMToJson(this);
}
