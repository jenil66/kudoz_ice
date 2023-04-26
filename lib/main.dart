
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kudoz_ice/provider/cart_provider.dart';
import 'package:kudoz_ice/provider/favorite_provider.dart';
import 'package:kudoz_ice/provider/login_auth_provider.dart';
import 'package:kudoz_ice/provider/sign_up_provider.dart';
import 'package:kudoz_ice/reg_login/Sign_up.dart';
import 'package:kudoz_ice/reg_login/splash_screen.dart';
import 'package:provider/provider.dart';
import 'authentication/registration.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Signupauthprovider()),
        ChangeNotifierProvider(create: (context)=>Loginauthprovider()),
        ChangeNotifierProvider(create: (context)=>Cartprovider()),
        ChangeNotifierProvider(create: (context)=>Favoriteprovider()),
        // ChangeNotifierProvider(create: (context)=>Placeorderprovider()),
        // ChangeNotifierProvider(create: (context)=>ProductProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Kudoz Ice-cream",
        home:SplashScreen(),
      )
    );
  }
}

// Variant: debug
// Config: debug
// Store: C:\Users\Jenil\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: B0:06:E3:41:77:00:CA:DC:01:FA:30:56:8E:E9:B9:DD
// SHA1: 05:F1:9B:5A:65:2F:B0:43:21:0E:B2:41:06:A1:36:85:B9:24:B5:BC
// SHA-256: 18:27:84:38:02:AF:E2:CE:93:44:BE:C9:86:F4:9D:64:CB:DF:4E:3F:81:53:B4:6A:AD:A4:4D:CE:C6:64:2E:F4
// Valid until: Thursday, 30 January, 2053
// ----------

