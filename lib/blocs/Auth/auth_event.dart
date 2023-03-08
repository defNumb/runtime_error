// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChangedEvent extends AuthEvent {
  final fbAuth.User? user;
  AuthStateChangedEvent({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}

class SignoutRequestedEvent extends AuthEvent {}

class DeleteAccountRequestedEvent extends AuthEvent {
  final String password;
  DeleteAccountRequestedEvent({
    required this.password,
  });

  @override
  List<Object?> get props => [password];
}
