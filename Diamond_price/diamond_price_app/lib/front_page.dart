import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:diamond_price_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class front_page extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Center(
          child:AnimatedTextKit(
            totalRepeatCount: 1,
            onFinished: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
            },
            animatedTexts: [
              FadeAnimatedText("Welcome To",
                  textStyle: TextStyle(fontFamily: "DancingScript-Regular",fontSize: 45,color: Colors.white),
                  textAlign: TextAlign.center,duration: Duration(milliseconds: 4000)),
              WavyAnimatedText("Diamond Store",
                  textStyle: TextStyle(fontFamily: "DancingScript-Regular",fontSize: 45,color: Colors.white),
              textAlign: TextAlign.center,speed: Duration(milliseconds: 300))
            ],
          )
        ),
      ),
    );
  }

}