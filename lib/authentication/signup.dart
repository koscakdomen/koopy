import 'package:Koopy/animations/fadein.dart';
import 'package:Koopy/objects/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../theme.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = new TextEditingController(),
      mailController = new TextEditingController();

  String nameError, mailError;
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width - 75,
        margin: EdgeInsets.only(left: 37.5),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person),
                      errorText: nameError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    cursorColor: theme.primaryColor,
                    onChanged: (value) => checkName(value),
                  ),
                ),
                SizedBox(
                  height: 35,
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
                  height: 150,
                ),
                FadeIn(
                  3,
                  FlatButton(
                    onPressed: () {
                      submitted = true;
                      if (checkName(nameController.value.text)) {
                        checkMail(mailController.value.text).then((value) {
                          if (value) {
                            user.name = nameController.value.text;
                            user.mail = mailController.value.text;
                            Navigator.of(context).pushNamed('/signup_password');
                          }
                        });
                      }
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
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
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Text("Log in instead"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool checkName(String name) {
    RegExp reg = RegExp('^[a-zA-Z0-9]+ .+');
    if (submitted) {
      if (reg.hasMatch(name)) {
        setState(() {
          nameError = null;
        });
        return true;
      } else {
        setState(() {
          nameError = "Please enter real name.";
        });
        return false;
      }
    }
    return false;
  }

  Future<bool> checkMail(String mail) async {
    RegExp reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]+');
    if (reg.hasMatch(mail)) {
      var response = await http.post(
        'http://192.168.64.5:5000/user/email',
        body: <String, String>{"mail": mail},
      );
      if (response.body == "") {
        setState(() {
          mailError = null;
        });
        return true;
      } else {
        setState(() {
          mailError = response.body;
        });
        return false;
      }
    }
    return false;
  }
}
