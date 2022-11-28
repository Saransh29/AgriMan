import 'package:agriman/NewAuth/auth.dart';
import 'package:flutter/material.dart';
import 'package:agriman/home_page.dart';
import 'package:agriman/templates/weather_info.dart';
import 'package:agriman/templates/crops.dart';
import 'package:agriman/templates/user_info_page.dart';

import 'package:agriman/auth/personal.dart';
import 'package:agriman/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

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
      //home: Authenticate(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Authenticate(),
        '/home': (context) => Home(),
        '/weather': (context) => weather(),
        '/crops': (context) => CropList(),
        '/login': (context) => Authenticate(),
        '/register': (context) => CreateAccount(),
        '/profile': (context) => Userprofile(),
        '/user_info': (context) => UserInfo()
      },
    );
  }
}
