import 'package:Koopy/custom_widgets/dialog.dart';
import 'package:Koopy/objects/item.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

class CustomListView extends StatefulWidget {
  final items;
  CustomListView({Key key, @required this.items}) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: generateItems(),
    );
  }

  List<Widget> generateItems() {
    List<Widget> temp = new List();
    for (Item item in widget.items) {
      temp.add(Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircularCheckBox(
              value: item.checked,
              checkColor: theme.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (val) {
                setState(() {
                  item.checked = val;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => new InfoDialog(
                    item: item,
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return temp;
  }
}
