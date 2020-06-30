import 'dart:convert';
import 'package:desktop_app/storage.dart';
import 'package:flutter/material.dart';
import './input_form.dart';
import 'dart:io';
import 'package:desktop_app/model.dart';
import 'dart:async' show Future;
import 'package:intl/intl.dart';
import 'dart:async';

class DashboardItem extends StatefulWidget {
  final Storage storage;

  DashboardItem({Key key, @required this.storage}) : super(key: key);

  @override
  _DashboardItemState createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  List devices = [];
  bool connected = false;
  bool _isVisible = false;
  String selectedValue = '';
  String selectedLabel = '';
  String vehicleType = '';
  String ticketType = '';
  String vehicleTag = '';
  String vehiclePrefix = '';
  String vehicleSuffix = '';
  var formKey = GlobalKey<FormState>();
  String filePath;
  String state;
  List<List<dynamic>> data = [];
  Model model = new Model();
  String boothNo = '';
  String laneNo = '';
  final List<Map<String, String>> listOfColumns = [];

  void show() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  Future<File> writeData() async {
    return widget.storage.writeData(listOfColumns);
  }

  Future<String> readData() async {
    return widget.storage.readData();
  }

  String dateTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    print(formatted);
    return formatted;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = (MediaQuery.of(context).size.height) / 3.5;

