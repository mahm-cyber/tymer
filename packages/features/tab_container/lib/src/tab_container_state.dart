part of 'tab_container_cubit.dart';

class TabContainerState extends Equatable {
  const TabContainerState({
    this.refreshAppDependenciesState = RefreshAppDependenciesState.initial,
  });

  final RefreshAppDependenciesState refreshAppDependenciesState;

  TabContainerState copyWith({
    RefreshAppDependenciesState? refreshAppDependenciesState,
  }) {
    return TabContainerState(
      refreshAppDependenciesState:
          refreshAppDependenciesState ?? this.refreshAppDependenciesState,
    );
  }

  @override
  List<Object?> get props => [
        refreshAppDependenciesState,
      ];
}

enum RefreshAppDependenciesState {
  initial,
  inProgress,
  success,
  failure,
}
