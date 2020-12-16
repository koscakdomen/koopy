import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String animation = 'splashscreen';
  double bottom = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: size.width - 80,
            margin: EdgeInsets.only(left: 40),
            child: Hero(
              tag: 'animation',
              child: FlareActor(
                "assets/animations/splashscreen.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: animation,
              ),
            ),
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container();
              } else {
                return Container();
              }
            },
            future: futureFunction(),
          )
        ],
      ),
    );
  }

  Future futureFunction() async {
    await Future.delayed(Duration(milliseconds: 4200));
    Navigator.of(context).pushReplacementNamed('/signup');
    return true;
  }
}
