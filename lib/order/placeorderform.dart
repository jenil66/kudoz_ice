import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kudoz_ice/pages/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../provider/cart_provider.dart';
import '../widgets/common_button.dart';
import '../widgets/dimesial.dart';

class placeorderform extends StatefulWidget {
  final int total;
  final String pro_name_list;

  const placeorderform(
      {Key? key, required this.total, required this.pro_name_list})
      : super(key: key);

  @override
  State<placeorderform> createState() => _placeorderformState();
}

class _placeorderformState extends State<placeorderform> {
  late bool loading = false;
  late Razorpay razorpay;

  // late String total ;
  @override
  void initState() {
    super.initState();
    print(widget.pro_name_list);
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': num.parse(widget.total.toString()) * 100,
      'name': 'Kudoz Ice-cream',
      'description': 'Payment ',
      'prefill': {'contact': '8401487495', 'email': 'jenilshiroya1@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => btn()));
    Fluttertoast.showToast(
            msg: "SUCCESS: " + response.paymentId!,
            toastLength: Toast.LENGTH_SHORT)
        .then((value) => FirebaseFirestore.instance
                .collection("orderId")
                .doc("lastOrderId")
                .get()
                .then((document) {
              int lastOrderId =
                  document.exists ? document.data()!["orderId"] : 0;
              String newOrderId = "order${lastOrderId + 1}";

              FirebaseFirestore.instance
                  .collection("orders")
                  .doc(newOrderId)
                  .set({
                "orderid": newOrderId,
                "name": name.text,
                "address": address.text,
                "pincode": pincode.text,
                "phone_number": phone_no.text,
                "total": widget.total,
                "user_id": FirebaseAuth.instance.currentUser!.uid,
                "pro_name_list": widget.pro_name_list,
                "date_time":
                    '${DateFormat.yMMMEd().format(DateTime.now())} ${DateFormat.jm().format(DateTime.now())}',
                "status": "pending",
                "utc_time": DateTime.now(),
              }).then((value) => FirebaseFirestore.instance
                      .collection("orderId")
                      .doc("lastOrderId")
                      .update({"orderId": lastOrderId + 1}).then(
                          (value) async => await clearCart()));
            }));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: Payment Not Done ", toastLength: Toast.LENGTH_SHORT);
    // loading=false;
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  TextEditingController name = TextEditingController();
  TextEditingController phone_no = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Cartprovider cartprovider = Provider.of<Cartprovider>(context);
    cartprovider.getcartData();
    int subtotal = cartprovider.subtotal();
    int shipping_charge = 50;
    int total = subtotal + shipping_charge;
    _handlePaymentSuccess;

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Colors.black, size: 25 //change your color here
                ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('asset/login.png'),fit: BoxFit.fill),),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.h10,
                      right: Dimensions.h10,
                      left: Dimensions.h10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            "Fill The Form",
                            style: TextStyle(
                                fontSize: Dimensions.h30,
                                fontWeight: FontWeight.bold),
                          )),
                          SizedBox(
                            height: 0,
                          ),
                          Center(
                              child: Text(
                            "Order Details",
                            style: TextStyle(
                                fontSize: Dimensions.h20,
                                fontWeight: FontWeight.bold),
                          )),
                          SizedBox(
                            height: Dimensions.h10,
                          ),
                          TextFormField(
                            autocorrect: true,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Please Enter Name";
                              }
                            },
                            controller: name,
                            decoration: InputDecoration(
                              // fillColor: Colors.black,
                              hintText: "Enter Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              labelText: "Enter Name",
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.h15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.h20,
                          ),
                          TextFormField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Please Enter Mobile Number";
                              }
                              if (!RegExp(r'^[6-9]\d{9}$').hasMatch(v)) {
                                return 'Please enter a valid Indian mobile number';
                              } else {
                                return null;
                              }
                            },
                            autocorrect: true,
                            maxLength: 10,
                            controller: phone_no,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: "Phone Number",
                              prefix: Text("+91 | "),
                              hintText: " Enter Phone Number",
                              prefixIcon:
                                  Icon(Icons.phone, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.h15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.h20,
                          ),
                          TextFormField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Please Enter Address";
                                }
                              },
                              controller: address,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "Enter Address",
                                prefixIcon:
                                    Icon(Icons.home, color: Colors.black),
                                labelText: "Enter Full Address",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.h15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              )),
                          SizedBox(
                            height: Dimensions.h20,
                          ),
                          TextFormField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Please Enter Pincode";
                              } else if (!RegExp('^[1-9][0-9]{5}')
                                  .hasMatch(v)) {
                                return "Invalid Pincode";
                              }
                            },
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            controller: pincode,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "",
                              labelText: "enter Pincode",
                              prefixIcon:
                                  Icon(Icons.location_on, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.h15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.h20,
                          ),
                          Container(
                              height: Dimensions.h50,
                              width: double.infinity,
                              child: MyElevatedButton(
                                btnname: "Payment",
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    openCheckout();
                                  }
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
//if(_handlePaymentSuccess==PaymentSuccessResponse){
//                                        placeorderprovider.Placeorder(
//                                          name: name,
//                                          phone_no: phone_no,
//                                          address: address,
//                                          pincode: pincode,
//                                          context: context, total: total,
//                                          pro_name_list:widget.productslist,
//                                        );
//                                      }
