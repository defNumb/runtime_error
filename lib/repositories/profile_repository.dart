import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import '../models/custom_error.dart';
import '../models/user_model.dart';

// Nikki

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  ProfileRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  // TODO
  // 1. Create a new try/catch block - DONE

  Future<User> getProfile({required String uid}) async {
    try {
      // 2. Create a new final variable of type DocumentSnapshot named userDoc and assign it to await usersRef.doc(uid).get();
      // 3. Create a new if block to check if userDoc.exists - DONE
      // if (userDoc.exists) {
      // 4. Create a new final variable of type User named currentUser and assign it to User.fromDoc(userDoc);
      // 5. return currentUser;
      // } else {
      //   return User.initialUser();
      // }
      return User.initialUser(); // DELETE THIS LINE
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
        plugin: 'flutter_error/server_error.getProfile',
      );
    }
  }
}
