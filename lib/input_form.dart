import 'package:desktop_app/input_dropdown_obj.dart';
import 'package:desktop_app/input_dropdown_ticketObj.dart';
import 'package:desktop_app/ticketType.dart';
import 'package:desktop_app/vehicleType.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'package:desktop_app/model.dart';
import 'package:desktop_app/input_text_field.dart';
import 'package:desktop_app/input_dropdown.dart';
import 'package:flutter/services.dart';

class TestForm extends StatefulWidget {
  final Function onSaved;
  final Function onSelectedValueChange;
  final Function onVehicleTypeChange;
  final Function onTicketTypeChange;
  final Function onVehiclePrefixChange;
  final Function onVehicleSuffixChange;
  final Function onPrintSaveClicked;
  final Function onSetModel;
  final Function onSelectedTagChange;

  TestForm(
      {this.onSaved,
      this.onSelectedValueChange,
      this.onVehicleTypeChange,
      this.onTicketTypeChange,
      this.onVehiclePrefixChange,
      this.onVehicleSuffixChange,
      this.onPrintSaveClicked,
      this.onSetModel,
      this.onSelectedTagChange});

  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  VehicleType selectedType;
  TicketType ticketType;
  bool isVisible = false;
  final FocusNode _focusNode = FocusNode();

