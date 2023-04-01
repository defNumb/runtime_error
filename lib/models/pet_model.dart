// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String species;
  final String breed;
  final String breed2;
  final String gender;
  final String birthDay;
  final String weight;
  final String healthConditions;
  final String neutered;
  final String referenceId;
  final String backgroundImage;

  Pet({
    required this.id,
    required this.name,
    required this.icon,
    required this.species,
    required this.breed,
    required this.breed2,
    required this.gender,
    required this.birthDay,
    required this.weight,
    required this.healthConditions,
    required this.neutered,
    required this.referenceId,
    required this.backgroundImage,
  });

  // Factory constructor to retrieve information from firebase
  factory Pet.fromDoc(DocumentSnapshot petDoc) {
    final petData = petDoc.data() as Map<String, dynamic>?;

    return Pet(
      id: petData!['id'] ?? '',
      name: petData['name'] ?? '',
      icon: petData['icon'] ?? '',
      species: petData['species'] ?? '',
      breed: petData['breed'] ?? '',
      breed2: petData['breed2'] ?? '',
      birthDay: petData['birthDay'] ?? '',
      weight: petData['weight'] ?? '',
      healthConditions: petData['healthConditions'] ?? '',
      neutered: petData['neutered'] ?? '',
      referenceId: petData['referenceId'] ?? '',
      backgroundImage: petData['background'] ?? '',
      gender: petData['gender'] ?? '',
    );
  }
  // constructor to set information to firebase
  Map<String, dynamic> toDoc(Pet pet, String id) {
    return <String, dynamic>{
      id: id,
      name: pet.name,
      icon: pet.icon,
      species: pet.species,
      breed: pet.breed,
      breed2: pet.breed2,
      birthDay: pet.birthDay,
      weight: pet.weight,
      healthConditions: pet.healthConditions,
      neutered: pet.neutered,
      referenceId: pet.referenceId,
      backgroundImage: pet.backgroundImage
    };
  }

  // Factory constructor to get pet intially that is not in firestore
  factory Pet.initialPet() {
    return Pet(
      id: '',
      name: '',
      icon: '',
      species: '',
      breed: '',
      breed2: '',
      birthDay: '',
      weight: '',
      healthConditions: '',
      neutered: '',
      referenceId: '',
      backgroundImage: '',
      gender: '',
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      icon,
      species,
      breed,
      breed2,
      gender,
      birthDay,
      weight,
      healthConditions,
      neutered,
      referenceId,
      backgroundImage,
    ];
  }

  @override
  bool get stringify => true;
}
