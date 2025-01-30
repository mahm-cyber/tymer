part of 'choose_top_up_method_cubit.dart';

class ChooseTopUpMethodState extends Equatable {
  const ChooseTopUpMethodState({
    this.paymentMethods,
    this.paymentMethodsLoadingStatus = LoadingStatus.initial,
  });

  final PaymentMethods? paymentMethods;
  final LoadingStatus paymentMethodsLoadingStatus;

  ChooseTopUpMethodState copyWith({
    PaymentMethods? paymentMethods,
    LoadingStatus? paymentMethodsLoadingStatus,
  }) {
    return ChooseTopUpMethodState(
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