    var dateMonth = new DateFormat('dd-MMM-yyyy').format(new DateTime.now());
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xff008382),
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("NATIONAL HIGHWAY AUTHORITY OF INDIA",
                style: TextStyle(color: Color(0xffA17510), fontSize: 24)),
            Row(
              children: <Widget>[
                FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/settings.json'),
                  builder: (context, snapshot) {
                    var showData = json.decode(snapshot.data.toString());
                    var rest = showData['info'] as List;
                    boothNo = showData['booth_no'];
                    laneNo = showData['lane_no'];
                    return Text(
                        '${rest[0]['name']} ${rest[0]['value']}   ${rest[1]['name']} ${rest[1]['value']}   |   Collection for $dateMonth   ${rest[2]['name']} ${rest[2]['value']}',
                        style: TextStyle(color: Colors.white, fontSize: 12));
                  },
                ),
              ],
            )
          ],
        ),
        // title: Text("NATIONAL HIGHWAY AUTHORITY OF INDIA",
        //     style: TextStyle(color: Color(0xffA17510), fontSize: 24)),
        leading: Container(
          child: Image(
            image: AssetImage('barLogo.png'),
          ),
        ),
        backgroundColor: Color(0xff00BCD1),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              //ROW 1
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: deviceHeight,
                    margin: EdgeInsets.all(5.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Visibility(
                      visible: _isVisible,
                      child: ListView(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  left: 20, top: 30, right: 20, bottom: 0),
                              child: Text(
                                ticketType,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffD20000)),
                              )),
                          Text(
                            vehicleType,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffD20000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, top: 10, right: 20, bottom: 0),
                            child: Text(
                              selectedValue + '/-',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                color: Color(0xffD20000),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            vehiclePrefix + '*' + vehicleSuffix,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              color: Color(0xffD20000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: new Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: RaisedButton(
                                        onPressed: () {
                                          formKey.currentState.reset();
                                          setState(() {
                                            listOfColumns.add({
                                              "transNo": (new DateTime.now()
                                                      .millisecondsSinceEpoch)
                                                  .toString(),
                                              "lane": '2',
                                              "vehicleNo":
                                                  '${model.vehiclePrefix}*${model.vehicleSuffix}',
                                              "transType":
                                                  '${model.ticketValue}',
                                              "amount": '${model.vehicleType}',
                                              "vehicleType": vehicleTag
                                            });
                                            _isVisible = false;
                                          });
                                          writeData();
                                          // print functionality
                                        },
                                        child: Text('Print/Save'))),
                              ),
                              Expanded(
                                child: new Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: RaisedButton(
                                      onPressed: () {
                                        formKey.currentState.reset();
                                        setState(() {
                                          _isVisible = false;
                                        });
                                      },
                                      child: Text('Cancel')),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: deviceHeight,
                    margin: EdgeInsets.all(5.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image(
                      image: AssetImage('barrier.jpg'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: deviceHeight,
                    margin: EdgeInsets.all(5.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: ListView(children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(5.0),
                          child: Text('Clear Vehicle List',
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          color: Colors.grey,
                          child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text('Trans Type',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              DataColumn(
                                  label: Text('Lane',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              DataColumn(
                                  label: Text('Vehicle Number',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              DataColumn(
                                  label: Text('TransType',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              DataColumn(
                                  label: Text('Amount',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              DataColumn(
                                  label: Text('Vehicle Type',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                            ],
                            rows:
                                listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                                    .map(
                                      ((element) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(//SET width
                                                  Text(element["transNo"],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ))), //Extracting from Map element the value
                                              DataCell(Text(element["lane"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ))),
                                              DataCell(
                                                  Text(element["vehicleNo"],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ))),
                                              DataCell(Text(
                                                  element["transType"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ))), //Extracting from Map element the value
                                              DataCell(Text(element["amount"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ))),
                                              DataCell(
                                                  Text(element["vehicleType"],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ))),
                                            ],
                                          )),
                                    )
                                    .toList(),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            Row(
              //ROW 2
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: deviceHeight + 50,
                    margin: EdgeInsets.all(5.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: TestForm(
                        onPrintSaveClicked: (var value) => {
                              setState(() {
                                formKey = value;
                              })
                            },
                        onSetModel: (Model data) {
                          setState(() {
                            model = data;
                          });
                        },
                        onSelectedValueChange: (String value) => {
                              setState(() {
                                selectedValue = value;
                              })
                            },
                        onSelectedTagChange: (String value) => {
                              setState(() {
                                vehicleTag = value;
                              })
                            },
                        onTicketTypeChange: (String value) => {
                              setState(() {
                                ticketType = value;
                              })
                            },
                        onVehicleTypeChange: (String value) => {
                              setState(() {
                                vehicleType = value;
                              })
                            },
                        onVehiclePrefixChange: (String value) => {
                              setState(() {
                                vehiclePrefix = value;
                              })
                            },
                        onVehicleSuffixChange: (String value) => {
                              setState(() {
                                vehicleSuffix = value;
                              })
                            },
                        onSaved: () => {
                              setState(() {
                                _isVisible = !_isVisible;
                              })
                            }),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      height: deviceHeight + 50,
                      margin: EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Visibility(
                              visible: _isVisible,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  selectedValue + '/-',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Color(0xffD20000),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: new Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'WIM Weight',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: new Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      '0',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: new Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Max Weight Allowed',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: new Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      '0',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ])),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: deviceHeight + 50,
                    margin: EdgeInsets.all(5.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Last Weight',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              '',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                //ROW 2
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: deviceHeight - 20,
                      margin: EdgeInsets.all(5.0),
                      child: FutureBuilder(
                          future: DefaultAssetBundle.of(context)
                              .loadString('assets/settings.json'),
                          builder: (context, snapshot) {
                            var showData =
                                json.decode(snapshot.data.toString());
                            var rest = showData['first_col'] as List;

                            return ListView.builder(
                                itemExtent: 20,
                                itemCount: rest.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Wrap(
                                      spacing: 20, // space between two icons
                                      children: <Widget>[
                                        Text(rest[index]['name'],
                                            style: TextStyle(
                                                color: Color(0xff39069E),
                                                fontWeight: FontWeight.bold)),
                                        Text(rest[index]['value'],
                                            style: TextStyle(
                                                color: Colors.white)), // icon-2
                                      ],
                                    ),
                                  );
                                });
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: deviceHeight - 20,
                      margin: EdgeInsets.all(5.0),
                      child: FutureBuilder(
                          future: DefaultAssetBundle.of(context)
                              .loadString('assets/settings.json'),
                          builder: (context, snapshot) {
                            var showData =
                                json.decode(snapshot.data.toString());
                            var rest = showData['second_col'] as List;
                            return ListView.builder(
                                itemExtent: 20,
                                itemCount: rest.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Wrap(
                                      spacing: 20, // space between two icons
                                      children: <Widget>[
                                        Text(rest[index]['name'],
                                            style: TextStyle(
                                                color: Color(0xff39069E),
                                                fontWeight: FontWeight.bold)),
                                        Text(rest[index]['value'],
                                            style: TextStyle(
                                                color: Colors.white)), // icon-2
                                      ],
                                    ),
                                  );
                                });
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: deviceHeight - 20,
                      margin: EdgeInsets.all(5.0),
                      child: FutureBuilder(
                        future: DefaultAssetBundle.of(context)
                            .loadString('assets/settings.json'),
                        builder: (context, snapshot) {
                          var showData = json.decode(snapshot.data.toString());
                          var rest = showData['third_col'] as List;
                          return ListView.builder(
                            itemExtent: 20,
                            itemCount: rest.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Wrap(
                                  spacing: 20, // space between two icons
                                  children: <Widget>[
                                    Text(rest[index]['name'],
                                        style: TextStyle(
                                            color: Color(0xff39069E),
                                            fontWeight: FontWeight.bold)),
                                    Text(rest[index]['value'],
                                        style: TextStyle(
                                            color: Colors.white)), // icon-2
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
