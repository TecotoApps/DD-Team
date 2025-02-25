import 'package:flutter/material.dart';

class DD_ElevatedButton extends StatefulWidget {
  final String hintText;
  VoidCallback onPressed;
  DD_ElevatedButton({required this.hintText, required this.onPressed});
  @override
  _DD_ElevatedButtonState createState() => _DD_ElevatedButtonState();
}

class _DD_ElevatedButtonState extends State<DD_ElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          color: Colors.blue),
      height: 50.0,
      width: MediaQuery.of(context).size.width * 0.40,
      child: ElevatedButton(
        child: Text(
          widget.hintText,
          style: TextStyle(fontSize: 25.0),
        ),
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }
}
