import 'dart:convert';
import 'package:Koopy/custom_widgets/checkbox.dart';
import 'package:Koopy/custom_widgets/dialog.dart';
import 'package:Koopy/custom_widgets/fab.dart';
import 'package:Koopy/custom_widgets/productList.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:Koopy/objects/item.dart';
import 'package:Koopy/objects/user.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  void callback() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(theme.primaryColor),
              ),
            ),
          );
        } else {
          return ProductList(
            parentSetState: this.callback,
            items: snapshot.data,
          );
        }
      },
      future: getItems(),
    );
  }

  Future<Map> getItems() async {
    return await http
        .get("http://192.168.64.5:5000/list/getProducts/${user.id}")
        .then((response) async {
      Map _response = await json.decode(response.body);
      return _response;
    });
  }
}
