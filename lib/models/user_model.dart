// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  // Setting properties
  final String id;
  final String name;
  final String lastName;
  final String email;
  final int point;
  final String rank; // find use for rank at a later date
  final String phoneNumber;
  final String dateJoined;
  final bool emailVerified;
  final bool phoneVerified;
  final bool isSubscribed;
  final GeoPoint location;
  final bool orderNotification;
  final bool promotionNotification;
  final bool postNotification;
  final bool isOnline;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.point,
    required this.rank,
    required this.phoneNumber,
    required this.dateJoined,
    required this.emailVerified,
    required this.phoneVerified,
    required this.isSubscribed,
    required this.location,
    required this.orderNotification,
    required this.promotionNotification,
    required this.postNotification,
    required this.isOnline,
  });

  // Factory constructor to retrieve information from firebase
  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'] ?? '',
      lastName: userData['last_name'] ?? '',
      email: userData['email'] ?? '',
      point: userData['point'] ?? 0,
      rank: userData['rank'] ?? '',
      phoneNumber: userData['phone'] ?? '',
      dateJoined: userData['dateJoined'] ?? '',
      emailVerified: userData['emailVerified'] ?? false,
      phoneVerified: userData['phoneVerified'] ?? false,
      isSubscribed: userData['isSubscribed'] ?? false,
      location: userData['location'] ?? GeoPoint(0, 0),
      orderNotification: userData['orderNotification'] ?? false,
      promotionNotification: userData['promotionNotification'] ?? false,
      postNotification: userData['postNotification'] ?? false,
      isOnline: userData['isOnline'] ?? false,
    );
  }

  // Factory constructor to get user intially that is not in firestore
  factory User.initialUser() {
    return User(
      id: '',
      name: '',
      lastName: '',
      email: '',
      point: -1,
      rank: '',
      phoneNumber: '',
      dateJoined: '',
      emailVerified: false,
      phoneVerified: false,
      isSubscribed: false,
      location: GeoPoint(0, 0),
      orderNotification: false,
      promotionNotification: false,
      postNotification: false,
      isOnline: false,
    );
  }

  // Equatable
  @override
  List<Object> get props {
    return [
      id,
      name,
      lastName,
      email,
      point,
      rank,
      phoneNumber,
      dateJoined,
      emailVerified,
      phoneVerified,
      isSubscribed,
      location,
      orderNotification,
      promotionNotification,
      postNotification,
      isOnline,
    ];
  }

  // toString method
  @override
  String toString() {
    return 'User ( id: $id, name: $name, lastName: $lastName, email: $email, point: $point, rank: $rank, phoneNumber: $phoneNumber, dateJoined: $dateJoined, emailVerified: $emailVerified, phoneVerified: $phoneVerified, isSubscribed: $isSubscribed, location: $location, orderNotification: $orderNotification, promotionNotification: $promotionNotification, postNotification: $postNotification, isOnline: $isOnline)';
  }
}
