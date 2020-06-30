import 'package:desktop_app/vehicleType.dart';
import 'package:flutter/material.dart';

class InputDropDownObjArr extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final List<VehicleType> optionsArr;
  final VehicleType selectedValue;

  InputDropDownObjArr(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.optionsArr,
      this.selectedValue});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: DropdownButtonFormField<VehicleType>(
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
        items: optionsArr.map((VehicleType vehicleType) {
          return new DropdownMenuItem<VehicleType>(
            value: vehicleType,
            child: new Text(
              vehicleType.name,
              style: new TextStyle(color: Colors.black, fontSize: 14),
            ),
          );
        }).toList(),
        value: selectedValue,
        onChanged: onSaved,
      ),
    );
  }
}
