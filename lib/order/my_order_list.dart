import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudoz_ice/pages/home_screen.dart';
import 'package:kudoz_ice/route/routing_page.dart';
import 'package:kudoz_ice/widgets/constant.dart';
import 'package:kudoz_ice/widgets/drawer.dart';
import '../widgets/dimesial.dart';

class myorderlist extends StatefulWidget {
  // final name;
  // final phone_no;
  // // final pro_list;
  // final int? total
  // ;

  myorderlist({
  Key? key,
// this.phone_no,
    // this.pro_list,
    // this.total
  })
      : super(key: key);

  @override
  State<myorderlist> createState() => _myorderlistState();
}

class _myorderlistState extends State<myorderlist> {

  TextEditingController feedback1 = TextEditingController();
  GlobalKey<FormState> feedbackkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "My Order",
          style:
              TextStyle(color: Color(0xffF42852), fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            // .orderBy("utc_time", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshort) {
          print(FirebaseAuth.instance.currentUser!.uid);
          if (!streamsnapshort.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return streamsnapshort.data!.docs.isEmpty
              ? Center(
                  child: Text(
                  "No Order Found!",
                  style: TextStyle(
                      fontSize: Dimensions.h25, fontWeight: FontWeight.bold),
                ))
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: streamsnapshort.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    var data = streamsnapshort.data!.docs[index];
                    return Container(
                      margin: EdgeInsets.all(Dimensions.h10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              blurRadius: 7,
                            )
                          ]),
                      // height: Dimensions.h150 ,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(
                                  "Order Id : " + data["orderid"],
                                  style: TextStyle(fontSize: Dimensions.h18),
                                ),
                              ],
                            ),
                            Text(
                              "Name : " + data["name"],
                              style: TextStyle(fontSize: Dimensions.h15),
                            ),
                            Text(
                              "Mobile no. : " + data["phone_number"],
                              style: TextStyle(fontSize: Dimensions.h15),
                            ),
                            Text(
                              "Ordered items : " + data["pro_name_list"].toString(),
                              style: TextStyle(fontSize: Dimensions.h15),
                            ),
                            Text(
                              "Total : ₹ " + data["total"].toString(),
                              style: TextStyle(fontSize: Dimensions.h15),
                            ),
                            Text(
                              "Status : " + data["status"],
                              style: TextStyle(
                                  fontSize: Dimensions.h15,
                                  color: data["status"] == 'cancelled'
                                      ? Colors.red
                                      : data["status"].toString() == 'pending'
                                          ? Colors.yellow
                                          : data["status"] == "delivered"
                                              ? Colors.greenAccent
                                              : Colors.green),
                            ),
                            Text(
                              "  Date : " + data["date_time"].toString(),
                              style: TextStyle(fontSize: Dimensions.h15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                child: data["status"] != "pending" &&
                                        data["status"] != "accepted"
                                    ? null
                                    : Container(
                                        width: double.infinity,
                                        height: Dimensions.h30,
                                        child: ElevatedButton(
                                          child: Text('Cancel Order'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        'Cancel Order?',
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      content: Text(
                                                        'Are you sure you want to cancel this order?',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.green,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'orders')
                                                                .doc(data[
                                                                    "orderid"])
                                                                .update({
                                                              'status':
                                                                  'cancelled'
                                                            }).then((value) =>
                                                                    setState(() {
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg:
                                                                                  "Order Canceled Successfully");
                                                                    }));
                                                            Navigator.pop(context);
                                                            Navigator.pop(context);
                                                            Navigator.pop(context);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            });
                                          },
                                        ),
                                      )),
                            Container(
                              child: data["status"] != "delivered"
                                  ? null
                                  : FutureBuilder<QuerySnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection("Feedback")
                                          .where('orderid',
                                              isEqualTo: data["orderid"])
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return Text("Something went wrong");
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator(color: Colors.black,));
                                        }

                                        if (snapshot.data!.size == 0) {
                                          return Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(Dimensions.h30),
                                                ),
                                              ),
                                              height: Dimensions.h20,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return Form(
                                                          key: feedbackkey,
                                                          child: AlertDialog(
                                                            title: Text(
                                                              'Enter Feedback',
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                color: Colors.green,
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                              ),
                                                            ),
                                                            content: TextFormField(
                                                              validator: (v) {
                                                                if (v!.isEmpty) {
                                                                  return "Feedback is empty";
                                                                }
                                                              },
                                                              maxLines: 5,
                                                              controller: feedback1,
                                                              decoration:
                                                                  InputDecoration(
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      borderSide: BorderSide(color: Colors.black),
                                                                    ),
                                                                prefixIcon: Icon(
                                                                    Icons.feedback,color: Colors.black,),
                                                                labelText:
                                                                    "Enter Feedback",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions
                                                                              .h15),
                                                                ),
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                    color:
                                                                        Colors.red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                  "Send",
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  if(feedbackkey.currentState!.validate()){
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                        'Feedback')
                                                                        .doc(data[
                                                                    "orderid"])
                                                                        .set({
                                                                      "feedback":
                                                                      feedback1
                                                                          .text,
                                                                      "user_id": data[
                                                                      "user_id"],
                                                                      "product": data[
                                                                      "pro_name_list"],
                                                                      "orderid": data[
                                                                      "orderid"]
                                                                    });
                                                                   Navigator.pop(context);
                                                                    Navigator.pop(context);
                                                                    Fluttertoast
                                                                        .showToast(
                                                                        msg:
                                                                        "Feedback Send Successfully");
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  });
                                                },
                                                child: Text("give feedback"),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(Dimensions.h30),
                                                ),
                                              ),
                                              height: Dimensions.h20,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey,
                                                ),
                                                child: Text("Submited"),
                                                onPressed: () {},
                                              ));
                                        }
                                      },
                                    ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
// Container
// (
// margin: EdgeInsets.all(Dimensions.h10),
// decoration: BoxDecoration(color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.7),
// blurRadius: 7,
// )
// ]),
// height: Dimensions.h120+Dimensions.h10,
// width: double.infinity,
// child:Column(
// children: [
//
// ],
// )
// ,
// )
// ,
