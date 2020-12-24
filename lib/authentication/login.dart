import 'dart:convert';
import 'package:Koopy/animations/fadein.dart';
import 'package:Koopy/objects/user.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visible = false;
  String mailError, passwordError;

  TextEditingController mailController = new TextEditingController(),
      passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width - 75,
        margin: EdgeInsets.only(left: 37.5),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    FadeIn(
                      1.5,
                      Image(
                        image: AssetImage("assets/images/logo.png"),
                        height: 75,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    FadeIn(
                      2,
                      TextField(
                        controller: mailController,
                        decoration: InputDecoration(
                          labelText: "E-Mail",
                          prefixIcon: Icon(Icons.mail),
                          errorText: mailError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        cursorColor: theme.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    FadeIn(
                      2.5,
                      TextField(
                        controller: passwordController,
                        obscureText: !visible,
                        decoration: InputDecoration(
                          errorText: passwordError,
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              visible = !visible;
                            }),
                            icon: (visible)
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        cursorColor: theme.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    FadeIn(
                      3,
                      FlatButton(
                        onPressed: () {
                          login(mailController.value.text,
                              passwordController.value.text);
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                        color: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledColor: theme.primaryColor.withAlpha(128),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FadeIn(
                      3.5,
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                        child: Text("Sign up instead"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(String mail, String password) async {
    var id;
    var idResponse = await http.get(
      "http://192.168.64.5:5000/user/getID/" + Uri.encodeComponent(mail),
    );
    id = idResponse.body;
    if (id == "null") {
      setState(() {
        mailError = "User with this e-mail does not exist.";
        passwordError = null;
      });
    } else {
      var login = await http.post(
        "http://192.168.64.5:5000/user/$id/login",
        body: <String, String>{
          "password": passwordController.value.text,
        },
      );
      if (login.statusCode == 400) {
        setState(() {
          passwordError = login.body;
          mailError = null;
        });
      } else {
        setState(() {
          passwordError = null;
          mailError = null;
        });
        Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        SharedPreferences prefs = await _prefs;
        var cred = jsonDecode(login.body);
        prefs.setString("userName", cred["name"]);
        prefs.setString("userMail", cred["mail"]);
        prefs.setString("password", cred["password"]);
        prefs.setInt("userID", cred["id"]);
        user.id = cred["id"];
        user.name = cred["name"];
        user.mail = cred["mail"];
        user.password = cred["password"];
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    }
  }
}
