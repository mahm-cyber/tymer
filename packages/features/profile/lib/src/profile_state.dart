part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.logoutStatus = LogoutStatus.initial,
    this.user,
  });

  final LogoutStatus logoutStatus;
  final User? user;
  ProfileState copyWith({
    LogoutStatus? logoutStatus,
    User? user,
  }) {
    return ProfileState(
      logoutStatus: logoutStatus ?? this.logoutStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        logoutStatus,
        user,
      ];
}

enum LogoutStatus {
  initial,
  loading,
  success,
  failure,
}
