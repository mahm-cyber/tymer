import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'tab_container_state.dart';

class TabContainerCubit extends Cubit<TabContainerState> {
  TabContainerCubit({
    required this.userRepository,
  }) : super(
          const TabContainerState(),
        );

  final UserRepository userRepository;

  Future onRefreshAppDependencies() async {
    final loadingAppDeps = state.copyWith(
      refreshAppDependenciesState: RefreshAppDependenciesState.inProgress,
    );
    emit(loadingAppDeps);
    try {
      final successAppDeps = state.copyWith(
        refreshAppDependenciesState: RefreshAppDependenciesState.success,
      );
      emit(successAppDeps);
    } catch (e) {
      final failureAppDeps = state.copyWith(
        refreshAppDependenciesState: RefreshAppDependenciesState.failure,
      );
      emit(failureAppDeps);
    }
  }

// @override
// Future<void> close() async {
//   return super.close();
// }
//   @override
//   Future<void> onChange(change) async {
//     print('+++++++${change.currentState.email}');
//     print('-------${change.nextState.email}');
//     super.onChange(change);
//   }
}
