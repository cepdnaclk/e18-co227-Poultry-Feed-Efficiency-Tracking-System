import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_login/screens/farmReg_screen.dart';
import 'package:home_login/screens/fcr_screen.dart';
import 'package:home_login/screens/feed_screen.dart';
import 'package:home_login/screens/mortality_screen.dart';
import 'package:home_login/screens/settings_screen.dart';
import 'package:home_login/screens/todo_screen.dart';
import 'package:home_login/screens/welcome_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.

        '/FCR': (context) => const FCRScreen(),
        '/feed': (context) => const FeedScreen(),
        '/farm': (context) => const FarmRegScreen(),
        '/mortal': (context) => const MortalityScreen(),
        '/todo': (context) => const ToDoScreen(),
        '/set': (context) => const SettingsScreen(),
      },

      home: const Welcome(),
    );
  }
}
