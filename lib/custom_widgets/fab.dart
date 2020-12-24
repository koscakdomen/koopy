import 'package:flutter/material.dart';

class FAB extends StatefulWidget {
  final Icon icon;
  FAB({Key key, this.icon}) : super(key: key);

  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> {
  IconData icon;

  void changeIcon(IconData icon) {
    setState(() {
      this.icon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(this.icon),
      ),
    );
  }
}
