import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../temputil.dart';

class Crop {
  String? costOfFarming;
  String? fertiliser;
  String? optimalTemprature;
  String? pesticides;
  String? profitMargin;
  String? yieldTime;

  Crop(
      {this.costOfFarming,
      this.fertiliser,
      this.optimalTemprature,
      this.pesticides,
      this.profitMargin,
      this.yieldTime});

  Crop.fromJson(Map<String, dynamic> json) {
    costOfFarming = json['Cost ofFarming'];
    fertiliser = json['Fertiliser'];
    optimalTemprature = json['Optimal Temprature'];
    pesticides = json['Pesticides'];
    profitMargin = json['Profit Margin'];
    yieldTime = json['Yield Time '];
  }
}

class Database extends StatefulWidget {
  const Database({Key? key}) : super(key: key);

  @override
  State<Database> createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  final TextEditingController _search = TextEditingController();
  bool found = false;
  bool beforesearch = true;

  String cropname = "";
  String? costOfFarming1;
  String? fertiliser1;
  String? optimalTemprature1;
  String? pesticides1;
  String? profitMargin1;
  String? yieldTime1;

  String onsearch(String crop) {
    if (crop == "horse gram") crop = "horse%20Gram";
    if (crop == "sweet potato") crop = "sweet%20Potato";
    if (crop == "red gram") crop = "red%20gram";
    var url2 =
        "https://test123-7b3b5-default-rtdb.asia-southeast1.firebasedatabase.app/Crops/$crop.json";
    return url2;
  }

  Future<void> checkdb() async {
    var url =
        "https://test123-7b3b5-default-rtdb.asia-southeast1.firebasedatabase.app/Crops.json";
    final response = await http.get(Uri.parse(url));
    setState(() {
      if (response.body.contains(_search.text.toLowerCase())) {
        found = true;
        cropname = _search.text;
        beforesearch = false;
      } else {
        found = false;
      }
    });
  }

  Future<Crop> searchdb() async {
    var url = onsearch(_search.text.toLowerCase());
    final response = await http.get(Uri.parse(url));
    Crop crop1 = Crop.fromJson(jsonDecode(response.body));
    
    setState(() {
      beforesearch = false;
      costOfFarming1 = crop1.costOfFarming;
      fertiliser1 = crop1.fertiliser;
      optimalTemprature1 = crop1.optimalTemprature;
      pesticides1 = crop1.pesticides;
      profitMargin1 = crop1.profitMargin;
      yieldTime1 = crop1.yieldTime;
    });
    return crop1;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xFFDBDFFD),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              getSearchBarUI(),
              // Cropcard()
              beforesearch
                  ? Container(
                      height: size.height / 10,
                      width: size.width / 1.1,
                      color: Color(0xFFDBDFFD),
                      child: Card(
                        color: Color(0xFFDBDFFD),
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Search for a crop...",
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : found
                      ? Cropcard()
                      : Container(
                          height: size.height / 10,
                          width: size.width / 1.1,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Crop not found",
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
            ],
          ),
        ));
  }

  Widget Cropcard() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(4, 4),
              blurRadius: 16,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 2.1,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1511735643442-503bb3bd348a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JvcHxlbnwwfHwwfHw%3D&w=1000&q=80',
                      // height: size.height / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Color(0xFFFFFFFF),
                    // height: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      '$cropname',
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 45,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Cost of Farming : ',
                                          style: GoogleFonts.openSans(
                                              color: yellow,
                                              letterSpacing: 0.1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 35),
                                        ),
                                        TextSpan(
                                          text: '$costOfFarming1',
                                          style: GoogleFonts.openSans(
                                            color: black,
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textScaleFactor: 0.5,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 45,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Profit Margin :  ',
                                          style: GoogleFonts.openSans(
                                              color: yellow,
                                              letterSpacing: 0.1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 35),
                                        ),
                                        TextSpan(
                                          text: '$profitMargin1',
                                          style: GoogleFonts.openSans(
                                            color: black,
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textScaleFactor: 0.5,
                                  ),
                                  // Text(
                                  //   'Profit Margin : $profitMargin1',
                                  //   style: GoogleFonts.openSans(
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   'Cost of Farming : $costOfFarming1',
                                  //   style: GoogleFonts.openSans(
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 45,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Yield Time :  ',
                                          style: GoogleFonts.openSans(
                                              color: yellow,
                                              letterSpacing: 0.1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 35),
                                        ),
                                        TextSpan(
                                          text: '$yieldTime1',
                                          style: GoogleFonts.openSans(
                                            color: black,
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textScaleFactor: 0.5,
                                  ),
                                  // Text(
                                  //   'Yield Time : $yieldTime1',
                                  //   style: GoogleFonts.openSans(
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 45,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Fertiliser :  ',
                                          style: GoogleFonts.openSans(
                                              color: yellow,
                                              letterSpacing: 0.1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 35),
                                        ),
                                        TextSpan(
                                          text: '$fertiliser1',
                                          style: GoogleFonts.openSans(
                                            color: black,
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textScaleFactor: 0.5,
                                  ),
                                  // Text(
                                  //   'Fertiliser : $fertiliser1',
                                  //   style: GoogleFonts.openSans(
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 45,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Optimal Temprature :  ',
                                          style: GoogleFonts.openSans(
                                              color: yellow,
                                              letterSpacing: 0.1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 35),
                                        ),
                                        TextSpan(
                                          text: '$optimalTemprature1',
                                          style: GoogleFonts.openSans(
                                            color: black,
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textScaleFactor: 0.5,
                                  ),
                                  // Text(
                                  //   'Optimal Temprature : $optimalTemprature1',
                                  //   style: GoogleFonts.openSans(
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 45,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Pesticides :  ',
                                          style: GoogleFonts.openSans(
                                              color: yellow,
                                              letterSpacing: 0.1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 35),
                                        ),
                                        TextSpan(
                                          text: '$pesticides1',
                                          style: GoogleFonts.openSans(
                                            color: black,
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textScaleFactor: 0.5,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Text(
                                  //   'Pesticides : $pesticides1',
                                  //   style: GoogleFonts.openSans(
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: _search,
                    onSubmitted: (value) {
                      checkdb();
                      searchdb();
                    },
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                    ),
                    cursorColor: Color(0xFF54D3C2),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Crop...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF54D3C2),
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  checkdb();
                  searchdb();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
