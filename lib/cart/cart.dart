import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudoz_ice/order/checkout.dart';
import 'package:kudoz_ice/provider/cart_provider.dart';
import 'package:kudoz_ice/route/routing_page.dart';
import 'package:kudoz_ice/widgets/common_button.dart';
import 'package:kudoz_ice/widgets/single_cart_item.dart';
import 'package:provider/provider.dart';

import '../route/routing_page.dart';
import '../route/routing_page.dart';
import '../widgets/dimesial.dart';
import '../pages/home_screen.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CollectionReference cartRef = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("usercart");

  Future<void> clearCart() async {
    QuerySnapshot cartItems = await cartRef.get();
    WriteBatch batch = FirebaseFirestore.instance.batch();
    cartItems.docs.forEach((doc) {
      batch.delete(doc.reference);
    });
    return batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    Cartprovider cartprovider = Provider.of<Cartprovider>(context);
    cartprovider.getcartData();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "Cart",
          style:
          TextStyle(color: Color(0xffF42852), fontWeight: FontWeight.bold),
        ),
        actions: [
          cartprovider.cartlist.length != 0 ?
          IconButton(
              onPressed: () {
                clearCart();
                  // Navigator.pop(context);
                    Routingpage.pushreplase(
                        context: context, navigateto: btn());
                setState(() {
                  Fluttertoast.showToast(
                      msg: "Cart Clear",
                      toastLength: Toast.LENGTH_SHORT);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Color(0xffF42852),
              ))
              :Container(),
          // IconButton(
          //     onPressed: () {
          //       Routingpage.pushreplase(
          //           context: context, navigateto: btn());
          //     },
          //     icon: Icon(
          //       Icons.home,
          //       color: Color(0xffF42852),
          //     )),
        ],
      ),
      body: cartprovider.getcartlist.isEmpty
          ? Center(
        child: Text(
          "Cart is Empty!",
          style: TextStyle(
              fontSize: Dimensions.h25, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: cartprovider.getcartlist.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            var data = cartprovider.cartlist[index];
            // print(data);
            return singlecartitem(
              name: data.name,
              pro_image: data.pro_image,
              price: data.price,
              pro_Quantity: data.pro_Quantity,
              pro_cat: data.pro_cat,
              pro_id: data.pro_id,
            );
          }),
      bottomNavigationBar: cartprovider.getcartlist.isEmpty
          ? SizedBox.shrink()
          : Padding(
        padding: EdgeInsets.all(Dimensions.h15),
        child: MyElevatedButton(
          btnname: 'Check Out',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => checkout()));
          },
        ),
      ),
    );
  }
}
