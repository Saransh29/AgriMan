import 'package:agriman/home_temp.dart';
import 'package:firebase_database/firebase_database.dart';

import '../temputil.dart';
import '../utils/constants.dart';
import 'auth.dart';
import 'package:flutter/material.dart';
import 'package:agriman/home_page.dart';
import 'package:agriman/theme.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  // String nami = "sk";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 8,
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 34,
                        color: Color(0xff24249B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Create Account to Continue!",
                      style: TextStyle(
                        color: Color(0xff24249B),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Name", Icons.account_box, _name),
                    ),
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "email", Icons.account_box, _email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "password", Icons.lock, _password),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  customButton(size),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Already have an account? Sign In",
                        style: TextStyle(
                          color: Color(0xff646FD4),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Container(
                    // width: size.width / 2,
                    alignment: Alignment.center,
                    child: Text(
                      "",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: size.height / 45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            isLoading = true; //circular progress indicator is shown
          });

          createAccount(_name.text, _email.text, _password.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
                // nami = _name.text;
              });
              // var url1 = globalServerLink;
              // DatabaseReference databaseRef1 =
              //     FirebaseDatabase.instance.refFromURL(url1);
              // databaseRef1
              //     .child("Users")
              //     .child(nami)
              //     .child("crops")
              //     .child("onion")
              //     .set({
              //   "humidity": 38,
              //   "moisture": 41.1,
              //   "temp": 22.1,
              //   "value": false
              // });
              // databaseRef1
              //     .child("Users")
              //     .child(nami)
              //     .child("crops")
              //     .child("eggplant")
              //     .set({
              //   "humidity": 38,
              //   "moisture": 41.1,
              //   "temp": 22.1,
              //   "value": false
              // });

              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Home1()));
              print("Account Created Sucessfull");
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please enter Fields");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xFF9BA3E8),
          ),
          alignment: Alignment.center,
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        obscureText: hintText == "password" ? true : false,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Color(0xff646FD4),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff646FD4),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
