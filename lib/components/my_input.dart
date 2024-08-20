import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyInput extends StatelessWidget {
  String placeholder;
  bool type;
  List<TextInputFormatter>? inputFormatters;

  TextEditingController controller;

  MyInput(
      {Key? key,
      required this.placeholder,
      required this.type,
      required this.controller,
      this.inputFormatters,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: TextField(
        controller: controller,
        obscureText: type,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: placeholder,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}
