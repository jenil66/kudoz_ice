import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dimesial.dart';

class singlecartitem extends StatefulWidget {
  const singlecartitem(
      {Key? key,
      required this.name,
      required this.pro_image,
      required this.price,
      required this.pro_Quantity,
      required this.pro_cat,
      required this.pro_id})
      : super(key: key);
  final String name;
  final String pro_image;
  final int price;
  final int pro_Quantity;
  final String pro_cat;
  final String pro_id;

  @override
  State<singlecartitem> createState() => _singlecartitemState();
}

class _singlecartitemState extends State<singlecartitem> {
  void quantityFunction() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("usercart")
        .doc(widget.pro_id)
        .update({"pro_Quantity": quantity});
  }

  void deleteFunction() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("usercart")
        .doc(widget.pro_id)
        .delete();
  }

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(Dimensions.h10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.h10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            blurRadius: 7,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.pro_image),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(Dimensions.h10),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.h8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: Dimensions.h18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "category : ${widget.pro_cat}",
                        // widget.pro_cat,
                        style: TextStyle(fontSize: Dimensions.h15),
                      ),
                      Text(
                        "₹ ${widget.price * widget.pro_Quantity}",
                        style: TextStyle(
                            fontSize: Dimensions.h18,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          inanddecremant(
                              icon: Icons.add,
                              onPressed: () {
                                if (quantity < 10) {
                                  setState(() {
                                    quantity++;
                                    quantityFunction();
                                  });
                                }
                              }),
                          Text(
                            widget.pro_Quantity.toString(),
                            style: TextStyle(
                                fontSize: Dimensions.h18,
                                fontWeight: FontWeight.bold),
                          ),
                          inanddecremant(
                              icon: Icons.remove,
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                    quantityFunction();
                                  });
                                }
                              }),
                          IconButton(
                              onPressed: () {
                                deleteFunction();
                              },
                              icon: Icon(Icons.delete,color: Colors.red,))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

        ],
      ),
    );

  }
}

class inanddecremant extends StatelessWidget {
  const inanddecremant({Key? key, required this.icon, required this.onPressed})
      : super(key: key);
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: Dimensions.w40,
      height: Dimensions.h30,
      color: Colors.grey[300],
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.h40)),
      child: Icon(icon),
    );
  }
}
