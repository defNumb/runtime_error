import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/favorite_model.dart';
import '../../repositories/favorites_repository.dart';

part 'favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState> {
  final FavoriteRepository favoriteRepository;
  FavoriteListCubit({required this.favoriteRepository}) : super(FavoriteListState.initial());

  Future<void> getFavorites({required String uid}) async {
    emit(state.copyWith(status: FavoriteListStatus.loading));
    try {
      final favoriteList = await favoriteRepository.getFavorites();
      emit(
        state.copyWith(
          status: FavoriteListStatus.success,
          favorites: favoriteList,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: FavoriteListStatus.error,
          error: e,
        ),
      );
    }
  }

  Future<void> addFavorite({required Favorite favorite}) async {
    emit(state.copyWith(status: FavoriteListStatus.loading));
    try {
      await favoriteRepository.addFavorite(favorite);
      final favoriteList = await favoriteRepository.getFavorites();
      emit(
        state.copyWith(
          status: FavoriteListStatus.success,
          favorites: favoriteList,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: FavoriteListStatus.error,
          error: e,
        ),
      );
    }
  }

  Future<void> removeFavorite({required Favorite favorite}) async {
    emit(state.copyWith(status: FavoriteListStatus.loading));
    try {
      await favoriteRepository.removeFavorite(favorite);
      final favoriteList = await favoriteRepository.getFavorites();
      emit(
        state.copyWith(
          status: FavoriteListStatus.success,
          favorites: favoriteList,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: FavoriteListStatus.error,
          error: e,
        ),
      );
    }
  }
}
