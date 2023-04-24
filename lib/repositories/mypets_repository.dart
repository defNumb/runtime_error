import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import '../constants/db_constants.dart';
import '../models/custom_error.dart';
import '../models/pet_model.dart';

// MY PETS REPOSITORY FOLLOWS THE SAME ACCESSING PATTERNS
// AS THE FAVORITES REPOSITORY, SO YOU CAN USE THE SAME
// LOGIC TO COMPLETE THE MY PETS REPOSITORY
// you can copy and paste the FavoriteRepository class and rename it to MyPetsRepository
// the pet model has already been created for you in lib\models\pet_model.dart
// the collection name is 'pets' and the document id is the pet id that you can get from the pet object
// when adding a new pet you need to create a new document with the pet id as the document id

class MyPetsRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  MyPetsRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Future<List<Pet>> getPets() async {
    try {
      // Get the current users unique ID.
      final uid = firebaseAuth.currentUser!.uid;

      // Pull up the firebase collection tied to the current users ID.
      final QuerySnapshot petList = await usersRef.doc(uid).collection('pets').get();

      if (petList.docs.isNotEmpty) {
        final petListData = petList.docs.map((petDoc) => Pet.fromDoc(petDoc)).toList();
        return petListData;
      } else {
        return [];
      }
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.getPets',
      );
    }
  }

// HOW TO CREATE A NEW DOCUMENT ID
// final petDoc = await usersRef.doc(uid).collection('pets');
// var randomDoc = petDoc.doc();
// from there you can access the randomly generated document id using randomDoc.id
// to pass that in when setting the data.
// setting data for a new pet example
// await petDoc.doc(randomDoc.id).set({
//  'id': randomDoc.id,
//  'name': pet.name,
//  'icon': pet.icon,
//  'species': pet.species,
//  'breed': pet.breed,
//  'breed2': pet.breed2,
//  'gender': pet.gender,
//  'birthDay': pet.birthDay,
//  'weight': pet.weight,
//  'healthConditions': pet.healthConditions,
//  'neutered': pet.neutered,
//  'backgroundImage': pet.backgroundImage,
//  'referenceId': uid,
//  },);

  Future<void> addPet(Pet pet) async {
    try {
      // Get the current users unique ID.
      final uid = firebaseAuth.currentUser!.uid;

      // Pull up the firebase collection tied to the current users ID.
      final petDoc = await usersRef.doc(uid).collection('pets');

      // Generate partial new document within that collection with a brand new ID.
      var randomDoc = petDoc.doc();

      // Create full document with 'pet' and the new ID and push it to firebase.
      await petDoc.doc(uid).set(
        {
          'id': randomDoc.id,
          'name': pet.name,
          'icon': pet.icon,
          'species': pet.species,
          'breed': pet.breed,
          'breed2': pet.breed2,
          'gender': pet.gender,
          'birthDay': pet.birthDay,
          'weight': pet.weight,
          'healthConditions': pet.healthConditions,
          'neutered': pet.neutered,
          'backgroundImage': pet.backgroundImage,
          'referenceId': uid,
        },
      );
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.getPets',
      );
    }
  } // End of addPet

  Future<void> removePet(petID) async {
    try {
      // Get the current users unique ID.
      final uid = firebaseAuth.currentUser!.uid;

      // Retrieve firebase record (collection) of that user's 'pets'.
      final QuerySnapshot petList = await usersRef.doc(uid).collection('pets').get();

      // Remove the pet from firebase with the ID value of 'petID'.
      petList.docChanges.remove(petID);
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.getPets',
      );
    }
  } // End of removePet
} // End of class MyPetsRepository