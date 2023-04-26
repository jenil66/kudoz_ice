import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Cartmodel {
   Cartmodel(
      {
        required this.name,
        required this.pro_image,
        required this.price,
        required this.pro_Quantity,
        required this.pro_cat,
        required this.pro_id});
  final String name;
  final String pro_image;
  final int price;
  final int pro_Quantity;
  final String pro_cat;
  final String pro_id;
  factory Cartmodel.fromDocument(QueryDocumentSnapshot doc){
    return Cartmodel(
      name: doc["pro_name"],
      pro_image: doc["pro_image"],
      price: doc["pro_price"],
      pro_Quantity: doc["pro_Quantity"],
      pro_cat: doc["cat_name"],
      pro_id: doc.id,
    );
  }
}