import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/pages/home_screen.dart';
import '../widgets/dimesial.dart';
import 'Sign_up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      if (_controller.isCompleted) {
        wheretogo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/kudoz.png',
                height: Dimensions.h150,
                width: Dimensions.w150,
              ),
            ),
            SizedBox(height: Dimensions.h20),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Kudoz',
                style: TextStyle(
                    color: Color(0xffF78A00),
                    fontSize: Dimensions.h50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: Dimensions.h10),
            FadeTransition(
              opacity: _animation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Icecream ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.h20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '&',
                    style: TextStyle(
                        color: Color(0xffF78A00),
                        fontSize: Dimensions.h20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' Eatery',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.h20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void wheretogo() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => btn()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => reg()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


