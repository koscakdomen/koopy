import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class QuantityPicker extends StatefulWidget {
  final Function callback;
  int quantity;
  QuantityPicker({Key key, this.callback, this.quantity}) : super(key: key);

  @override
  _QuantityPickerState createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  @override
  Widget build(BuildContext context) {
    return NumberPicker.integer(
      initialValue: widget.quantity,
      minValue: 1,
      maxValue: 50,
      selectedTextStyle: TextStyle(
        color: theme.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      onChanged: (newVal) {
        setState(() {
          widget.quantity = newVal;
          widget.callback(newVal);
        });
      },
    );
  }
}
