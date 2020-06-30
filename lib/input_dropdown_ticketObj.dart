import 'package:desktop_app/ticketType.dart';
import 'package:flutter/material.dart';

class InputDropDownTicketArr extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final List<TicketType> optionsArr;
  final TicketType ticketValue;

  InputDropDownTicketArr(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.optionsArr,
      this.ticketValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: DropdownButtonFormField<TicketType>(
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
        items: optionsArr.map((TicketType ticketType) {
          return new DropdownMenuItem<TicketType>(
            value: ticketType,
            child: new Text(
              ticketType.name,
              style: new TextStyle(color: Colors.black, fontSize: 14),
            ),
          );
        }).toList(),
        value: ticketValue,
        onChanged: onSaved,
      ),
    );
  }
}
