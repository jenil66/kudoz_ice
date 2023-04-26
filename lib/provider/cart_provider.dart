  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
import '../cart/cart_model.dart';

  class Cartprovider with ChangeNotifier{

    List<Cartmodel> cartlist=[];
    Cartmodel? cartmodel;
    Map<String, int> productMap = {};
    void _updateProductMap() {
      productMap = {};
      cartlist.forEach((element) {
        productMap[element.name] = element.pro_Quantity;
      });
    }
    void getcartData()async{
      List<Cartmodel> newcartlist=[];
      QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("cart")
          .doc(FirebaseAuth.instance.currentUser!.uid).set({"user_id":FirebaseAuth.instance.currentUser!.uid})
      .then((value) => FirebaseFirestore.instance.collection("cart")
          .doc(FirebaseAuth.instance.currentUser!.uid).collection("usercart").get());
      querySnapshot.docs.forEach((element) {
        cartmodel =Cartmodel.fromDocument(element);
        notifyListeners();
        newcartlist.add(cartmodel!);
      });
      cartlist=newcartlist;
      notifyListeners();
      _updateProductMap();
    }

    List<Cartmodel> get getcartlist{
      _updateProductMap();
      return cartlist ;

    }


    int subtotal(){
      _updateProductMap();
      int subtotal=0;
      cartlist.forEach((element) {
        subtotal+=element.price*element.pro_Quantity;
      });
      return subtotal;
    }

  }


