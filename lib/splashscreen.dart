import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nextlink/log_in_screen.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  void _changeState() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 1000), () {
      animationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => const LogInScreen()),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _changeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 168, 210, 255),
              // Color.fromARGB(255, 210, 245, 235),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: animationController,
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: Image(image: AssetImage('LOGO.png')),
                ), //SizedBox
                builder: (BuildContext context, Widget? child) {
                  return Transform.scale(
                    scale: animationController.value,
                    child: child,
                  );
                },
              ), //AnimatedBuilder
            ), //Center
          ],
        ), //Column
      ), //Container
    );
  }
}
