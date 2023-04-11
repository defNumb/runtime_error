import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_pets_app/repositories/favorites_repository.dart';

import '../../models/favorite_model.dart';

part 'favorite_badge_state.dart';

class FavoriteBadgeCubit extends Cubit<FavoriteBadgeState> {
  final FavoriteRepository favoriteRepository;
  FavoriteBadgeCubit({required this.favoriteRepository}) : super(FavoriteBadgeState.initial());

  Future<void> addFavorite({required Favorite favorite}) async {
    try {
      await favoriteRepository.addFavorite(favorite);
      emit(state.copyWith(favorited: true, petName: favorite.name));
    } catch (e) {
      emit(
        state.copyWith(
          favorited: false,
        ),
      );
    }
  }

  Future<void> removeFavorite({required Favorite favorite}) async {
    try {
      await favoriteRepository.removeFavorite(favorite.name);
      emit(
        state.copyWith(
          favorited: false,
          petName: favorite.name,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        favorited: false,
        petName: favorite.name,
      ));
    }
  }

  Future<void> checkFavorite(name) async {
    try {
      final favorited = await favoriteRepository.isFavorite(fid: name);
      if (favorited == true) {
        emit(
          state.copyWith(
            favorited: true,
            petName: name,
          ),
        );
      } else {
        emit(
          state.copyWith(
            favorited: false,
            petName: name,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          favorited: false,
          petName: name,
        ),
      );
    }
  }
}
