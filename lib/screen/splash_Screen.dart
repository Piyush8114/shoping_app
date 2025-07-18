import 'package:flutter/material.dart';
import 'package:shoping_app/screen/home_screen.dart';
import 'package:shoping_app/screen/login_screen.dart';
import 'package:shoping_app/utils/app_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      AppPref().getUserToken().then((token) {
        if (token == "") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/shoping.png") ?? Icon(Icons.broken_image, color: Colors.grey),
        ),
      ), 
    );
  }
}
