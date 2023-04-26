import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/pages/home_screen.dart';

class Loginauthprovider with ChangeNotifier {
  static Pattern pattern = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+";
  RegExp regExp = RegExp(Loginauthprovider.pattern.toString());
  bool loading = false;
  UserCredential? userCredential;
  void loginvalidation({
    required TextEditingController? email,
    required TextEditingController? password,
    required BuildContext context,
  }) async {
    if (email!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Enter Email")));
      return;
    }  if (!regExp.hasMatch(email!.text.trim())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Email")));
      return;
    }  if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Enter password")));
      return;
    }  else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: email.text, password: password.text).then((value) async{
          loading = false;
          notifyListeners();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>btn()));
        });
        notifyListeners();
      }on
      FirebaseAuthException catch(e){
        loading=false;
        notifyListeners();
        if(e.code=="user-not-found"){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("user-not-found")));
        }
        else if(e.code=="wrong-password"){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("wrong-password")));
        }
      }

    }
  }
}
