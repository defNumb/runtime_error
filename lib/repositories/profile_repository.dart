// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import '../constants/db_constants.dart';
import '../models/custom_error.dart';
import '../models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;
  ProfileRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  // NIKKI
  // CREATE getProfile method that will retrieve the users information from
  // firebase. -DONE
  // the function named getProfile requires a parameter uid of type String
  // and returns a Future<User>, the function must be async. -DONE
  Future<User> getProfile({required String uid}) async {
    try {
      // TODO:
      // 1. Create a final variable of type DocumentSnapshot named userDoc,
      // assign userDoc to await usersRef.doc(uid).get();
      // 2. Create an if/else statement to check if userDoc.exists
      // 3. Within the if block create a final variable named currentUser,
      // assign it to User.fromDoc(userDoc);
      // 4. return currentUser.
      // Within the else block
      // 5. return User.initialUser();
      return User.initialUser();
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
          plugin: 'flutter_error/server_error.getProfile');
    }
  }
}
