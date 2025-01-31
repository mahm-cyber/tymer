part of 'top_up_confirmation_cubit.dart';

class TopUpConfirmationState extends Equatable {
  const TopUpConfirmationState({
    this.paymentMethods,
  });

  final PaymentMethods? paymentMethods;

  TopUpConfirmationState copyWith({
    PaymentMethods? paymentMethods,
  }) {
    return TopUpConfirmationState(
      paymentMethods: paymentMethods ?? this.paymentMethods,
    );
  }

  @override
  List<Object?> get props => [
        paymentMethods,
      ];
}
