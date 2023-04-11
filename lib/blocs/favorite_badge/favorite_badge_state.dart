// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'favorite_badge_cubit.dart';

class FavoriteBadgeState extends Equatable {
  final bool favorited;
  final String petName;
  FavoriteBadgeState({
    required this.favorited,
    required this.petName,
  });

  // initial
  factory FavoriteBadgeState.initial() {
    return FavoriteBadgeState(
      favorited: false,
      petName: '',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [favorited, petName];

  FavoriteBadgeState copyWith({
    bool? favorited,
    String? petName,
  }) {
    return FavoriteBadgeState(
      favorited: favorited ?? this.favorited,
      petName: petName ?? this.petName,
    );
  }
}
