import 'package:Koopy/objects/user.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateFamily extends StatefulWidget {
  CreateFamily({Key key}) : super(key: key);

  @override
  _CreateFamilyState createState() => _CreateFamilyState();
}

class _CreateFamilyState extends State<CreateFamily> {
  bool error = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController name = TextEditingController();

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width - 40,
        margin: EdgeInsets.only(left: 20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      "Create family",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Name",
                      errorText: (error) ? "Please enter a name." : null,
                    ),
                    cursorColor: theme.primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () async {
                      if (name.value.text != "") {
                        await http.post(
                          "http://192.168.64.5:5000/family/add",
                          body: <String, String>{
                            "name": name.value.text,
                            "admin": user.id.toString(),
                          },
                        );
                        Navigator.of(context).pushReplacementNamed('/homepage');
                      } else {
                        setState(() {
                          error = true;
                        });
                      }
                    },
                    child: Text("Create"),
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
