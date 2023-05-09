
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../route/routing_page.dart';
import '../widgets/List_view_widget.dart';
import '../widgets/details/details.dart';
import '../widgets/dimesial.dart';
import '../widgets/kudoz_name.dart';
import '../widgets/single_product.dart';

class searchpage extends StatefulWidget {
  const searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  String query = "";
  String query_cat = "";
  var result;
  var cat_result;
  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["pro_name"].toLowerCase().contains(query) ||
          element["pro_name"].toUpperCase().contains(query) ||
          element["pro_name"].contains(query) ||
          element["pro_name"].toLowerCase().contains(query) &&
              element["pro_name"].contains(query) &&
              element["pro_name"].toUpperCase().contains(query);
    }).toList();
    return result;
  }
  searchCategoryFunction(queryCat, searchList) {
    cat_result = searchList.where((element) {
      return element["cat_name"].toLowerCase().contains(query) ||
          element["cat_name"].toUpperCase().contains(query) ||
          element["cat_name"].contains(query) ||
          element["cat_name"].toLowerCase().contains(query) &&
              element["cat_name"].contains(query) &&
              element["cat_name"].toUpperCase().contains(query);
    }).toList();
    return cat_result;
  }

  //
  // List<Map<String, dynamic>> searchCategoryFunction(String queryCat, searchList) {
  //   List<Map<String, dynamic>> cat_result = searchList.where((ele) {
  //     String catName = ele["cat_name"].toString().toLowerCase();
  //     return catName.contains(queryCat.toLowerCase());
  //   }).toList();
  //   return cat_result;
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: kudozname(),
      ),
      body:  Padding(
        padding: EdgeInsets.all(Dimensions.h10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(7),
                ],
                onChanged: (value) {
                  setState(() {
                    query = value;
                    query_cat = value;
                  });
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,color: Colors.black,),

                  fillColor: Colors.grey,
                  hintText: " Search Product",
                  filled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.h10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),



              query_cat==""? Center(
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: Dimensions.h5,
                  ),
                ),
              )
                  :SizedBox(height: 70,
                child: Container(
                height: Dimensions.h40,
                child: StreamBuilder(

                  stream:
                  FirebaseFirestore.instance.collection("Category").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshort) {
                    if (!streamsnapshort.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var vardata=searchCategoryFunction(query_cat, streamsnapshort.data!.docs);
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cat_result.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          print(vardata.toString());
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Listviewwidget(
                                              collection: "Category",
                                              id: vardata[index]["cat_id"],
                                              subcollection: vardata[index]["cat_name"],
                                            )));
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(Dimensions.h10),
                                  height: Dimensions.h40,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(Dimensions.h15),
                                      color: Colors.grey[900]),
                                  child: Text(
                                      vardata[index]["cat_name"],
                                      style: TextStyle(
                                        // fontSize:Dimensions.h15 ,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),

                                  // child: Text(CategoryList[index],style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal))
                                ),
                              ),
                              SizedBox(width: Dimensions.w15)
                            ],
                          );
                        });
                  },
                ),
              ),),
              query == ""
                  ? Center(
                child: SizedBox(height: 20,child: Text(
                  '',
                  style: TextStyle(
                    fontSize: Dimensions.h5,
                  ),
                ),),
              )
                  : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("product").snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshort) {
                      if (!streamsnapshort.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      // var data=streamsnapshort.data!.docs
                      var varData = searchFunction(query, streamsnapshort.data!.docs);
                      return varData.isEmpty
                          ? Center(
                        child: Text(
                          "No Product Found!",
                          style: TextStyle(
                            fontSize: Dimensions.h25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:varData.length,
                          itemBuilder: (context, index) {
                            var data = varData[index];
                            return singleproduct(
                              pro_image: data["pro_image"],
                              pro_price: data["pro_price"],
                              pro_name: data["pro_name"],
                              pro_des: data["pro_des"],
                              pro_id: data["pro_id"],
                              cat_name: data["cat_name"],
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//query_cat == ""
//           ? Center(
//         child: Text(
//           '',
//           style: TextStyle(
//             fontSize: Dimensions.h5,
//           ),
//         ),
//       )
//           : SizedBox(
//         height: Dimensions.h100,
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection("Category").snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshort) {
//             if (!streamsnapshort.hasData) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//              searchList = streamsnapshort.data!,
//             List<Map<String, dynamic>> cat_result = searchCategoryFunction(query_cat, searchList) as List<Map<String, dynamic>>;
//
//             return cat_result.isEmpty
//                 ? Center(
//               child: Text(
//                 "$query_cat is not in categories",
//                 style: TextStyle(
//                   fontSize: Dimensions.h18,
//                 ),
//               ),
//             )
//                 : ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               itemCount: cat_result.length,
//               itemBuilder: (context, index) {
//                 String catName = cat_result[index]["cat_name"].toString();
//                 String id = cat_result[index]["id"].toString();
//
//                 return Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Listviewwidget(
//                                 subcollection: catName,
//                                 collection: "Category",
//                                 id: id,
//                               ),
//                             ),
//                           );
//                         });
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(Dimensions.h10),
//                         height: Dimensions.h40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(Dimensions.h15),
//                           color: Colors.grey[900],
//                         ),
//                         child: Text(
//                           catName,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: Dimensions.w15),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),