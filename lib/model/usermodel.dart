

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String uid;
  final String? user_image;
  UserModel( {
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    this.user_image,
  });
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
        name: doc["Name"],
        email: doc["Email"],
        password: doc["Password"],
        uid: doc["userid"],
      user_image: doc["User_image"],
    );
  }
}


