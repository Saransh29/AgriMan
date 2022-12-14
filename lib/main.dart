import 'package:agriman/NewAuth/auth.dart';
import 'package:agriman/home_temp.dart';
import 'package:agriman/prices/sonipat.dart';
import 'package:agriman/theme.dart';
import 'package:agriman/weather/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:agriman/home_temp.dart';
import 'package:agriman/templates/crops.dart';
import 'package:agriman/templates/crop_database.dart';
import 'package:agriman/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'openAI/fetch.dart';
import 'openAI/request.dart';
import 'prices/azadpur.dart';
import 'prices/najafgarh.dart';
import 'prices/panipat.dart';
import 'prices/prices.dart';
import 'prices/rohtak.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routes: {
        '/': (context) => welcome(),
        '/home': (context) => Home1(),
        '/weather': (context) => HomeScreen(),
        '/prices': (context) => prices(),
        '/crops': (context) => CropList(),
        '/login': (context) => Authenticate(),
        '/register': (context) => CreateAccount(),
        '/database': (context) => Database(),
        '/azadpur': (context) => Azadpur(),
        '/sonipat': (context) => Sonipat(),
        '/rohtak': (context) => Rohtak(),
        '/najafgarh': (context) => Najafgarh(),
        '/panipat': (context) => Panipat(),
        '/openAI': (context) => openaifetch(),
        '/requestAI': (context) => requestAI(),
      },
    );
  }
}
