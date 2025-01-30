part of 'top_up_information_cubit.dart';

class TopUpInformationState extends Equatable {
  const TopUpInformationState({
    this.paymentMethods,
  });

  final PaymentMethods? paymentMethods;

  TopUpInformationState copyWith({
    PaymentMethods? paymentMethods,
  }) {
    return TopUpInformationState(
      paymentMethods: paymentMethods ?? this.paymentMethods,
    );
  }

  @override
  List<Object?> get props => [
        paymentMethods,
      ];
}
