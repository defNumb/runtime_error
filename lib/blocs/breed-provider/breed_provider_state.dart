// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'breed_provider_cubit.dart';

enum BreedProviderStatus { initial, loading, success, error }

class BreedProviderState extends Equatable {
  final BreedProviderStatus status;
  final List<DogBreed> dogBreeds;
  final List<CatBreed> catBreeds;
  final CustomError error;
  BreedProviderState({
    required this.status,
    required this.dogBreeds,
    required this.catBreeds,
    required this.error,
  });
  // initial state
  factory BreedProviderState.initial() {
    return BreedProviderState(
      status: BreedProviderStatus.initial,
      dogBreeds: [],
      catBreeds: [],
      error: CustomError(),
    );
  }
  @override
  List<Object> get props => [status, dogBreeds, catBreeds, error];

  @override
  bool get stringify => true;

  BreedProviderState copyWith({
    BreedProviderStatus? status,
    List<DogBreed>? dogBreeds,
    List<CatBreed>? catBreeds,
    CustomError? error,
  }) {
    return BreedProviderState(
      status: status ?? this.status,
      dogBreeds: dogBreeds ?? this.dogBreeds,
      catBreeds: catBreeds ?? this.catBreeds,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status == BreedProviderStatus.initial
          ? 'initial'
          : status == BreedProviderStatus.loading
              ? 'loading'
              : status == BreedProviderStatus.success
                  ? 'success'
                  : 'error',
      'dogBreeds': dogBreeds.map((x) => x.toJson()).toList(),
      'catBreeds': catBreeds.map((x) => x.toJson()).toList(),
      'error': error.toMap(),
    };
  }

  factory BreedProviderState.fromMap(Map<String, dynamic> map) {
    return BreedProviderState(
      status: map['status'] == 'initial'
          ? BreedProviderStatus.initial
          : map['status'] == 'loading'
              ? BreedProviderStatus.loading
              : map['status'] == 'success'
                  ? BreedProviderStatus.success
                  : BreedProviderStatus.error,
      dogBreeds: List<DogBreed>.from(
        (map['dogBreeds'] as List<int>).map<DogBreed>(
          (x) => DogBreed.fromJson(x as Map<String, dynamic>),
        ),
      ),
      catBreeds: List<CatBreed>.from(
        (map['catBreeds'] as List<int>).map<CatBreed>(
          (x) => CatBreed.fromJson(x as Map<String, dynamic>),
        ),
      ),
      error: CustomError.fromMap(map['error'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory BreedProviderState.fromJson(String source) =>
      BreedProviderState.fromMap(json.decode(source) as Map<String, dynamic>);
}
