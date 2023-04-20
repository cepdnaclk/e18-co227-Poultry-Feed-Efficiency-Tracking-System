import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:home_login/localeString.dart';
import 'package:home_login/screens/Analysis/analytics_selection.dart';
import 'package:home_login/screens/EggMonScreens/egg_select.dart';
import 'package:home_login/screens/EggMonScreens/update_egg.dart';
import 'package:home_login/screens/RegScreens/ViewScreens/farm_view.dart';
import 'package:home_login/screens/fcr_screen.dart';
import 'package:home_login/screens/FeedIntakeScreens/feed_selection.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/mortality_screen.dart';
import 'package:home_login/screens/Analysis/compare_ideal.dart';
import 'package:home_login/screens/BodyWeightScreen/select_bodyweight.dart';
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

            GridDashboard.routeFCR: (context) => const FCRScreen(),
            GridDashboard.routeFeed: (context) => const FeedScreen(),
            '/farm': (context) => FarmView(),
            GridDashboard.routeMortal: (context) => const MortalityScreen(),
            GridDashboard.routeWeight: (context) => const BodyWeight(),
            GridDashboard.routeView: (context) => AnalyticsSelection(),
            //'/view': (context) => const ViewScreen(),
            '/eggs': (context) => const EggSelectScreen(),
          },
          // ignore: prefer_const_constructors
          home: SplashScreen(),
        );
      },
    );
  }
}
