import 'dart:convert';

import 'package:agriman/models/plant_model.dart';
import 'package:agriman/templates/toggle.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class PlantData extends StatefulWidget {
  late PlantModel _model;
  PlantData(PlantModel model, {Key? key}) : super(key: key) {
    _model = model;
  }

  @override
  _PlantDataState createState() => _PlantDataState(_model);
}

class _PlantDataState extends State<PlantData> {
  late PlantModel model;
  _PlantDataState(PlantModel model) {
    this.model = model;
  }
  String temp = "0";
  String hum = "0";
  String moisture = "10";
  bool fanMotorStatus = false;
  bool waterPumpStatus = false;

  @override
  void initState() {
    super.initState();
    readDataFromFirebase();
    waterstatus();
    Timer _ = Timer.periodic(const Duration(seconds: 5), (timer) {
      readDataFromFirebase();
    });
  }

  Future<void> updateVarsFromFirebase(String url, int which) async {
    try {
      final response = await http.get(Uri.parse(url));

      setState(() {
        String respBody = response.body;
        which == 0
            ? temp = respBody
            : (which == 1 ? hum = respBody : moisture = respBody);
        if (double.parse(respBody) < 0)
          which == 0 ? temp = "0" : (which == 1 ? hum = "0" : moisture = "0");
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> readDataFromFirebase() async {
// added firebase realtime database

    var url = "https://cropdata-fa565-default-rtdb.firebaseio.com/User/";
    var tempUrl = url + "temp.json";
    var humUrl = url + "humidity.json";
    var mosUrl = url + "moisture.json";

    updateVarsFromFirebase(tempUrl, 0);
    updateVarsFromFirebase(humUrl, 1);
    updateVarsFromFirebase(mosUrl, 2);
  }

  Future<void> waterstatus() async {
    var url =
        "https://cropdata-fa565-default-rtdb.firebaseio.com/User/value.json";
    final response = await http.get(Uri.parse(url));
    setState(() {
      waterPumpStatus = response.body == "true" ? true : false;
    });
  }

  //to update the motor value in firebase realtime database
  //------------------------/
  // WORKING
  //------------------------/
  void updateMotorValue(bool val) {
    var url = globalServerLink;
    DatabaseReference databaseRef = FirebaseDatabase.instance.refFromURL(url);
    databaseRef.child("User").update({"value": val});
  }

  // Future<void> checker() async {
  //   DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  //   await databaseRef.update({
  //     "moisture": 15,
  //   });
  // }

  // Future<void> togglewater() async {
  //   var url = "https://agri-37771-default-rtdb.firebaseio.com/";
  //   var status = waterPumpStatus;

  //   final _ = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, bool>{'Motor_Value': !status}),
  //   );
  // }

// added firebase realtime database
  // Future<void> attachStatus(String device) async {
  //   var url = "https://agri-37771-default-rtdb.firebaseio.com/Motor_value.json";
  //   final response = await http.get(Uri.parse(url));
  //   print(response.body);
  //   setState(() {
  //     waterPumpStatus = response.body == "true" ? true : false;
  //   });
  // }

// device = Motor_value
  // Future<void> toggleStatus(String device) async {
  //   var url = globalServerLink;
  //   var status = waterPumpStatus;

  //   final _ = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, bool>{'Motor_Value': !status}),
  //   );
  // }

  // Future<void> helper() async {
  //   var url = "https://agri-37771-default-rtdb.firebaseio.com/Motor_value.json";
  //   final response = await http.get(Uri.parse(url));
  // }

  // Future<http.Response> datahelper() {
  //   return http.get(Uri.parse(
  //       'https://agri-37771-default-rtdb.firebaseio.com/Motor_value.json'));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
        backgroundColor: Color(0xFF9BA3EB),
      ),
      body: ListView(children: [
        Center(
          child: Column(
            children: [
              Hero(
                  tag: model,
                  child: Transform.scale(
                      scale: 0.5, child: Image.asset(model.imageStr))),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            customWidths: CustomSliderWidths(
                                trackWidth: 0.6,
                                progressBarWidth: 10,
                                shadowWidth: 10),
                            customColors: CustomSliderColors(
                                trackColor: HexColor('#ef6c00'),
                                progressBarColor: HexColor('#ffb74d'),
                                shadowColor: HexColor('#ffb74d'),
                                shadowMaxOpacity: 0.5, //);
                                shadowStep: 20),
                            infoProperties: InfoProperties(
                                bottomLabelStyle: TextStyle(
                                    color: HexColor('#6DA100'),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                bottomLabelText: 'Temp.',
                                mainLabelStyle: TextStyle(
                                    color: HexColor('#54826D'),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                modifier: (double value) {
                                  return '${double.parse(temp).toStringAsFixed(2)} ˚C';
                                }),
                            startAngle: 90,
                            angleRange: 360,
                            size: 128,
                            animationEnabled: true),
                        min: 0,
                        max: 100,
                        initialValue: double.parse(temp),
                      ),
                      // FlutterSwitch(
                      //   activeIcon: Icon(Icons.ac_unit),
                      //   inactiveIcon: Icon(Icons.wb_sunny),
                      //   width: 125.0,
                      //   height: 55.0,
                      //   valueFontSize: 25.0,
                      //   toggleSize: 45.0,
                      //   value: fanMotorStatus,
                      //   borderRadius: 30.0,
                      //   padding: 8.0,
                      //   showOnOff: true,
                      //   onToggle: (val) {
                      //     setState(() {
                      //       fanMotorStatus = val;
                      //       print(fanMotorStatus);
                      //       toggleStatus('Fan');
                      //     });
                      //   },
                      // ),
                      //adding new toggle button
                      // Toggle(
                      //   value: waterPumpStatus,
                      //   onToggle: (val) {
                      //     setState(() {
                      //       waterPumpStatus = val;
                      //       updateMotorValue(val);
                      //     });
                      //   },
                      // ),
                      FlutterSwitch(
                        activeIcon: Icon(Icons.water),
                        inactiveIcon: Icon(Icons.settings_power_rounded),
                        width: 125.0,
                        height: 55.0,
                        valueFontSize: 25.0,
                        toggleSize: 45.0,
                        value: waterPumpStatus,
                        borderRadius: 30.0,
                        padding: 8.0,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            waterPumpStatus = val;
                            updateMotorValue(val);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            customWidths: CustomSliderWidths(
                                trackWidth: 0.6,
                                progressBarWidth: 10,
                                shadowWidth: 10),
                            customColors: CustomSliderColors(
                                trackColor: HexColor('#00cc00'),
                                progressBarColor: HexColor('#00ff99'),
                                shadowColor: HexColor('#00b359'),
                                shadowMaxOpacity: 0.5, //);
                                shadowStep: 20),
                            infoProperties: InfoProperties(
                                bottomLabelStyle: TextStyle(
                                    color: HexColor('#6DA100'),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                bottomLabelText: 'Moisture',
                                mainLabelStyle: TextStyle(
                                    color: HexColor('#54826D'),
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600),
                                modifier: (double value) {
                                  return '${double.parse(moisture).toStringAsFixed(2)} %';
                                }),
                            startAngle: 90,
                            angleRange: 360,
                            size: 128,
                            animationEnabled: true),
                        min: 0,
                        max: 100,
                        initialValue: double.parse(moisture),
                      ),
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            customWidths: CustomSliderWidths(
                                trackWidth: 0.6,
                                progressBarWidth: 10,
                                shadowWidth: 10),
                            customColors: CustomSliderColors(
                                trackColor: HexColor('#0277bd'),
                                progressBarColor: HexColor('#4FC3F7'),
                                shadowColor: HexColor('#B2EBF2'),
                                shadowMaxOpacity: 0.5, //);
                                shadowStep: 20),
                            infoProperties: InfoProperties(
                                bottomLabelStyle: TextStyle(
                                    color: HexColor('#6DA100'),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                bottomLabelText: 'Humidity',
                                mainLabelStyle: TextStyle(
                                    color: HexColor('#54826D'),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                modifier: (double value) {
                                  return '${double.parse(hum).toStringAsFixed(2)} %';
                                }),
                            startAngle: 90,
                            angleRange: 360,
                            size: 128,
                            animationEnabled: true),
                        min: 0,
                        max: 100,
                        initialValue: double.parse(hum),
                      )
                    ],
                  ),
                  SizedBox(height: 28),
                  // Center(
                  //     child:
                ],
              ),
              Container()
            ],
          ),
        ),
      ]),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

List<List<String>> clr = [
  ['#0277bd', '#4FC3F7']
];

Color getColorBasedOnList(int l_idx, int c_idx) {
  return HexColor(clr[l_idx][c_idx]);
}
