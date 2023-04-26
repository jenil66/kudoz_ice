import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/reg_login/login.dart';
import 'package:kudoz_ice/route/routing_page.dart';
import 'package:kudoz_ice/widgets/common_button.dart';
import 'package:provider/provider.dart';

import '../provider/sign_up_provider.dart';
import '../widgets/dimesial.dart';

class reg extends StatefulWidget {
  const reg({Key? key}) : super(key: key);

  @override
  State<reg> createState() => _regState();
}

class _regState extends State<reg> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    Signupauthprovider signupauthprovider =
        Provider.of<Signupauthprovider>(context);

    return Center(
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
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/kudoz.png',
                              height: Dimensions.h120,
                              width: Dimensions.w120,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.h10,
                      ),
                      Center(
                          child: Text(
                        "Let's Get Started!",
                        style: TextStyle(fontSize: Dimensions.h30, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 0,
                      ),
                      Center(
                          child: Text(
                        "Create Account",
                        style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: Dimensions.h10,
                      ),
                      TextFormField(
                        controller: name,
                        // validator:(value){
                        //   if(value==""){
                        //     return "Please Fill Name";
                        //   }
                        //   else if(value!.length < 6 ){
                        //     return "Username Is Too Short";
                        //   }
                        //   return"";
                        // },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: "Enter Name",
                          prefixIcon: Icon(Icons.person,color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: "Enter Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.h15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.h20,
                      ),
                      TextFormField(
                          controller: email,
                          // validator:(value){
                          //   if(value==""){
                          //     return "Please Fill Email Addresss";
                          //   }
                          //   else if( !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)){
                          //     return "Enter Correct Email Address";
                          //   }
                          //   else {
                          //     return "";
                          //   }
                          // },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "ex. abc1234@gmail.com",
                            prefixIcon: Icon(Icons.email,color: Colors.black),
                            labelText: "Enter email id",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.h15),
                            ),
                          )),
                      SizedBox(
                        height: Dimensions.h20,
                      ),
                      // TextFormField(
                      //     // validator:(value){
                      //     //   if(value==""){
                      //     //     return "Please Fill Phone Number";
                      //     //   }
                      //     //   else if(value!.length <10 ){
                      //     //     return "Invalid Mobile Number ";
                      //     //   }
                      //     //   else{
                      //     //     return"";
                      //     //   }
                      //     // },
                      //     decoration: InputDecoration(
                      //       hintText: "Enter mobile number",
                      //       prefixIcon: Icon(Icons.phone),
                      //       prefixText: "+91   |   ",prefixStyle: TextStyle(fontSize: 15),
                      //       labelText: "Mobile number",
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //     )),
                      SizedBox(
                          // height: 20,
                          ),
                      TextFormField(
                        controller: password,
                        // validator: (value){
                        //   if(value==""){
                        //     return "plase fill password";
                        //   }
                        //   else if (value!.length <6||value!.length>20){
                        //     return "Password must be 8 character to 20 charecter";
                        //   }
                        //   else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value!)){
                        //     return "PaSSword is week.(In password 1 uppercase letters,1 lowercase letters,\n1 special characters and 1 number";
                        //   }
                        //   return "";
                        // },
                        obscureText: visibility,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: " Ex. abc@123",
                          labelText: "enter password",
                          prefixIcon: Icon(Icons.lock_open,color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visibility = !visibility;
                              });
                            },
                            icon: Icon(visibility
                                ? Icons.visibility_off
                                : Icons.visibility,color: Colors.black,),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.h15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.h20,
                      ),
                      // TextFormField(
                      //   obscureText: true,
                      //   decoration: InputDecoration(
                      //     labelText: "retype password",
                      //     prefixIcon: Icon(Icons.lock),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                          height: Dimensions.h50,
                          width: double.infinity,
                          child: signupauthprovider.loading == false
                              ? MyElevatedButton(
                                  btnname: "Sign Up",
                                  onPressed: () {
                                    signupauthprovider.signupvalidation(
                                        name: name,
                                        email: email,
                                        password: password,
                                        context: context
                                    );
                                  },
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                )),
                      SizedBox(height: Dimensions.h30),
                      // Center(child: Text("Sign Up With",style: TextStyle(fontWeight: FontWeight.bold),)),
                      // SizedBox(height: 20,),
                      // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      //   RaisedButton(onPressed: (){},child: Container(child: Row(children: [Image.asset('assets/Facebook.png',height: 25),Text("facebook",style: TextStyle(fontSize: 15),)],),)),
                      //   RaisedButton(onPressed: (){},
                      //     child: (Container(child: Row(children: [Image.asset('assets/google.png',height: 25),Text("Google",style: TextStyle(fontSize: 15),)],),)),
                      //   ),
                      //
                      // ],),
                      SizedBox(
                        height: Dimensions.h10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("I Have Already An Account?",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 5,),
                        GestureDetector(
                              onTap: (){
                                setState(() {
                                  Routingpage.gotonext(context: context, navigateto: login());
                                });
                              },
                              child: Text("Log In",
                                  style: TextStyle(
                                    color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.h15)),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
