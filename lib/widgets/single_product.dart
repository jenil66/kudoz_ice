import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/provider/favorite_provider.dart';
import 'package:kudoz_ice/widgets/firebase_const.dart';
import 'package:provider/provider.dart';

import 'dimesial.dart';

class singleproduct extends StatefulWidget {
  final pro_id;
  final cat_name;
  final int pro_price;
  var pro_rating;
  final pro_image;
  final pro_name;
  final pro_des;
  final productfavorite;
  final Function()? onTap;
   singleproduct({
    Key? key,
    required this.onTap,
    this.pro_id,
    this.cat_name,
    required this.pro_price,
     this.pro_rating,
    this.pro_image,
    this.pro_name,
    this.productfavorite,
     this.pro_des,
  }) : super(key: key);

  @override
  State<singleproduct> createState() => _singleproductState();
}

class _singleproductState extends State<singleproduct> {
  bool isfavorite = false;
  @override
  Widget build(BuildContext context) {
    Favoriteprovider favoriteprovider = Provider.of<Favoriteprovider>(context);
    FirebaseFirestore.instance
        .collection("userFavorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Favorite")
        .doc(widget.pro_id)
        .get().then((value) => {
          if(this.mounted){
            if(value.exists){
              setState((){
                isfavorite=value.get("product favorite");
              })
            }
          }
    });
    return InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Container(
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
              child: Stack(alignment: Alignment.topRight,
                children: [
                  Positioned(
                    right:-5,
                    top: -5,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isfavorite = !isfavorite;
                          if (isfavorite == true) {
                            favoriteprovider.favorite(
                              pro_des: widget.pro_des.toString(),
                              pro_id: widget.pro_id,
                              pro_cat: widget.cat_name,
                              pro_price: widget.pro_price,
                              pro_image: widget.pro_image,
                              pro_name: widget.pro_name,
                              productfavorite: true,
                            );
                          } else if (isfavorite == false) {
                            favoriteprovider.deletefavorite(pro_id: widget.pro_id);
                          }
                        });
                      },
                      icon: Icon(
                        isfavorite ? Icons.favorite : Icons.favorite_border,
                        color: Color(0xffdb1156),
                      ),
                      splashColor: Colors.transparent,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              // Positioned(
                              //   bottom: -Dimensions.h10,
                              //   right: -Dimensions.w10,
                              //   child:
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.h10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.pro_name,
                                style: TextStyle(
                                  fontSize: Dimensions.h20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Price : ₹ ${widget.pro_price}",
                                style: TextStyle(
                                    fontSize: Dimensions.h24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Category : ${widget.cat_name}",
                                        style: TextStyle(
                                            fontSize: Dimensions.h18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Rating : ${widget.pro_rating}",
                                  //       style: TextStyle(
                                  //           fontSize: Dimensions.h15, fontWeight: FontWeight.bold),
                                  //     ),
                                  //
                                  //
                                  //   ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     IconButton(
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           isfavorite = !isfavorite;
                                  //           if (isfavorite == true) {
                                  //             favoriteprovider.favorite(
                                  //                 pro_id: widget.pro_id,
                                  //                 pro_cat: widget.cat_name,
                                  //                 pro_price: widget.pro_price,
                                  //                 pro_rating: widget.pro_rating,
                                  //                 pro_image: widget.pro_image,
                                  //                 pro_name: widget.pro_name,
                                  //                 productfavorite: true);
                                  //           } else if (isfavorite == false) {
                                  //             favoriteprovider.deletefavorite(pro_id: widget.pro_id);
                                  //
                                  //           }
                                  //         });
                                  //       },
                                  //       icon: Icon(
                                  //         isfavorite
                                  //             ? Icons.favorite
                                  //             : Icons.favorite_border,
                                  //         color: Colors.redAccent[700],
                                  //       ),
                                  //       splashColor: Colors.grey,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Text("Add to wishlist")
                                  //     // MyElevatedButton(btnname: , onPressed: onPressed)
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          )
                        ],

                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
//Container(
//        height: 100,
//
//         margin: EdgeInsets.only(top: 10),
//         padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
//
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: Colors.grey[900]
//         ),
//
//           child: Row(
//             children: [
//               Container(
//                 height: 50,
//                 width: 50,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: NetworkImage(image)
//                     )
//                 ),
//               ),
//               SizedBox(width: 15),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(name,style: TextStyle(color: Color(0xffF78A00), fontWeight: FontWeight.normal, fontSize: 20)),
//                   Text("$price",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20)),
//                 ],
//               ),
//               Spacer(),
//               Row(
//                 children: [
//                   IconButton(
//                       onPressed: (){},
//                       icon: Icon(Icons.favorite_border_rounded, color: Color(0xffF42852),)
//                   ),
//                   IconButton(
//                       onPressed: (){},
//                       icon: Icon(Icons.shopping_cart_outlined, color: Color(0xffF42852),)
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//       )

// class singleproduct extends StatelessWidget {
//   final String image;
//   final int price;
//   final String name;
//   const singleproduct({Key? key, required this.image, required this.price, required this.name}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             // color: Colors.red,
//             height: 200,
//             width: 160,
//             child: Column(
//               children: [
//                 Container(
//                   // color: Colors.amber,
//                   height: 120,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(image)
//                       )
//                   ),
//
//
//                 ),
//                 Container(
//                   child: Column(
//                     children: [
//                       Text(name,style: TextStyle(color: Color(0xffF78A00), fontWeight: FontWeight.normal, fontSize: 16)),
//                       Text("$price",style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//     // return Container(
//     //   height: 100,
//     //
//     //   margin: EdgeInsets.only(top: 10),
//     //   padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
//     //
//     //   width: MediaQuery.of(context).size.width,
//     //   decoration: BoxDecoration(
//     //       borderRadius: BorderRadius.circular(15),
//     //       color: Colors.grey[900]
//     //   ),
//     //   child: Row(
//     //     children: [
//     //       Container(
//     //         height: 50,
//     //         width: 50,
//     //         decoration: BoxDecoration(
//     //             borderRadius: BorderRadius.circular(10),
//     //             image: DecorationImage(
//     //                 fit: BoxFit.cover,
//     //                 image: NetworkImage(image)
//     //             )
//     //         ),
//     //       ),
//     //       SizedBox(width: 15),
//     //       Column(
//     //         crossAxisAlignment: CrossAxisAlignment.start,
//     //         children: [
//     //           Text(name,style: TextStyle(color: Color(0xffF78A00), fontWeight: FontWeight.normal, fontSize: 20)),
//     //           Text("$price",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20)),
//     //         ],
//     //       ),
//     //       Spacer(),
//     //       Row(
//     //         children: [
//     //           IconButton(
//     //               onPressed: (){},
//     //               icon: Icon(Icons.favorite_border_rounded, color: Color(0xffF42852),)
//     //           ),
//     //           IconButton(
//     //               onPressed: (){},
//     //               icon: Icon(Icons.shopping_cart_outlined, color: Color(0xffF42852),)
//     //           ),
//     //         ],
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }
