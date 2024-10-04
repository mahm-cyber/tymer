import 'package:equatable/equatable.dart';

class RememberMe extends Equatable {
  const RememberMe({
    this.phone,
    this.password,
  });

  final String? phone;
  final String? password;

  @override
  List<Object?> get props => [
        phone,
        password,
      ];
}
