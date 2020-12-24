import 'package:Koopy/custom_widgets/addListSheet.dart';
import 'package:Koopy/objects/user.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  final Map lists, families;
  final Function parentSetState;
  AddProduct({Key key, this.lists, this.parentSetState, this.families})
      : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _quantity = "Quantity*";
  int quantity = 1;
  String selectedList = "List*";
  int selectedListIndex = 0;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  void callback(String name, int listID) {
    setState(() {
      selectedList = name;
      selectedListIndex = listID;
    });
  }

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
            Column(
              children: [
                Text(
                  "Add item",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: name,
                          textInputAction: TextInputAction.done,
                          cursorColor: theme.primaryColor,
                          decoration: InputDecoration(
                            labelText: "Name*",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
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
                                  child: ListView.builder(
                                    itemCount: 50,
                                    itemBuilder: (_, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              quantity = i + 1;
                                              _quantity = (i + 1).toString();
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text((i + 1).toString()),
                                          splashColor: Colors.transparent,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            _quantity,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: description,
                  maxLines: 5,
                  minLines: 3,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                                    children: genLists(),
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
                                selectedList,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => AddListSheet(
                              callback: this.callback,
                              families: widget.families,
                            ),
                          );
                        },
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
                      await http.post(
                        "http://192.168.64.5:5000/product/add",
                        body: <dynamic, dynamic>{
                          "name": name.value.text,
                          "quantity": quantity.toString(),
                          "description": description.value.text,
                          "userID": user.id.toString(),
                          "listID": selectedListIndex.toString(),
                        },
                      );
                      Navigator.pop(context);
                      widget.parentSetState();
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
          ],
        ),
      ),
    );
  }

  List<Widget> genLists() {
    List<Widget> toReturn = new List();
    for (String key in widget.lists.keys) {
      toReturn.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: () {
              setState(() {
                selectedList = widget.lists[key];
                selectedListIndex = int.parse(key);
              });
              Navigator.pop(context);
            },
            child: Text(widget.lists[key]),
            splashColor: Colors.transparent,
          ),
        ),
      );
    }
    return toReturn;
  }
}
