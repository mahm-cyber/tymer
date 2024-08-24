import 'package:equatable/equatable.dart';

class CityDM extends Equatable {
  final int id;
  final String name;

  const CityDM({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
