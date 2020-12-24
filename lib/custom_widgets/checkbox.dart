import 'package:Koopy/custom_widgets/fab.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:Koopy/objects/item.dart';

class CircularCheckbox extends StatefulWidget {
  final Item item;
  final Function callback;
  CircularCheckbox({Key key, @required this.item, this.callback})
      : super(key: key);

  @override
  _CircularCheckboxState createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox> {
  @override
  Widget build(BuildContext context) {
    return CircularCheckBox(
      value: widget.item.checked,
      checkColor: theme.primaryColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onChanged: (val) {
        setState(() {
          widget.item.checked = val;
        });
        bool temp = false;
        for (Item i in itemsAll) {
          if (i.checked) {
            temp = true;
            break;
          }
        }
        if (!temp && !val) {
          widget.callback(false);
        } else {
          widget.callback(true);
        }
      },
    );
  }
}
