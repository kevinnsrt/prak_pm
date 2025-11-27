
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:prak_pm/screen/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _navigateToNextScreen(){
   Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade,
   curve: Curves.easeIn,
   child: LoginPage(),duration: Duration(milliseconds: 300,) ));
  }

  @override
  void initState(){
    super.initState();
    Timer(
      Duration(milliseconds: 2500),
      _navigateToNextScreen,
    );
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 148, 300, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/header.png"),
            Image.asset("assets/logo.png", width: 130, height: 137),
            Image.asset("assets/footer.png"),
            
          ],
        ),
      ),
    );
  }
}
