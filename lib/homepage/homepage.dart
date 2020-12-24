import 'package:Koopy/animations/fadePageRoute.dart';
import 'package:Koopy/custom_widgets/fab.dart';
import 'package:Koopy/custom_widgets/shoppingList.dart';
import 'package:Koopy/objects/item.dart';
import 'package:Koopy/objects/user.dart';
import 'package:Koopy/settings/profile.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

bool isChecked = false;

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: theme.accentColor),
    );

    return ShoppingList();
  }
}
