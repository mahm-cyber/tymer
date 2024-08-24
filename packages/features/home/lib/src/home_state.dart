part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState();



  HomeState copyWith() {
    return const HomeState(

    );
  }

  @override
  List<Object?> get props => [

      ];
}

enum HomeFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
