import 'package:Koopy/objects/user.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    await Future.delayed(Duration(milliseconds: 4200));
    if (prefs.get("userName") != null &&
        prefs.get("userMail") != null &&
        prefs.get("password") != null &&
        prefs.get("userID") != null) {
      user.id = prefs.getInt("userID");
      user.name = prefs.getString("userName");
      user.mail = prefs.getString("userMail");
      user.password = prefs.getString("password");
      await http.post(
        "http://192.168.64.5:5000/user/${user.id}/login",
        body: <String, dynamic>{
          "password": user.password,
        },
      ).then((response) {
        if (response.statusCode == 200) {
          Navigator.of(context).pushReplacementNamed('/homepage');
        } else {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      });
    } else {
      Navigator.of(context).pushReplacementNamed('/signup');
    }
    return true;
  }
}
