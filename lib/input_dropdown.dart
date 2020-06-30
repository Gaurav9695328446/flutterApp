import 'package:flutter/material.dart';

class InputDropDown extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final List<String> optionsArr;

  InputDropDown({
    this.hintText,
    this.validator,
    this.onSaved,
    this.optionsArr,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.white),
          hintText: hintText,
          contentPadding: EdgeInsets.all(5.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        items: optionsArr.map((String dropDownItem) {
          return DropdownMenuItem<String>(
            value: dropDownItem,
            child: Text(dropDownItem, style: TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: onSaved,
      ),
    );
  }
}
