import 'package:agriman/NewAuth/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 110,
          ),
          kIsWeb
              ? Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/welcome.png',
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/welcome.png',
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome!',
                  style: GoogleFonts.openSans(
                    color: HexColor('#9BA3E8'),
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Authenticate()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 25,
                ),
                Container(
                  // color: HexColor('#DBDFFD'),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor('#DBDFFD'),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 39,
                      ),
                      children: [
                        TextSpan(
                          text: '  Get Started ',
                          style: GoogleFonts.openSans(
                            color: HexColor('#9BA3E8'),
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_forward,
                            color: HexColor('#9BA3E8'),
                            size: 52,
                          ),
                        ),
                      ],
                    ),
                    textScaleFactor: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
