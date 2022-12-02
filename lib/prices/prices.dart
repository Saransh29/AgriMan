import 'dart:convert';

import 'package:agriman/home_temp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import '../models/weather_info.dart';
import '../templates/weather_model.dart';
import '../utils/constants.dart';
import '../NewAuth/methods.dart';
import '../temputil.dart';

class prices extends StatefulWidget {
  const prices({Key? key}) : super(key: key);

  @override
  _pricesState createState() => _pricesState();
}

class _pricesState extends State<prices> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#DBDFFD'),
      // appBar: AppBar(
      //   backgroundColor: scaffoldbg,
      //   title: Text('Main Menu'),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //         icon: Icon(Icons.logout), onPressed: () => logOut(context)),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: IconButton(
      //         icon: Icon(Icons.settings),
      //         onPressed: () {},
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(
                    height: 21.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/azadpur');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      // height: size.height * 0.15,
                      height: 100,
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
                                'https://images.unsplash.com/photo-1511735643442-503bb3bd348a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JvcHxlbnwwfHwwfHw%3D&w=1000&q=80',
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
                                  'Azadpur',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
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
                    height: 16.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/sonipat');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      // height: size.height * 0.15,
                      height: 100,
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
                                'https://images.unsplash.com/photo-1511735643442-503bb3bd348a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JvcHxlbnwwfHwwfHw%3D&w=1000&q=80',
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
                                  'Sonipat ',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
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
                    height: 16.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/najafgarh');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      // height: size.height * 0.15,
                      height: 100,
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
                                'https://images.unsplash.com/photo-1511735643442-503bb3bd348a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JvcHxlbnwwfHwwfHw%3D&w=1000&q=80',
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
                                  'Najafgarh ',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
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
                    height: 16.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/panipat');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      // height: size.height * 0.15,
                      height: 100,
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
                                'https://images.unsplash.com/photo-1511735643442-503bb3bd348a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JvcHxlbnwwfHwwfHw%3D&w=1000&q=80',
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
                                  'Panipat ',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
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
                    height: 16.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/rohtak');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      // height: size.height * 0.15,
                      height: 100,
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
                                'https://images.unsplash.com/photo-1511735643442-503bb3bd348a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JvcHxlbnwwfHwwfHw%3D&w=1000&q=80',
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
                                  'Rohtak ',
                                  style: GoogleFonts.openSans(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
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
                    height: 16.0,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //       height: 60,
                  //       width: 160,
                  //       child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: HexColor('#646FD4'),
                  //           shape: ContinuousRectangleBorder(
                  //             borderRadius: BorderRadius.circular(64.0),
                  //           ),
                  //         ),
                  //         onPressed: () => Home1(),
                  //         child: Text(
                  //           "Back",
                  //           style: GoogleFonts.openSans(
                  //             color: white,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
