import 'package:agriman/NewAuth/auth.dart';
import 'package:agriman/models/plant_model.dart';
import 'package:agriman/templates/plant_data.dart';
import 'package:agriman/temputil.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:agriman/home_temp.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

class CropList extends StatefulWidget {
  const CropList({Key? key}) : super(key: key);

  @override
  _CropListState createState() => _CropListState();
}

class _CropListState extends State<CropList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var str;
  final cropname = TextEditingController();
  List<String> cropNames = ['Onion', 'EggPlant'];
  List<PlantModel> crops = [];

  //access a variable from another file

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    for (String s in cropNames) {
      cropAdder(s, true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void cropAdder(String s, bool imageGiven) {
    String r = s + DateTime.now().toString();
    var bytes = utf8.encode(r);
    Digest md5res = md5.convert(bytes);
    crops.add(new PlantModel(md5res.toString(), s, imageGiven));
  }

  Widget PlantCell(
    BuildContext context,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PlantData(crops[index])));
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          // height: size.height * 0.15,
          height: 110,
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
                    crops[index].imageStr,
                    height: 220.0,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  // child: Image.network(
                  //   'https://images.unsplash.com/photo-1511735643442-503bb3bd348a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JvcHxlbnwwfHwwfHw%3D&w=1000&q=80',
                  //   height: 220.0,
                  //   width: double.maxFinite,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crops[index].name,
                      style: GoogleFonts.openSans(
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
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
    );
  }

  late PlantModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBDFFD),
      appBar: AppBar(
        title: Text(
          'Crops',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF9BA3EB),
      ),
      body: Center(
        child: Stack(
          children: [
            ListView.builder(
                itemCount: crops.length,
                itemBuilder: (context, index) => PlantCell(context, index))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: cropname,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Crop Name '),
                    ),
                    TextButton(
                      onPressed: () {
                        if (cropname.text.isEmpty) {
                          Navigator.pop(context);
                        } else {
                          str = cropname.text;
                          setState(() {
                            cropAdder(str, false);
                          });
                          // var url1 = "https://cropdata-fa565-default-rtdb.firebaseio.com/";  
                          // DatabaseReference databaseRef1 =
                          //     FirebaseDatabase.instance.refFromURL(url1);
                          // databaseRef1
                          //     .child("Users")
                          //     .child(name1)
                          //     .child("crops")
                          //     .child(str)
                          //     .set({
                          //   "humidity": 38,
                          //   "moisture": 41.1,
                          //   "temp": 22.1,
                          //   "value": false
                          // });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('$str Added'),
                            duration: Duration(seconds: 1),
                          ));
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Submit'),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF9BA3EB),
      ),
    );
  }
}

class CropCard extends StatelessWidget {
  final PlantModel data;
  CropCard({required this.data});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[600],
      elevation: 3.0,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 3.0),
          child: TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/crop_data',
                    arguments: {'data': data});
              },
              icon: Icon(
                Icons.fastfood,
                color: Colors.orange,
              ),
              label: Text(
                data.name,
                style: TextStyle(color: Colors.white),
              ))),
    );
  }
}
