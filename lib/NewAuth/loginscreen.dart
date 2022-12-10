import 'package:agriman/home_temp.dart';
import 'package:agriman/temputil.dart';
import 'package:agriman/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth.dart';
import 'package:flutter/material.dart';
import 'package:agriman/home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // HexColor("#646FD4")
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
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: double.maxFinite,
                        child: Image.network(
                          'https://i.imgur.com/0V6h1U4.png',
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          top: 170.0,
                        ),
                        child: Container(
                          height: 90,
                          width: 140,
                          alignment: Alignment.center,
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.openSans(
                              color: Color.fromARGB(255, 60, 60, 162),
                              fontSize: 38,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height / 14,
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
                    height: size.height / 10,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CreateAccount())),
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Color(0xff646FD4),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Sucessfull");
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Home1()));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
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
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget field(
  Size size,
  String hintText,
  IconData icon,
  TextEditingController cont,
) {

  return Container(
    height: size.height / 14,
    width: size.width / 1.1,
    child: TextField(
      controller: cont,
      obscureText: hintText == "password" ? true : false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xff646FD4)),
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xff646FD4)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    ),
  );
}

}
