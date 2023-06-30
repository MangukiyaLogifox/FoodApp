import 'package:flutter/material.dart';
import 'package:food_app/Core/app_color.dart';
import 'package:food_app/Screen/introductione_Screen.dart';
import 'package:food_app/Screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screen/menu_screen.dart';

bool? _seen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _seen = (prefs.getBool('seen') ?? false);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
            theme: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColor.darkIndigo,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: _seen == true ? const LoginScren() : IntroductioneScreen());
        // MenuScreen());
      },
    );
  }
}
