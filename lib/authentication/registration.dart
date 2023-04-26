import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  static String verify = "";
  static String username = "";
  static String mobile = "";

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController countryCode = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var countryCode;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: 20),
            child: Form(
//              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo/splash.png",
                    ),
                    Text(
                      "Phone Verification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "We need to register your phone before getting started!",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                        Border.all(width: 1, color: Color(0xffF78A00)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child:
                        TextFormField(
                          controller: userName,
                          validator: (value){
                            if(userName.text.isEmpty){
                              return "Please Enter your name";
                            }
                            return null;
                          },
                          // validator: (value) {
                          //   if (userName.text.isEmpty) {
                          //     return "Please Enter Your Number";
                          //   }
                          //   return null;
                          // },
                          onSaved: (value) {
                            var mobile;
                            mobile.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name"),
                        ),
                        //                        TextFormField(
 // //                         controller: userName,
 //                          keyboardType: TextInputType.name,
 //                          // validator: (value) {
 //                          //   if (userName.text.isEmpty) {
 //                          //     return "Please Enter Your Name";
 //                          //   }
 //                          //   return null;
 //                          // },
 //                          onSaved: (value) {
 //                            var userName;
 //                            userName.text = value!;
 //                          },
 //                          textInputAction: TextInputAction.next,
 //                          decoration: const InputDecoration(
 //                              border: InputBorder.none, hintText: "Name"),
 //                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border:
                        Border.all(width: 1, color: Color(0xffF78A00)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          SizedBox(
                            width: 40,
                            child: TextFormField(
                              controller: countryCode,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              onSaved: (newValue) =>
                              countryCode.text = newValue!,
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color(0xffF78A00),
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child:

                                TextFormField(
//                              controller: mobile,
                                  keyboardType: TextInputType.number,
                                  // validator: (value) {
                                  //   if (userName.text.isEmpty) {
                                  //     return "Please Enter Your Number";
                                  //   }
                                  //   return null;
                                  // },
                                  onSaved: (value) {
                                    var mobile;
                                    mobile.text = value!;
                                  },
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Mobile Number"),

                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){},
                        // onPressed: () async {
                        //   if (_formKey.currentState!.validate()) {
                        //     await FirebaseAuth.instance.verifyPhoneNumber(
                        //       phoneNumber: "${countryCode.text + mobile.text}",
                        //       verificationCompleted:
                        //           (PhoneAuthCredential credential) {},
                        //       verificationFailed: (FirebaseAuthException e) {
                        //         Fluttertoast.showToast(msg: "Auth Failed!");
                        //       },
                        //       codeSent: (String verificationId,
                        //           int? resendToken) async {
                        //         Navigator.pushReplacementNamed(context, "otp");
                        //         Fluttertoast.showToast(msg: "OTP Sent :)");
                        //         RegistrationScreen.verify = verificationId;
                        //         RegistrationScreen.username = userName.text;
                        //         RegistrationScreen.mobile = mobile.text;
                        //       },
                        //       codeAutoRetrievalTimeout:
                        //           (String verificationId) {
                        //         Fluttertoast.showToast(msg: "Timeout!");
                        //       },
                        //     );
                        //   }
                        // },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff333333),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12)),
                        ),
                        child: Text(
                          "Send The Code",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
