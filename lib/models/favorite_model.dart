// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String name;
  final String image;
  final String type;

  Favorite({
    required this.name,
    required this.image,
    required this.type,
  });

  factory Favorite.fromDoc(DocumentSnapshot favoriteDoc) {
    final favoriteData = favoriteDoc.data() as Map<String, dynamic>;

    return Favorite(
      name: favoriteData['name'] ?? '',
      image: favoriteData['image'] ?? '',
      type: favoriteData['type'] ?? '',
    );
  }

  // constructor to set information to firebase
  Map<String, dynamic> toDoc(Favorite favorite) {
    return <String, dynamic>{
      'name': favorite.name,
      'image': favorite.image,
      'type': favorite.type,
    };
  }

  @override
  List<Object> get props => [name, image, type];

  @override
  bool get stringify => true;
}
