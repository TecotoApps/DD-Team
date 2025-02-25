import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DD_TextField extends StatefulWidget {
  final String hintText;
  final TextEditingController ddController;
  DD_TextField({required this.hintText, required this.ddController});
  @override
  _DD_TextFieldState createState() => _DD_TextFieldState();
}

class _DD_TextFieldState extends State<DD_TextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width * 0.80,
      child: TextFormField(
        controller: widget.ddController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }
}
