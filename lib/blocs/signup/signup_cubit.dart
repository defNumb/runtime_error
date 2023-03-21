import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;

  SignupCubit({
    required this.authRepository,
  }) : super(SignupState.initial());

// SIGN UP METHOD
  Future<void> signup({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signupStatus: SignupStatus.submitting));

    try {
      await authRepository.signup(
        name: name,
        lastName: lastName,
        email: email,
        password: password,
      );
      emit(state.copyWith(signupStatus: SignupStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          signupStatus: SignupStatus.error,
          error: e,
        ),
      );
    }
  }

  // Convert anonymous user to a permanent user
  Future<void> convertAnonymousUser({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signupStatus: SignupStatus.submitting));

    try {
      await authRepository.convertAnonymousUser(
        name: name,
        lastName: lastName,
        email: email,
        password: password,
      );
      emit(state.copyWith(signupStatus: SignupStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          signupStatus: SignupStatus.error,
          error: e,
        ),
      );
    }
  }
}
