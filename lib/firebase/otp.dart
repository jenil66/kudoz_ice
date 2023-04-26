import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kudoz_ice/pages/home_screen.dart';
import 'package:sizer/sizer.dart';
import '../widgets/common_button.dart';
import '../widgets/constant.dart';
import 'mobile_verification.dart';
import '../widgets/common_text.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var _containerDecoration =  BoxDecoration(color: darkgreycolor,borderRadius: BorderRadius.circular(30));

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    UserCredential? userCredential;
    var code = '';
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 200,width: 200, margin: EdgeInsets.only(top: 30), child: Image.asset('assets/kudoz.png')),
            CommonText(txtTwoSoul, fontSize: 30, fontWeight: FontWeight.bold,),
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 100),
              padding: EdgeInsets.only(left: 20),
              decoration: _containerDecoration,
              child: Expanded(
                child: TextField(
                  keyboardType: TextInputType.phone,
                  onChanged: (value){
                    code = value;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: InputBorder.none, hintText: txtEnterYourOTP,hintStyle: TextStyle(color: white50, fontSize: 20), helperStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            CommonButton(
                name: txtBtnSubmit,
                onPressed: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MobileVerification.verify, smsCode: code);
                  // FirebaseFirestore.instance.collection("users").doc(userCredential!.user!.uid).set({
                  //   "name":txtUsername,
                  //   "phone number":pho,
                  //    "uid":userCredential!.user!.uid
                  // });
                  await auth.signInWithCredential(credential);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => btn()));
                }
            )
          ],
        ),
      ),
    );
  }
}