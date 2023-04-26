import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favoriteprovider with ChangeNotifier {
  void favorite({
    required pro_id,
    required pro_cat,
    required pro_price,
    required pro_image,
    required pro_name,
    required pro_des,
    required productfavorite,
  }) {
    FirebaseFirestore.instance
        .collection("userFavorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Favorite")
        .doc(pro_id)
        .set({
      "pro_id": pro_id,
      "pro_des":pro_des,
      "cat_name": pro_cat,
      "pro_price": pro_price,
      "pro_image": pro_image,
      "pro_name": pro_name,
      "product favorite": productfavorite
    });
  }

  deletefavorite({required String pro_id,productfavorite}) {
    FirebaseFirestore.instance
        .collection("userFavorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Favorite")
        .doc(pro_id)
        .delete();
    notifyListeners();
  }
}
