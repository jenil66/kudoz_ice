// import 'package:flutter/material.dart';
//
//
// class OtpScreen extends StatefulWidget {
//   const OtpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Form(
// //        key: _formKey,
//         child: Container(
//           margin: EdgeInsets.only(
//               left: 25,
//               right: 25,
//               bottom: 25),
//           alignment: Alignment.center,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   "assets/images/otp.png",
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   "Phone Verification",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 24),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "We need to register your phone before getting started !",
//                   style: TextStyle(fontSize: 15),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Your No is ${Registration.mobile.substring(0, 3)}*****${Registration.mobile.substring(8)} ?",
//                   style: TextStyle(
//                       fontSize: 18, color: Color(0xffF78A00)),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 15),
//                 Pinput(
//                   length: 6,
//                   defaultPinTheme: defaultPinTheme,
//                   focusedPinTheme: focusedPinTheme,
//                   submittedPinTheme: submittedPinTheme,
//                   androidSmsAutofillMethod:
//                   AndroidSmsAutofillMethod.smsRetrieverApi,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter OTP";
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     pinCode = value;
//                   },
//                   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                   showCursor: true,
//                 ),
//                 SizedBox(height: 15),
//                 SizedBox(
//                   height: 45,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: (){},
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         try {
//                           PhoneAuthCredential credential =
//                           PhoneAuthProvider.credential(
//                               verificationId: RegistrationScreen.verify,
//                               smsCode: pinCode);
//                           await auth
//                               .signInWithCredential(credential)
//                               .then((value) async {
//                             postDetailsToFirestore();
//                             await HelperFunction.saveLogingData(true);
//                             Navigator.pushNamedAndRemoveUntil(
//                                 context, "home", (route) => false);
//                           });
//                         } on FirebaseAuthException {
//                           Fluttertoast.showToast(
//                               msg: "Otp Wrong !", textColor: Colors.red);
//                         }
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xffF78A00),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                     child: Text(
//                       "Verify Phone Number",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Container(
//                   alignment: Alignment.topLeft,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pushNamedAndRemoveUntil(
//                           context, "registration", (route) => false);
//                     },
//                     child: const Text(
//                       "Edit Phone Number ?",
//                       style: TextStyle(color: Color(0xffF78A00)),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
