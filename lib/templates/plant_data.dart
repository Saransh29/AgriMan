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
  int crops = 2;

  @override
  void initState() {
    super.initState();
    readDataFromFirebase();
    waterstatus();
    Timer _ = Timer.periodic(const Duration(seconds: 5), (timer) {
      readDataFromFirebase();
      waterstatus();
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

  void addchilddata(String name) {
    var url1 = globalServerLink;
    DatabaseReference databaseRef1 = FirebaseDatabase.instance.refFromURL(url1);
    databaseRef1
        .child("Users")
        .child(name)
        .child("crops")
        .child("onion")
        .set({"humidity": 38, "moisture": 41.1, "temp": 22.1, "value": false});
    databaseRef1
        .child("Users")
        .child(name)
        .child("crops")
        .child("eggplant")
        .set({"humidity": 38, "moisture": 41.1, "temp": 22.1, "value": false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 239, 242),
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
                        min: 0,
                        max: 100,
                        initialValue: double.parse(temp).toDouble(),
                        appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12,
                            // shadowWidth: 10,
                          ),
                          customColors: CustomSliderColors(
                            hideShadow: true,
                            trackColor: Color(0xff408ADE).withAlpha(100),
                            progressBarColors: [
                              Color(0xff408ADE),
                              Color(0xff5286CD),
                            ],
                            // shadowColor: HexColor('#646FD4'),
                            // shadowMaxOpacity: 1, //);
                            // shadowStep: 5
                          ),
                          infoProperties: InfoProperties(
                            bottomLabelStyle: TextStyle(
                                color: HexColor('#242F9B'),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            bottomLabelText: 'Temp.',
                            mainLabelStyle: TextStyle(
                                color: HexColor('#242F9B'),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            modifier: (double value) {
                              return '${double.parse(temp).toStringAsFixed(2)}˚C';
                            },
                          ),
                          startAngle: 120,
                          angleRange: 360,
                          size: 128,
                          animationEnabled: true,
                        ),
                      ),
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
                              trackWidth: 3,
                              progressBarWidth: 5,
                              // shadowWidth: 10,
                            ),
                            customColors: CustomSliderColors(
                                trackColor: HexColor('#DBDFFD'),
                                progressBarColor: HexColor('#646FD4'),
                                shadowColor: HexColor('#646FD4'),
                                shadowMaxOpacity: 1, //);
                                shadowStep: 5),
                            infoProperties: InfoProperties(
                                bottomLabelStyle: TextStyle(
                                    color: HexColor('#242F9B'),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                bottomLabelText: 'Moisture',
                                mainLabelStyle: TextStyle(
                                    color: HexColor('#242F9B'),
                                    fontSize: 20.0,
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
                              // shadowWidth: 10,
                            ),
                            customColors: CustomSliderColors(
                                trackColor: HexColor('#0277bd'),
                                progressBarColor: HexColor('#4FC3F7'),
                                shadowColor: HexColor('#B2EBF2'),
                                shadowMaxOpacity: 1, //);
                                shadowStep: 5),
                            infoProperties: InfoProperties(
                                bottomLabelStyle: TextStyle(
                                    color: HexColor('#0277bd'),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                bottomLabelText: 'Humidity',
                                mainLabelStyle: TextStyle(
                                    color: HexColor('#0277bd'),
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
                 
                ],
              ),
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
