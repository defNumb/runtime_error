import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_pets_app/repositories/dog_api.dart';

import '../../models/cat_api_model.dart';
import '../../models/custom_error.dart';
import '../../models/dog_api_model.dart';
import '../../repositories/cat_api.dart';

part 'breed_provider_state.dart';

class BreedProviderCubit extends HydratedCubit<BreedProviderState> {
  final DogApiRepository dogApiRepository;
  final CatApiRepository catApiRepository;

  BreedProviderCubit({required this.dogApiRepository, required this.catApiRepository})
      : super(BreedProviderState.initial());

  void getDogBreeds() async {
    emit(state.copyWith(status: BreedProviderStatus.loading));
    try {
      final List<DogBreed> dogBreeds = await DogApiRepository().getDogBreeds();
      emit(
        state.copyWith(
          status: BreedProviderStatus.success,
          dogBreeds: dogBreeds,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: BreedProviderStatus.error,
          error: e,
        ),
      );
    }
  }

  void getCatBreeds() async {
    emit(state.copyWith(status: BreedProviderStatus.loading));
    try {
      final List<CatBreed> catBreeds = await catApiRepository.getCatBreeds();
      emit(
        state.copyWith(
          status: BreedProviderStatus.success,
          catBreeds: catBreeds,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: BreedProviderStatus.error,
          error: e,
        ),
      );
    }
  }

  @override
  BreedProviderState? fromJson(Map<String, dynamic> json) {
    return BreedProviderState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(BreedProviderState state) {
    return state.toMap();
  }
}
