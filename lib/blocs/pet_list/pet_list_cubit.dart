import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/pet_model.dart';
import '../../repositories/mypets_repository.dart';

part 'pet_list_state.dart';

class PetListCubit extends Cubit<PetListState> {
  final MyPetsRepository petRepository;
  PetListCubit({required this.petRepository}) : super(PetListState.initial());

  // Get pet list
  Future<List<Pet>> getPetList({required String uid}) async {
    try {
      final List<Pet> petList = await petRepository.getPets();
      emit(
        state.copyWith(
          listStatus: PetListStatus.loaded,
          petList: petList,
        ),
      );
      return petList;
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: PetListStatus.error,
          error: e,
        ),
      );
      return [];
    }
  }

  // Update pet list
  void updatePetList({required String uid}) async {
    try {
      final List<Pet> petList = await petRepository.getPets();
      emit(
        state.copyWith(
          listStatus: PetListStatus.updated,
          petList: petList,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: PetListStatus.error,
          error: e,
        ),
      );
    }
  }
}
