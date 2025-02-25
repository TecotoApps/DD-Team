import 'package:flutter/material.dart';

class DdDropDown extends StatefulWidget {
  String dropdownValue;
  List<String> Items;
  final ValueChanged<String> onSelectedValue;
  DdDropDown(
      {required this.dropdownValue,
      required this.Items,
      required this.onSelectedValue});

  @override
  _DdDropDownState createState() => _DdDropDownState();
}

class _DdDropDownState extends State<DdDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // Initial Value
      value: widget.dropdownValue,
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: widget.Items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        print('this is value $newValue');
        setState(() {
          widget.dropdownValue = newValue!;
          widget.onSelectedValue(newValue);
        });
      },
    );
  }
}
