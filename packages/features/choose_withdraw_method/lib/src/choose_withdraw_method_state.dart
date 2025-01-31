part of 'choose_withdraw_method_cubit.dart';

class ChooseWithdrawMethodState extends Equatable {
  const ChooseWithdrawMethodState({
    this.paymentMethods,
    this.paymentMethodsLoadingStatus = LoadingStatus.initial,
  });

  final PaymentMethods? paymentMethods;
  final LoadingStatus paymentMethodsLoadingStatus;

  ChooseWithdrawMethodState copyWith({
    PaymentMethods? paymentMethods,
    LoadingStatus? paymentMethodsLoadingStatus,
  }) {
    return ChooseWithdrawMethodState(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      paymentMethodsLoadingStatus:
          paymentMethodsLoadingStatus ?? this.paymentMethodsLoadingStatus,
    );
  }

  @override
  List<Object?> get props => [
        paymentMethods,
        paymentMethodsLoadingStatus,
      ];
}

enum LoadingStatus { initial, loading, success, failure } 