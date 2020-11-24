import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            padding: EdgeInsets.only(bottom: bottom),
            child: FlareActor(
              "assets/animations/splashscreen.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: animation,
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
