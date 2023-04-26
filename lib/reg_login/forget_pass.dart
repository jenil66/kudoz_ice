import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/widgets/common_button.dart';
import '../widgets/dimesial.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "Forgot Password",
          style: TextStyle(
            color: Color(0xffF42852),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.h8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: Dimensions.h30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.h40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "ex. abc1234@gmail.com",
                    prefixIcon: Icon(Icons.email, color: Colors.black),
                    labelText: "Enter email id",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.h15),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                MyElevatedButton(
                  btnname: "Send Request",
                  onPressed: () async {
                    String email = _emailController.text;
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "An email has been sent to $email. Please verify.",
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      if (e is FirebaseAuthException && e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "The email $email is not registered. Please check your email address and try again.",
                            ),
                          ),
                        );
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please enter a valid email address.",
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
