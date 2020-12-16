import 'package:flutter/material.dart';

class Recipe extends StatelessWidget {
  final double h, w;
  final NetworkImage image;
  final String title;
  const Recipe({Key key, this.h, this.w, this.image, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.h,
      width: this.w,
      color: Colors.grey,
    );
  }
}
