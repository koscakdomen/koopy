import 'dart:convert';

import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddListSheet extends StatefulWidget {
  final Map families;
  final Function callback;
  AddListSheet({Key key, this.families, this.callback}) : super(key: key);

  @override
  _AddListSheetState createState() => _AddListSheetState();
}

class _AddListSheetState extends State<AddListSheet> {
  String selectedFam = "Family*";
  int selectedFamID = 0;

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add list",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Name",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 8),
              child: Divider(
                color: Colors.black54,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: FlatButton(
                      color: Colors.transparent,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 250,
                            child: Center(
                              child: ListView(
                                children: genFamilies(),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Text(
                            selectedFam,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () async {
                  int id = await http.post(
                    "http://192.168.64.5:5000/list/add",
                    body: <dynamic, dynamic>{
                      "name": name.value.text,
                      "familyID": selectedFamID.toString(),
                    },
                  ).then((response) {
                    var json = jsonDecode(response.body);
                    return json["id"];
                  });
                  Navigator.pop(context);
                  widget.callback(this.name.value.text, id);
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> genFamilies() {
    List<Widget> toReturn = new List();
    for (String key in widget.families.keys) {
      toReturn.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: () {
              setState(() {
                selectedFam = widget.families[key];
                selectedFamID = int.parse(key);
              });
              Navigator.pop(context);
            },
            child: Text(widget.families[key]),
            splashColor: Colors.transparent,
          ),
        ),
      );
    }
    return toReturn;
  }
}
