part of 'favorite_list_cubit.dart';

enum FavoriteListStatus { initial, loading, success, error }

class FavoriteListState extends Equatable {
  final FavoriteListStatus status;
  final List<Favorite> favorites;
  final CustomError error;

  FavoriteListState({
    required this.status,
    required this.favorites,
    required this.error,
  });

  // initial state
  factory FavoriteListState.initial() {
    return FavoriteListState(
      status: FavoriteListStatus.initial,
      favorites: const [],
      error: CustomError(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, favorites, error];

  FavoriteListState copyWith({
    FavoriteListStatus? status,
    List<Favorite>? favorites,
    CustomError? error,
  }) {
    return FavoriteListState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      error: error ?? this.error,
    );
  }
}
