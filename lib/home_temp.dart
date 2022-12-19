import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

import 'NewAuth/methods.dart';
import 'temputil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

String name1 = "User";
String status = "Unavalible";
List<String> cropNames = [];

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;

  double latitude = 0.0;
  double longitude = 0.0;

  String city = "Delhi";
  bool addbool = false;

  // String name1 = "User";

  void getname() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userMap = value.data();
        name1 = userMap!['name'];
        status = userMap!['status'];
      });
      print("__________________");
      print(userMap!['name']);
      print(userMap!['status']);
      print("__________________");
    });
  }

  String statusgetter() {
    return status;
  }

  String namegetter() {
    return name1;
  }

  getAddress(lat, long) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
      print(placemark);
      Placemark place = placemark[0];
      setState(() {
        city = place.locality!;
        addbool = true;
      });
      // print(place.locality!);
    } catch (e) {
      setState(() {
        addbool = false;
      });
      print('Address was not retrieved, please fill out manually');
    }
  }

  getLocation() async {
    LocationPermission locationPermission;
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      latitude = value.latitude;
      longitude = value.longitude;
      print(latitude);
      print(longitude);
    });
  }

  Future<List<String>> Listfetch() async {
    var url =
        "https://cropdata-fa565-default-rtdb.firebaseio.com/Users/$name1/crops.json";
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    List<String> cropNames1 = [];
    extractedData.forEach((cropId, cropData) {
      cropNames1.add(cropId);
    });
    List<String> cropNames2 = await cropNames1;
    for (int i = 0; i < cropNames2.length; i++) {
      setState(() {
        cropNames[i] = cropNames2[i];
      });
      ;
    }
    return cropNames2;
  }

  @override
  void initState() {
    Listfetch();
    super.initState();
    // Listfetch().then((value) {
    //   setState(() {
    //     cropNames = value;
    //   });
    // });

    getname();
    getLocation();
    getAddress(latitude, longitude);
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#242F9B'),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 320,
            ),
            child: Container(
              color: HexColor('#DBDFFD'),
              // color: white,
              height: 800,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: Container(
                      alignment: Alignment.topRight,
                      height: 307.0,
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                                //
                                // child: Image.asset(
                                //   'assets/images/backimg.jpg',
                                //   height: 220,
                                //   width: double.maxFinite,
                                //   fit: BoxFit.cover,
                                // ),
                                child: Image.asset(
                                  'assets/images/backimg.png',
                                  height: 220.0,
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 160.0,
                                ),
                                child: Container(
                                  height: 40,
                                  width: 110,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        16.0,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10.0,
                                        spreadRadius: 5.0,
                                        offset: Offset(0.0, 10.0),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "Farmer",
                                    style: GoogleFonts.openSans(
                                      color: black,
                                      fontSize: 16,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  userMap!['name'],
                                  // 'Saransh Bibiyan',
                                  // "Nathan Drake",
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontSize: 26,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      city,
                                      // 'Sonipat',
                                      style: GoogleFonts.openSans(
                                        color: black,
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // const Spacer(),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.only(right: 8.0),
                                    //   child: Text(
                                    //     "2 Crops ",
                                    //     style: GoogleFonts.openSans(
                                    //       color: black,
                                    //       fontSize: 18,
                                    //       letterSpacing: 0 / 5,
                                    //       fontWeight: FontWeight.w500,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(
                    height: 21.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/crops');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      // height: size.height * 0.15,
                      height: 120,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: 110,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                              child: Image.asset(
                                'assets/images/crops.jpg',
                                height: 220.0,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Crops',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                // const Spacer(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Analyse Crop Data",
                                      style: GoogleFonts.openSans(
                                        color: black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: double.infinity,
                                width: 50,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  InkWell(
                    onTap: () {
                      status == 'active'
                          ? Navigator.pushNamed(context, '/openAI')
                          : Navigator.pushNamed(context, '/requestAI');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      // height: size.height * 0.15,
                      height: 120,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: 110,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                              child: Image.network(
                                'https://scontent.fixc1-4.fna.fbcdn.net/v/t39.30808-6/306009231_580108473910767_2088220748777882536_n.png?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=xg2XJTFq0NIAX_pg1HL&_nc_ht=scontent.fixc1-4.fna&oh=00_AfANSidZXeeV3PraKI2eSEyKxfoLJ9vQA1FIH64IePwHJQ&oe=63A487A8',
                                height: 220.0,
                                width: double.maxFinite,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'OpenAI',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                                // const Spacer(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Use AI to solve your problems",
                                      style: GoogleFonts.openSans(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: SizedBox(
                                height: double.infinity,
                                width: 45,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/weather');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      height: 110,
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: 110,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                              child: Image.asset(
                                'assets/images/weather.webp',
                                height: 220.0,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Weather',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "See current weather",
                                      style: GoogleFonts.openSans(
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: double.infinity,
                                width: 50,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/database');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      height: 110,
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: 110,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                              child: Image.asset(
                                'assets/images/database.jpg',
                                height: 220.0,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Crop Database',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Search info about crops",
                                      style: GoogleFonts.openSans(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                right: 10.0,
                                bottom: 10.0,
                              ),
                              child: SizedBox(
                                height: double.infinity,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/prices');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      // height: size.height * 0.15,
                      height: 120,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: 110,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                              child: Image.asset(
                                'assets/images/marketprice.jpg',
                                height: 220.0,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Market Price',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 19,
                                  ),
                                ),
                                // const Spacer(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "View various market prices",
                                      style: GoogleFonts.openSans(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    // Text(
                                    //   "16 Video",
                                    //   style: GoogleFonts.openSans(
                                    //     color: black,
                                    //     fontSize: 15,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: double.infinity,
                                width: 50,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 160,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('#646FD4'),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(64.0),
                            ),
                          ),
                          onPressed: () => logOut(context),
                          child: Text(
                            "Logout",
                            style: GoogleFonts.openSans(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ElevatedButton(
                  //     onPressed: getLocation, child: Text("Get Location")),
                ],
              ),
            ),
          ),
        ],
      )),
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
