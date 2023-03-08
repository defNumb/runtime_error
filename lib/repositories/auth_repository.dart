// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../constants/db_constants.dart';
import '../models/custom_error.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  // stream
  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  // sign up method
  // Sign up method
  Future<void> signup({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      // Create user in firebase auth
      final fbAuth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;

      // Create user in firestore AFTER user is created in firebase auth
      await usersRef.doc(signedInUser.uid).set({
        'id': signedInUser.uid,
        'name': name,
        'last_name': lastName,
        'email': email,
        'point': 0,
        'rank': 'Bronze',
        'phoneNumber': '',
        'dateJoined': DateTime.now().toString(),
        'emailVerified': false,
        'phoneVerified': false,
        'isSubscribed': false,
        'location': GeoPoint(0, 0),
        'orderNotification': false,
        'promotionNotification': false,
        'postNotification': false,
        'isOnline': false,
      });
    } on fbAuth.FirebaseAuthException catch (e) {
      // HANDLE ERROR
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.signup',
      );
    }
  }

  // Sign in method
  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.signin',
      );
    }
  }

  // anonymous sign in method
  Future<void> anonymousSignin() async {
    try {
      await firebaseAuth.signInAnonymously();
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.anonymousSignin',
      );
    }
  }

  // Convert anonymous user to permanent user
  Future<void> convertAnonymousUser({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      // Get current user
      final fbAuth.User? currentUser = firebaseAuth.currentUser;

      // credential
      final fbAuth.AuthCredential credential = fbAuth.EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      // Create user in firebase auth
      final fbAuth.UserCredential userCredential =
          await currentUser!.linkWithCredential(credential);

      final signedInUser = userCredential.user!;

      // Create user in firestore AFTER user is created in firebase auth
      await usersRef.doc(signedInUser.uid).set(
        {
          'id': signedInUser.uid,
          'name': name,
          'last_name': lastName,
          'email': email,
          'point': 0,
          'rank': 'Bronze',
          'phoneNumber': '',
          'dateJoined': DateTime.now().toString(),
          'emailVerified': false,
          'phoneVerified': false,
          'isSubscribed': false,
          'location': GeoPoint(0, 0),
          'orderNotification': false,
          'promotionNotification': false,
          'postNotification': false,
          'isOnline': false,
        },
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      // HANDLE ERROR
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.convertAnonymousUser',
      );
    }
  }

  // Sign out method
  Future<void> signout() async {
    await firebaseAuth.signOut();
  }

  // Delete user method
  Future<void> deleteUserAccount(String password) async {
    try {
      // Get current user
      final fbAuth.User? currentUser = firebaseAuth.currentUser;
      // get credential
      final fbAuth.AuthCredential credential = fbAuth.EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: password,
      );

      // re-authenticate user and then delete
      await currentUser.reauthenticateWithCredential(credential).then(
        (value) {
          // Delete user in firestore
          usersRef.doc(value.user!.uid).delete();
          value.user!.delete();
        },
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      // HANDLE ERROR
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error.deleteUserAccount',
      );
    }
  }
}
