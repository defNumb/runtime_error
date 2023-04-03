// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String id;

  Favorite({
    required this.id,
  });

  factory Favorite.fromDoc(DocumentSnapshot favoriteDoc) {
    final favoriteData = favoriteDoc.data() as Map<String, dynamic>;

    return Favorite(
      id: favoriteData['id'] ?? '',
    );
  }

  // constructor to set information to firebase
  Map<String, dynamic> toDoc(Favorite favorite) {
    return <String, dynamic>{
      'id': favorite.id,
    };
  }

  @override
  List<Object> get props => [id];

  @override
  bool get stringify => true;
}
