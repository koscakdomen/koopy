import 'package:Koopy/custom_widgets/customListView.dart';
import 'package:Koopy/objects/item.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  var widgets = {"asd", "dsa", "sda"};
  String animation = "Idle";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SizedBox(
            height: 16,
          ),
          Text(
            "Seznam 1",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.primaryColor,
              fontFamily: 'Nunito',
            ),
          ),
          CustomListView(items: [
            Item("Macaroni", "Test", 3, DateTime.utc(2020, 12, 16), null, 1, null),
          ])
        ],
      ),
    );
  }
}
