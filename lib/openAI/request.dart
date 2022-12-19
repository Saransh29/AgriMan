import 'package:agriman/temputil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agriman/home_temp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class requestAI extends StatefulWidget {
  const requestAI({Key? key}) : super(key: key);

  @override
  State<requestAI> createState() => _requestAIState();
}

class _requestAIState extends State<requestAI> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;

  void nodeAdder() {
    var url1 = globalServerLink;
    DatabaseReference databaseRef1 = FirebaseDatabase.instance.refFromURL(url1);
    databaseRef1.child("Requests").child(name1).set({"access": false});
  }

  Future<void> getstatus() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userMap = value.data();
        status = userMap!['status'];
      });
      print("__________________");
      print(userMap!['status']);
      print("__________________");
    });
  }

  void initState() {
    getstatus();
    super.initState();
  }

  void dispose() {
    // userMap = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(32.0),
          ),
          onTap: () {
            print("Request AI Access");
            kIsWeb ? null : nodeAdder();
            getstatus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF54D3C2),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Request AI Access",
                    style: GoogleFonts.openSans(
                        color: Color(0xFFFFFFFF),
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text("Powered by OpenAI"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
