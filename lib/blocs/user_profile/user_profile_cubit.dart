import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/user_model.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileState.initial());

  Future<void> getProfile({required String uid}) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      //TODO: USER REPOSITORY MUST BE IMPLEMENTED, THEN UNCOMMENT THE FOLLOWING LINE
      // final User user = await profileRepository.getProfile(uid: uid);
      emit(
        state.copyWith(
          status: UserProfileStatus.success,
          // user: user,
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
