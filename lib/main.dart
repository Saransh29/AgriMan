import 'package:agriman/NewAuth/auth.dart';
import 'package:agriman/home_temp.dart';
import 'package:agriman/theme.dart';
import 'package:flutter/material.dart';
import 'package:agriman/home_temp.dart';
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
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routes: {
        '/': (context) => welcome(),
        '/home': (context) => Home1(),
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
