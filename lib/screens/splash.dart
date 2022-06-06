

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_me/screens/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (context)=>const OnBoarding()
            )));
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return Scaffold(
          body:
          SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                    color: Colors.white60,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png',
                    height: 53,
                  ),
                  const SizedBox(width: 7,),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Taskfun',
                          textAlign: TextAlign.justify,
                          textStyle: const TextStyle(
                              letterSpacing: 2,
                              color: Color(0xFF2B3849),
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          )),],
                    isRepeatingAnimation: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
