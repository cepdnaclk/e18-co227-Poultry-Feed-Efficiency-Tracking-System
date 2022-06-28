import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:home_login/localeString.dart';

import 'package:flutter/services.dart';

import 'package:home_login/screens/RegScreens/farmReg_screen.dart';
import 'package:home_login/screens/farm_view.dart';
import 'package:home_login/screens/fcr_screen.dart';
import 'package:home_login/screens/feed_screen.dart';
import 'package:home_login/screens/mortality_screen.dart';
import 'package:home_login/screens/settings_screen.dart';
import 'package:home_login/screens/signin_screen.dart';
import 'package:home_login/screens/todo_screen.dart';
import 'package:home_login/screens/welcome_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          translations: LocalString(),
          locale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.

            '/FCR': (context) => const FCRScreen(),
            '/feed': (context) => const FeedScreen(),
            '/farm': (context) => FarmView(),
            '/mortal': (context) => const MortalityScreen(),
            '/weight': (context) => const ToDoScreen(),
            '/view': (context) => const SettingsScreen(),
          },
          // ignore: prefer_const_constructors
          home: SignInScreen(),
        );
      },
    );
  }
}
