import 'package:Koopy/animations/fadePageRoute.dart';
import 'package:Koopy/custom_widgets/shoppingList.dart';
import 'package:Koopy/settings/profile.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: theme.primaryColor,),
      ),
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
          IconButton(
            icon: Icon(
              Icons.search,
              color: theme.primaryColor,
            ),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(FadePageRoute(Profile())),
            child: Hero(
              tag: 'profile',
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
      body: Container(
        height: size.height,
        width: size.width - 32,
        margin: EdgeInsets.only(left: 16),
        child: Column(
          children: [
            Container(
              height: (size.height - 84),
              child: ShoppingList(),
            ),
          ],
        ),
      ),
    );
  }
}
