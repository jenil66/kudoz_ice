import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/pages/home_screen.dart';



class Signupauthprovider with ChangeNotifier {
  static Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = RegExp(Signupauthprovider.pattern.toString());
  bool loading = false;
  UserCredential?  userCredential;

  void signupvalidation({
    required TextEditingController? name,
    required TextEditingController? email,
    required TextEditingController? password,
    required BuildContext context,
  }) async {
    if (name!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Enter Name")));
      return;
    } else if (email!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Enter Email")));
      return;
    } else if (!regExp.hasMatch(email!.text.trim())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Email")));
      return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Enter password")));
      return;
    } else if (password!.text.length <= 7) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password Must Be 8 Character")));
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        loading = true;
        notifyListeners();
        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.user!.uid)
            .set({
          "User_image": "",
          "Name": name.text,
          "Email": email.text,
          "Password": password.text,
          "userid": userCredential!.user!.uid,
        }).then((value) {
          loading = false;
          notifyListeners();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>btn()));
        });
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("weak-password")));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("email-already-in-use")));
        }
      }
    }
  }
}

