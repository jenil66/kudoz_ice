// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
//
// class Placeorderprovider with ChangeNotifier {
//   bool loading = false;
//   UserCredential? userCredential;
//   void Placeorder({
//     required  TextEditingController? name,
//     required  TextEditingController? phone_no,
//     required  TextEditingController? address,
//     required  TextEditingController? pincode,
//     required int total,
//     required String pro_name_list,
//
//     required BuildContext context,
//   }) async {
//     if (name!.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Please Enter Name")));
//       return;
//     }
//     else if (phone_no!.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Please Enter phone_no")));
//       return;
//     }
//     else if (address!.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Please Enter Address")));
//       return;
//     }
//    else if (pincode!.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Please Enter pincode")));
//       return;
//     }
//     else {
//       if(phone_no.text.length==10&&pincode.text.length==6){
//         loading = true;
//         notifyListeners();
//         FirebaseFirestore.instance
//             .collection("orders")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection("User order")
//             .doc(Uuid().v1())
//             .set({
//           "name": name.text,
//           "adrres": address.text,
//           "pincode": pincode.text,
//           "phone number": phone_no.text,
//           "total":total,
//           "userid":FirebaseAuth.instance.currentUser!.uid,
//           "pro_name_list":pro_name_list,
//
//         }).then((value) => loading=false);
//         notifyListeners();
//       }
//       else{
//         if(phone_no.text.length!=10){
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text("Invalid Phone number")));
//           return;
//         }
//         else{
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text("Invalid Pincode")));
//           return;
//         }
//       }
//     }
//   }
// }
