// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_pet_cubit.dart';

enum SignupPetStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupPetState extends Equatable {
  final SignupPetStatus signupPetStatus;
  final CustomError error;
  SignupPetState({
    required this.signupPetStatus,
    required this.error,
  });

  factory SignupPetState.initial() {
    return SignupPetState(
      signupPetStatus: SignupPetStatus.initial,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [signupPetStatus, error];

  @override
  bool get stringify => true;

  SignupPetState copyWith({
    SignupPetStatus? signupPetStatus,
    CustomError? error,
  }) {
    return SignupPetState(
      signupPetStatus: signupPetStatus ?? this.signupPetStatus,
      error: error ?? this.error,
    );
  }
}
