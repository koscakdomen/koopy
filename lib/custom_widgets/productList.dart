import 'dart:convert';
import 'package:Koopy/animations/fadePageRoute.dart';
import 'package:Koopy/custom_widgets/addProductSheet.dart';
import 'package:Koopy/custom_widgets/checkbox.dart';
import 'package:Koopy/custom_widgets/dialog.dart';
import 'package:Koopy/objects/item.dart';
import 'package:Koopy/objects/user.dart';
import 'package:Koopy/settings/profile.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  final Map items;
  final Function parentSetState;
  ProductList({Key key, @required this.items, this.parentSetState})
      : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool check = false;

  void callback(bool check) {
    if (this.check != check) {
      setState(() {
        this.check = check;
      });
    }
  }

  @override
  void initState() {
    itemsAll = new List<Item>();
    widget.items.forEach((key, value) {
      value.forEach((key, value) {
        for (var product in value) {
          itemsAll.add(
            Item(
              product["id"],
              product["name"],
              product["description"],
              product["quantity"],
              DateFormat(r'''yyyy-MM-dd hh:mm:ss''')
                  .parse(product["dateAdded"]),
              null,
              product["userAdded"],
              product["userBought"],
              key,
            ),
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: false,
        backgroundColor: theme.accentColor,
        elevation: 0,
        title: Image(
          image: AssetImage('assets/images/logo.png'),
          height: 30,
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(FadePageRoute(Profile())),
            child: Hero(
              tag: 'profileSettings',
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/placeholder.png"),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: this.check
            ? FloatingActionButton(
                key: UniqueKey(),
                onPressed: () async {
                  List _items = new List();
                  for (Item item in itemsAll) {
                    if (item.checked) {
                      _items.add(item.id);
                    }
                  }
                  await http.post(
                    "http://192.168.64.5:5000/product/bought",
                    body: <String, String>{
                      "items": _items.toString(),
                      "user": user.id.toString(),
                    },
                  );
                  widget.parentSetState();
                },
                child: Icon(Icons.check),
              )
            : FloatingActionButton(
                key: UniqueKey(),
                onPressed: () {
                  showModalBottomSheet(
                    enableDrag: false,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => FutureBuilder(
                      future: getNeccessary(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return AddProduct(
                              parentSetState: widget.parentSetState,
                              lists: snapshot.data["lists"],
                              families: snapshot.data["families"]);
                        } else {
                          return Container(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  theme.primaryColor,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
      ),
      body: Container(
        height: size.height,
        width: size.width - 40,
        margin: EdgeInsets.only(left: 20),
        child: ListView(
          children: generate(),
        ),
      ),
    );
  }

  Future<Map> getNeccessary() async {
    Map toReturn = new Map();
    toReturn["lists"] = await getLists();
    toReturn["families"] = await getFamilies();
    return toReturn;
  }

  Future<Map<dynamic, dynamic>> getLists() async {
    return await http
        .get("http://192.168.64.5:5000/user/${user.id}/getLists")
        .then((value) {
      return jsonDecode(value.body);
    });
  }

  Future<Map<dynamic, dynamic>> getFamilies() async {
    return await http
        .get("http://192.168.64.5:5000/user/${user.id}/families")
        .then(
          (value) => jsonDecode(value.body),
        );
  }

  List<Widget> generate() {
    List<Widget> _return = new List();
    String sameList = "";

    if (itemsAll.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "No products in lists.",
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ];
    }

    for (Item i in itemsAll) {
      if (i.listName != sameList) {
        _return.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              i.listName,
              style: TextStyle(
                fontSize: 22,
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ),
        );
        sameList = i.listName;
      }
      _return.add(
        Row(
          children: [
            CircularCheckbox(
              item: i,
              callback: this.callback,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => new InfoDialog(
                    item: i,
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  i.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return _return;
  }
}
