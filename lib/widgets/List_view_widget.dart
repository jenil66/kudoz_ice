import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/widgets/single_product.dart';

import '../route/routing_page.dart';
import 'details/details.dart';
import 'dimesial.dart';


class Listviewwidget extends StatelessWidget {
  final String id;
  final String collection;
  final String subcollection;

  const Listviewwidget(
      {Key? key,
      required this.id,
      required this.collection,
      required this.subcollection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: Text(subcollection,style:
          TextStyle(color: Color(0xffF42852), fontWeight: FontWeight.bold),),
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(collection)
                .doc(id)
                .collection(subcollection)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshort) {
              // print(id);

              if (!streamsnapshort.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return streamsnapshort.data!.docs.isEmpty
                  ? Center(
                      child: Text(
                      "No Item Found!",
                      style: TextStyle(
                          fontSize: Dimensions.h25,
                          fontWeight: FontWeight.bold),
                    ))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: streamsnapshort.data!.docs.length,

                      itemBuilder: (context, index) {
                        var data = streamsnapshort.data!.docs[index];
                        return singleproduct(
                          pro_image: data["pro_image"],
                          pro_price: data["pro_price"],
                          pro_name: data["pro_name"],
                          pro_id: data["pro_id"],
                          cat_name: data["cat_name"],
                          pro_des: data["pro_des"],
                          onTap: () {
                            Routingpage.gotonext(
                                context: context,
                                navigateto: Details(
                                  pro_image: data["pro_image"],
                                  name: data["pro_name"],
                                  price: data["pro_price"],
                                  description: data["pro_des"],
                                  pro_id: data["pro_id"],
                                  pro_cat: data["cat_name"],
                                ));
                          },
                        );
                      });
            }));
  }
}

// class Gridviewwidget extends StatelessWidget {
//   final String id;
//   final String collection;
//   const Gridviewwidget({Key? key, required this.id, required this.collection}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           elevation: 0,
//         ),
//         body: FutureBuilder(
//             future: FirebaseFirestore.instance.collection("category").doc(id).collection(collection).get(),
//             builder: (context,AsyncSnapshot<QuerySnapshot>snapshort){
//               print(id);
//               if(!snapshort.hasData){
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               return GridView.builder(
//                 // shrinkWrap: true,
//                   itemCount: snapshort.data!.docs.length,
//
//
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     // childAspectRatio: 0.4,
//                       mainAxisSpacing: 20,
//                       crossAxisSpacing: 20,
//                       crossAxisCount: 2
//                   ),
//                   itemBuilder: (context,index){
//                     var data=snapshort.data!.docs[index];
//                     return singleproduct(image: data["image"], price: data["price"], name: data["name"]);
//                   });
//             })
//
//     );
//   }
// }
