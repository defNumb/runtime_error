part of 'pet_list_cubit.dart';

enum PetListStatus {
  initial,
  loading,
  loaded,
  updated,
  error,
}

class PetListState extends Equatable {
  final PetListStatus listStatus;
  final List<Pet> petList;
  final CustomError error;
  PetListState({
    required this.listStatus,
    required this.petList,
    required this.error,
  });

  factory PetListState.initial() {
    return PetListState(
      listStatus: PetListStatus.initial,
      petList: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [listStatus, petList, error];

  @override
  bool get stringify => true;

  PetListState copyWith({
    PetListStatus? listStatus,
    List<Pet>? petList,
    CustomError? error,
  }) {
    return PetListState(
      listStatus: listStatus ?? this.listStatus,
      petList: petList ?? this.petList,
      error: error ?? this.error,
    );
  }
}
