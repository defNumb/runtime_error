// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/db_constants.dart';
import '../models/custom_error.dart';
import '../models/favorite_model.dart';

class FavoriteRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  FavoriteRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  // before continuing with this file, complete the Favorite model in lib\models\favorite_model.dart - DONE
  // once Favorite model has been created replace the return type of getFavorites() with Future<List<Favorite>>
  // and return the correct data
  Future<List<Favorite>> getFavorites() async {
    try {
      // 1. get the current user id using FirebaseAuth.instance.currentUser!.uid assign it to a final variable named uid
      final uid = FirebaseAuth.instance.currentUser!.uid;
      // 2. create a new final variable of type QuerySnapshot named favoriteList and assign it to await usersRef.doc(uid).collection('favorites').get();
      final QuerySnapshot favoriteList = await usersRef.doc(uid).collection('favorites').get();
      // 3. create an if block to check if favoriteList.docs.isNotEmpty
      if (favoriteList.docs.isNotEmpty) {
        // 4. within the if block, create a new final variable called favoriteListData and assign it to favoriteList.docs.map((favoriteDoc) => Favorite.fromDoc(favoriteDoc)).toList();
        final favoriteListData =
            favoriteList.docs.map((favoriteDoc) => Favorite.fromDoc(favoriteDoc)).toList();
        // 5. return favoriteListData;
        return favoriteListData;
      } else {
        // 6. else return an empty list
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
        plugin: 'flutter_error/server_error.getFavorites',
      );
    }
  }

  // ONCE FAVORITE MODEL HAS BEEN CREATED, YOU CAN CONTINUE WITH THIS FILE AND
  // COMPLETE THE REMAINING METHODS, ALL OF THEM PRETTY MUCH FOLLOW THE SAME
  // PATTERN AS getFavorites() METHOD ABOVE. FOLLOW THE SAME STRUCTURE,
  // THE ONLY THING THAT CHANGES IS THE RETURN TYPE, for example: in getFavorites(), we are retrieving a list of favorites
  // so the return type is Future<List<Favorite>>. In the addFavorite() method, we are adding a favorite to the list
  // so the return type is Future<void>. and so on.
  // the function is async so we can use await keyword to wait for the data to be retrieved from the database
  // and then return the data
  // inside the body of the method, we have a try/catch block to catch any errors that might occur
  // you can just copy and paste the try/catch block from the getFavorites() method
  // and replace the main logic with the correct logic for the method, which would be within the try block.
  //TO RECAP THE PATTERN INSIDE THE TRY BLOCK IS:
  // 1. get the current user id using FirebaseAuth.instance.currentUser!.uid assign it to a final variable named uid
  // 2. perform the correct action.
  // 3. return the correct data *in void return type methods, you don't need to return anything.
  //

  // create a new method named addFavorite() that takes a {required Favorite favorite} object as a parameter
  // when adding a favorite, inside the .set() method, you need to pass the favorite object as a map
  // calling the favorite toDoc method like, .set(favorite.toDoc(favorite));.
  Future<void> addFavorite(Favorite favorite) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      await usersRef
          .doc(uid)
          .collection('favorites')
          .doc(favorite.name)
          .set(favorite.toDoc(favorite));
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
        plugin: 'flutter_error/server_error.getFavorites',
      );
    }
  }

  // create a new method named removeFavorite() that takes a String named favoriteId as a parameter
  Future<void> removeFavorite(favoriteId) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      await usersRef.doc(uid).collection('favorites').doc(favoriteId).delete();
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
        plugin: 'flutter_error/server_error.getFavorites',
      );
    }
  }

// method to check if favorite exists
  Future<bool> isFavorite({required String fid}) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      final DocumentSnapshot favoriteDoc =
          await usersRef.doc(uid).collection('favorites').doc(fid).get();
      if (favoriteDoc.exists) {
        return true;
      } else {
        return false;
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
        plugin: 'flutter_error/server_error.getFavorites',
      );
    }
  }
}
