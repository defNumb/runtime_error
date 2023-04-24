import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/user_model.dart';
import '../../repositories/profile_repository.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  // profile repository
  final ProfileRepository profileRepository;
  UserProfileCubit({required this.profileRepository}) : super(UserProfileState.initial());

  Future<void> getProfile({required String uid}) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      final User user = await profileRepository.getProfile(uid: uid);
      emit(
        state.copyWith(
          status: UserProfileStatus.success,
          user: user,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: UserProfileStatus.error,
          error: e,
        ),
      );
    }
  }

  // update user info
  Future<void> updateProfile(
    String uid,
    String name,
    String lastName,
    String phoneNumber,
    String email,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      await profileRepository.updateProfile(uid, name, lastName, phoneNumber, email);
      // get updated user
      final User user = await profileRepository.getProfile(uid: uid);
      emit(
        state.copyWith(
          status: UserProfileStatus.success,
          user: user,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: UserProfileStatus.error,
          error: e,
        ),
      );
    }
  }
}
