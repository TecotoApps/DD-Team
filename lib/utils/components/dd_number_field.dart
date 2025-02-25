import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DD_NumberField extends StatefulWidget {
  final String hintText;
  final TextEditingController ddController;
  DD_NumberField({required this.hintText, required this.ddController});
  @override
  _DD_NumberFieldState createState() => _DD_NumberFieldState();
}

class _DD_NumberFieldState extends State<DD_NumberField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width * 0.80,
      child: TextFormField(
        controller: widget.ddController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }
}
