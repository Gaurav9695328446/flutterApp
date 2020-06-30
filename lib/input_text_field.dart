import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;

  InputTextField({
    this.hintText,
    this.validator,
    this.onSaved,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: TextFormField(
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.white),
          hintText: hintText,
          contentPadding: EdgeInsets.all(2.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
