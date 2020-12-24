import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Koopy/animations/fadein.dart';
import 'package:Koopy/theme.dart';
import 'package:Koopy/objects/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_strength/password_strength.dart';
import 'package:http/http.dart' as http;

class Password extends StatefulWidget {
  Password({Key key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  Color color = Colors.transparent;
  double width;
  String text = "";
  bool button = false;
  bool visible = false;
  bool visible1 = false;

  TextEditingController password = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
              Column(
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
                        controller: password,
                        obscureText: !visible,
                        decoration: InputDecoration(
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
                        onChanged: (value) {
                          double strength = estimatePasswordStrength(value);
                          setState(() {
                            if (strength < 0.3) {
                              color = Colors.red;
                              width = (size.width - 75) / 4;
                              text = "It's not good enough.";
                              button = false;
                            } else if (strength < 0.5) {
                              color = Colors.orange;
                              width = (size.width - 75) / 2;
                              text = 'I know you can do better.';
                              button = false;
                            } else if (strength < 0.8) {
                              color = Colors.lightGreen;
                              width = ((size.width - 75) / 4) * 3;
                              text = "It's OK. Just OK.";
                              button = true;
                            } else {
                              color = theme.primaryColor;
                              width = size.width - 75;
                              text = "Damn, a good password!";
                              button = true;
                            }
                          });
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: size.width - 75,
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 5,
                          width: (width == null) ? size.width - 75 : width,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [Text(text)],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeIn(
                    2.5,
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        obscureText: !visible1,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              visible1 = !visible1;
                            }),
                            icon: (visible1)
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          labelText: "Repeat password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (password.value.text == value) {
                            return null;
                          }
                          return "Passwords do not match!";
                        },
                        cursorColor: theme.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  FadeIn(
                    3,
                    FlatButton(
                      onPressed: (button)
                          ? () async {
                              if (_formKey.currentState.validate()) {
                                await http.post(
                                  "http://192.168.64.5:5000/user/add",
                                  body: <String, String>{
                                    'name': user.name,
                                    'mail': user.mail,
                                    'password': password.value.text
                                  },
                                ).then((value) async {
                                  var json = jsonDecode(value.body);
                                  user.id = json["id"];
                                  user.name = json["name"];
                                  user.mail = json["mail"];
                                  user.password = json["password"];
                                  if (value.statusCode == 200) {
                                    Future<SharedPreferences> _prefs =
                                        SharedPreferences.getInstance();
                                    SharedPreferences prefs = await _prefs;
                                    prefs.setString("userName", user.name);
                                    prefs.setString("userMail", user.mail);
                                    prefs.setInt("userID", user.id);
                                    prefs.setString("password", user.password);
                                    Navigator.of(context)
                                        .pushReplacementNamed('/create_family');
                                  }
                                });
                              }
                            }
                          : null,
                      child: Text(
                        "CONTINUE",
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
