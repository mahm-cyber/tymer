import 'package:equatable/equatable.dart';

class RememberMe extends Equatable {
  const RememberMe({
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
