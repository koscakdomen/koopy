import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String title;
  const CustomChip({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          label: Text(
            this.title,
            style: TextStyle(color: Color(0xff91ee94)),
          ),
          shape: StadiumBorder(
              side: BorderSide(color: Color(0xff91ee94), width: 2)),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
