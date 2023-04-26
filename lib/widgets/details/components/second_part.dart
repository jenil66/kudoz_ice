import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudoz_ice/route/routing_page.dart';
import 'package:kudoz_ice/widgets/dimesial.dart';

import '../../../cart/cart.dart';
import '../../../widgets/common_button.dart';

class SecondPart extends StatelessWidget {
   SecondPart(
      {Key? key,
      required this.name,
      required this.price,
      required this.description,
      required this.pro_id,
      required this.pro_image,
      required this.pro_Quantity,
      required this.pro_cat})
      : super(key: key);
  final String name;
  final int price;
  final String description;
  final String pro_id;
  final String pro_image;
  final int pro_Quantity;
  final String pro_cat;

  @override
  Widget build(BuildContext context) {
    print(pro_id);
    return Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: Dimensions.h30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.grey,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child:
                  Text(
                    "Category : $pro_cat",
                    style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
                  ),

            ),
                Center(
                  child: Text(
                    "Price : ₹ $price",
                    style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                ),
            Divider(thickness: 2),
            Center(
              child: Text(
                "Description",
                style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
              ),
            ),
            Text("     "+description),
            SizedBox(
              height: Dimensions.h20,
            ),
            MyElevatedButton(
              btnname: 'Add To Cart',
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("cart")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("usercart")
                    .doc(pro_id)
                    .set({
                  "pro_id": pro_id,
                  "pro_image": pro_image,
                  "pro_name": name,
                  "pro_price": price,
                  "pro_Quantity": pro_Quantity,
                  "cat_name": pro_cat
                });
                Routingpage.pushreplase(context: context, navigateto: Cart());
                  Fluttertoast.showToast(
                      msg: "Product Added Successfully",
                      toastLength: Toast.LENGTH_SHORT);
              },
            )
          ],
        )
    );

  }
}
