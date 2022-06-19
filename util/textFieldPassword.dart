import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  late String input;
  late double leftPadding = 0;
  late double rightPadding = 0;
  late String label;

  TextFieldPassword({
    required this.input,
    required this.leftPadding,
    required this.rightPadding,
    required this.label,
  });

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  late String input;
  late double leftPadding = 0;
  late double rightPadding = 0;
  late String label;
  bool password = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(widget.leftPadding, 10, widget.rightPadding, 10),
      child: TextFormField(
        obscureText: password,
        style: const TextStyle(color: Colors.black, fontFamily: 'Quicksand'),
        onChanged: (_input) {
          input = _input;
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.remove_red_eye, color: Colors.black),
            onPressed: () {
              setState(() {
                password = !password;
              });
            },
          ),
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
          labelText: widget.label,
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
