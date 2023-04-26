import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/common_button.dart';
import '../widgets/common_text.dart';
import '../widgets/constant.dart';
import 'otp.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  TextEditingController countryCode = TextEditingController();
  TextEditingController userName = TextEditingController();
  var phone = '';

  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = '+91';
    super.initState();
  }

  var _containerDecoration =  BoxDecoration(color: darkgreycolor,borderRadius: BorderRadius.circular(30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
             Container(height: 100,width: 100, margin: EdgeInsets.only(top: 100), child: Image.asset('assets/kudoz.png')),
             CommonText('Kudoz', fontSize: 30, fontWeight: FontWeight.bold,),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 100, left: 20, right: 20),
                padding: EdgeInsets.only(left: 20),
                decoration: _containerDecoration,

                child: Column(
                  children: [
                    TextFormField(
                      controller: userName,
                      validator: (value){
                        if(userName.text.isEmpty){
                          return "Please Enter your name";
                        }
                        return null;
                      },

                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Name"),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width : 50,
                          child: Column(

                            children: [
                              TextField(
                                controller: countryCode,
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: CommonText('|', fontSize: 25,),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value){
                              phone = value;
                            },
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Phone',hintStyle: TextStyle(color: Colors.white, fontSize: 20), helperStyle: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CommonButton(
                  margin: EdgeInsets.only(top: 100),
                  name: txtBtnGenerateOTP,
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${countryCode.text + phone}',
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        MobileVerification.verify = verificationId;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Otp()));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}