  List<VehicleType> vehicleTypes = <VehicleType>[
    const VehicleType('Car, Jeep, Van [LMV]', '65', 'LMV'),
    const VehicleType('Light Comm Veh., Mini Bus [LCV]', '110', 'LCV'),
    const VehicleType('Truck or Bus [TRK]', '225', 'TRK'),
    const VehicleType('Three Axel Commercial vehicle [HMV]', '245', 'HMV'),
    const VehicleType('HCM,EME,MAV (4-6 Axel) [MAV]', '355', 'MAV'),
    const VehicleType('Oversized Vehicle (> 6 Axel) [OSV]', '430', 'OSV'),
  ];
  var _paymentType = ['CASH', 'POS'];
  List<TicketType> ticketTypes = <TicketType>[
    const TicketType('Single Journey Ticket [SJT]', 'SJT'),
    const TicketType('Return Ticket [RT]', 'RT'),
    const TicketType('Coupon Entry [DER]', 'DER'),
    const TicketType('Whilte Pass Holder [WP]', "WP"),
    const TicketType('Exempted Vehicle [EXM]', 'EXM'),
    const TicketType('Repeat Vehicle Entry [RPT]', "RPT"),
    const TicketType('Local Commercial [LT]', 'LT'),
  ];
  var _vehicle = [
    'Police Van',
    'Free /Local Vehicle',
    'Auto',
    'Fire Brigade',
    'Government vehicles',
    'Post and Telegraphs',
    'Tractor(Agriculture Vehicle)',
    'Military Vehicle',
    'Ambulance'
  ];
  final _formKey = GlobalKey<FormState>();
  Model model = new Model();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.physicalKey == PhysicalKeyboardKey.f1) {
      setState(() {
        selectedType = const VehicleType('Car, Jeep, Van [LMV]', '65', 'LMV');
      });
      widget.onSelectedValueChange(selectedType.value);
      widget.onVehicleTypeChange(selectedType.name);
      widget.onSelectedTagChange(selectedType.tag);
      model.vehicleType = selectedType.value;
    }
    if (event.physicalKey == PhysicalKeyboardKey.f2) {
      setState(() {
        selectedType =
            const VehicleType('Light Comm Veh., Mini Bus [LCV]', '110', 'LCV');
      });
      widget.onSelectedValueChange(selectedType.value);
      widget.onVehicleTypeChange(selectedType.name);
      widget.onSelectedTagChange(selectedType.tag);
      model.vehicleType = selectedType.value;
    }
    if (event.physicalKey == PhysicalKeyboardKey.f3) {
      setState(() {
        selectedType = const VehicleType('Truck or Bus [TRK]', '225', 'TRK');
      });
      widget.onSelectedValueChange(selectedType.value);
      widget.onVehicleTypeChange(selectedType.name);
      widget.onSelectedTagChange(selectedType.tag);
      model.vehicleType = selectedType.value;
    }
    if (event.physicalKey == PhysicalKeyboardKey.f4) {
      setState(() {
        selectedType = const VehicleType(
            'Three Axel Commercial vehicle [HMV]', '245', 'HMV');
      });
      widget.onSelectedValueChange(selectedType.value);
      widget.onVehicleTypeChange(selectedType.name);
      widget.onSelectedTagChange(selectedType.tag);
      model.vehicleType = selectedType.value;
    }
    if (event.physicalKey == PhysicalKeyboardKey.f5) {
      setState(() {
        selectedType =
            const VehicleType('HCM,EME,MAV (4-6 Axel) [MAV]', '355', 'MAV');
      });
      widget.onSelectedValueChange(selectedType.value);
      widget.onVehicleTypeChange(selectedType.name);
      widget.onSelectedTagChange(selectedType.tag);
      model.vehicleTag = selectedType.tag;
      model.vehicleType = selectedType.value;
    }
    if (event.physicalKey == PhysicalKeyboardKey.f6) {
      setState(() {
        selectedType = const VehicleType(
            'Oversized Vehicle (> 6 Axel) [OSV]', '430', 'OSV');
      });
      widget.onSelectedValueChange(selectedType.value);
      widget.onVehicleTypeChange(selectedType.name);
      widget.onSelectedTagChange(selectedType.tag);
      model.vehicleType = selectedType.value;
    }
  }

  void onSaved(VehicleType newValue) {
    setState(() {
      selectedType = newValue;
    });
    widget.onSelectedValueChange(newValue.value);
    widget.onVehicleTypeChange(newValue.name);
    model.vehicleType = newValue.value;
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff008382),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: RawKeyboardListener(
                  focusNode: _focusNode,
                  onKey: _handleKeyEvent,
                  child: AnimatedBuilder(
                    animation: _focusNode,
                    builder: (BuildContext context, Widget child) {
                      return Visibility(visible: false, child: Text(''));
                    },
                  ),
                ),
              ),
              Container(
                child: InputDropDownObjArr(
                    optionsArr: vehicleTypes,
                    hintText: 'Select Vehicle Type',
                    validator: (VehicleType value) {
                      if (value == null) {
                        return 'Select Vehicle Type';
                      }
                      return null;
                    },
                    selectedValue: selectedType,
                    onSaved: (VehicleType newValue) {
                      model.vehicleType = newValue.value;
                      model.vehicleTag = newValue.tag;
                      onSaved(newValue);
                    }),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: InputTextField(
                        hintText: '',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter vehicle Prefix';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          model.vehiclePrefix = value;
                          widget.onVehiclePrefixChange(value);
                        },
                      ),
                    ),
                    Flexible(
                      child: InputTextField(
                        hintText: '',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter vehicle Suffix';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          model.vehicleSuffix = value;
                          widget.onVehicleSuffixChange(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: InputDropDown(
                        optionsArr: _paymentType,
                        hintText: 'Select Payment Type',
                        validator: (String value) {
                          if (value == null) {
                            return 'Select Payment Type';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          model.paymentType = value;
                        },
                      ),
                    ),
                    Flexible(
                      child: InputTextField(
                        hintText: '',
                        onSaved: (String value) {
                          model.fieldOne = value;
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: InputDropDownTicketArr(
                  optionsArr: ticketTypes,
                  hintText: 'Select Ticket Type',
                  validator: (TicketType value) {
                    if (value.name == null) {
                      return 'Select Ticket Type';
                    }
                    return null;
                  },
                  ticketValue: ticketType,
                  onSaved: (TicketType ticketType) {
                    model.ticketType = ticketType.name;
                    model.ticketValue = ticketType.value;
                    if (ticketType.name == 'Exempted Vehicle [EXM]') {
                      setState(() {
                        isVisible = true;
                      });
                    } else {
                      setState(() {
                        isVisible = false;
                        widget.onTicketTypeChange('');
                      });
                    }
                    widget.onTicketTypeChange('${ticketType.name}');
                  },
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Container(
                  child: InputDropDown(
                    optionsArr: _vehicle,
                    hintText: 'Select Vehicle',
                    validator: (String value) {
                      if (value == null) {
                        return 'Select Vehicle';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.vehicle = value;
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: InputTextField(
                        hintText: '',
                        onSaved: (String value) {
                          model.fieldThree = value;
                        },
                      ),
                    ),
                    Flexible(
                      child: InputTextField(
                        hintText: '',
                        onSaved: (String value) {
                          model.fieldTwo = value;
                        },
                      ),
                    ),
                    Flexible(
                      child: InputTextField(
                        hintText: '',
                        onSaved: (String value) {
                          model.fieldFour = value;
                        },
                      ),
                    )
                  ],
                ),
              ),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                widget.onSetModel(model);
                                widget.onSaved();
                                setState(() {
                                  isVisible = false;
                                });
                                widget.onPrintSaveClicked(_formKey);
                              }
                            },
                            child: Text('OK'))),
                  ),
                  Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RaisedButton(
                          onPressed: () => {}, child: Text('Roll Change')),
                    ),
                  ),
                  Expanded(
                    child: new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RaisedButton(
                            onPressed: () {
                              _formKey.currentState.reset();
                            },
                            child: Text('Read Tag'))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
