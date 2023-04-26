import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/pages/home_screen.dart';

import 'package:kudoz_ice/reg_login/Sign_up.dart';
import 'package:kudoz_ice/route/routing_page.dart';
import 'package:kudoz_ice/widgets/common_button.dart';
import 'package:provider/provider.dart';

import '../provider/login_auth_provider.dart';
import '../widgets/dimesial.dart';
import 'forget_pass.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loding = false;

  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    Loginauthprovider loginauthprovider =
        Provider.of<Loginauthprovider>(context);

    return Container(
      color: Colors.white,
      // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('asset/login.png'),fit: BoxFit.fill),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
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
                    "Welcome Back!",
                    style: TextStyle(fontSize: Dimensions.h30, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 0,
                  ),
                  Center(
                      child: Text(
                    "Log In Account",
                    style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
                  )),

                  SizedBox(
                    height: Dimensions.h20,
                  ),
                  TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: "ex. abc1234@gmail.com",
                        prefixIcon: Icon(Icons.email,color: Colors.black),
                        labelText: "Enter email id",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.h15),
                        ),
                      )),
                  SizedBox(
                    height: Dimensions.h20,
                  ),
                  SizedBox(
                      // height: 20,
                      ),
                  TextFormField(
                    controller: password,
                    obscureText: visibility,
                    decoration: InputDecoration(

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                      counter: GestureDetector(
                        onTap: (){
                          Routingpage.gotonext(context: context, navigateto: ForgetPassword());
                        },
                        child: Text("Forgot Password?",style: TextStyle(color: Colors.blue),),
                      ),
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
                            : Icons.visibility,color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.h15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.h20,
                  ),
                  Container(
                      height: Dimensions.h50,
                      width: double.infinity,
                      child: loginauthprovider.loading == false
                          ? MyElevatedButton(
                              btnname: "Login",
                              onPressed: () {
                                loginauthprovider.loginvalidation(
                                  email: email,
                                  password: password,
                                  context: context,
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            )),
                  SizedBox(height: Dimensions.h30
                  ),
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
                      Text("Create New Account?",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                       SizedBox(width: 5,),
                       GestureDetector(
                          onTap: () {
                            setState(() {
                              Routingpage.gotonext(
                                context: context,
                                navigateto: reg(),
                              );
                            });
                          },
                          child: Text("Sign Up",
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
        ),
      ),
    );
  }
}
