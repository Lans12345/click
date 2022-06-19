import 'package:flutter/material.dart';

class TextFieldLong extends StatelessWidget {
  late String input;
  late double leftPadding = 0;
  late double rightPadding = 0;
  late String label;
  late String suffix;

  TextFieldLong({
    required this.input,
    required this.leftPadding,
    required this.rightPadding,
    required this.label,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftPadding, 10, rightPadding, 10),
      child: TextFormField(
        maxLines: 5,
        style: const TextStyle(color: Colors.black, fontFamily: 'Quicksand'),
        onChanged: (_input) {
          input = _input;
        },
        decoration: InputDecoration(
          prefix: Text(suffix),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.black,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
