import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kudoz_ice/pages/home_screen.dart';
import 'package:kudoz_ice/route/routing_page.dart';

import '../widgets/common_button.dart';
import '../widgets/dimesial.dart';

class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "Contact Us",
          style:
              TextStyle(color: Color(0xffF42852), fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We'd love to hear from you!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "You can reach us by email or phone:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 16),
                  Text(
                    "kudozicecream2@gmail.com",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 16),
                  Text(
                    "+91 1234567890",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                "Or send us a message:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Message can't empty";
                      }
                    },
                    controller: message,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Enter Your Message",
                      prefixIcon: Icon(Icons.home, color: Colors.black),
                      labelText: "Enter Message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.h15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    )),
              ),
              SizedBox(height: 16),
              MyElevatedButton(
                btnname: 'Send',
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection("Contact Page")
                        .doc()
                        .set({
                      "message": message.text,
                      "uid": FirebaseAuth.instance.currentUser!.uid,
                      "email": FirebaseAuth.instance.currentUser!.email,
                      "date-time":
                          '${DateFormat.yMMMEd().format(DateTime.now())} ${DateFormat.jm().format(DateTime.now())}'
                    }).then((value) => setState(() {
                              Fluttertoast.showToast(
                                  msg: "Message Send SuccessFully");
                              Navigator.pop(context);
                              Navigator.pop(context);

                            }));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
