// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'user_profile_cubit.dart';

enum UserProfileStatus { initial, loading, success, error }

class UserProfileState extends Equatable {
  final UserProfileStatus status;
  final User user;
  final CustomError error;

  UserProfileState({
    required this.status,
    required this.user,
    required this.error,
  });

  // initial state
  factory UserProfileState.initial() {
    return UserProfileState(
      status: UserProfileStatus.initial,
      user: User.initialUser(),
      error: CustomError(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, user, error];

  UserProfileState copyWith({
    UserProfileStatus? status,
    User? user,
    CustomError? error,
  }) {
    return UserProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
