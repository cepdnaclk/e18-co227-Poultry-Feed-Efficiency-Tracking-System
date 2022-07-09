import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/net/auth.dart';
import 'package:home_login/screens/body_weight.dart';
import 'package:home_login/screens/farm_view.dart';
import 'package:home_login/screens/fcr_screen.dart';
import 'package:home_login/screens/feed_screen.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/mortality_screen.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/settings_screen.dart';
import 'package:home_login/screens/signin_screen.dart';

class DrawerMenu extends StatelessWidget {
  final String flockID;
  const DrawerMenu(this.flockID, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthClass auth = AuthClass();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, mPrimaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.brown,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("assets/images/cccc.png"),
                  )),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              accountName: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("User Data")
                      .where("uid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Text(
                      snapshot.data?.docs[0]['userName'],
                      style: TextStyle(
                          color: mTitleTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    );
                  }),
              accountEmail: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("User Data")
                      .where("uid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Text(
                      snapshot.data?.docs[0]['email'],
                      style: TextStyle(
                        color: mTitleTextColor,
                        fontSize: 15,
                      ),
                    );
                  }),
            ),
            MenuList(
                title: "FCR",
                iconName: Icons.egg,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FCRScreen()));
                }),
            MenuList(
                title: "feedintake".tr,
                iconName: Icons.food_bank,
                press: () {
                  Navigator.pushNamed(context, GridDashboard.routeFeed,
                      arguments: ScreenArguments(flockID));
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedScreen()));*/
                }),
            MenuList(
                title: "farmreg".tr,
                iconName: Icons.app_registration,
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FarmView()));
                }),
            MenuList(
                title: "mortality".tr,
                iconName: Icons.dangerous,
                press: () {
                  Navigator.pushNamed(context, GridDashboard.routeMortal,
                      arguments: ScreenArguments(flockID));
                }),
            MenuList(
                title: "body_weight".tr,
                iconName: Icons.line_weight,
                press: () {
                  Navigator.pushNamed(context, GridDashboard.routeWeight,
                      arguments: ScreenArguments(flockID));
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BodyWeight()));*/
                }),
            MenuList(
                title: "view".tr,
                iconName: Icons.view_module,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                }),
            MenuList(
                title: "language".tr,
                iconName: Icons.language,
                press: () {
                  builddialog(context);
                }),
            MenuList(
              title: "logout".tr,
              iconName: Icons.logout,
              press: () async {
                await auth.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignInScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  final String title;
  final IconData iconName;
  final Function press;

  const MenuList(
      {required this.title, required this.iconName, required this.press});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        press();
      },
      leading: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 141, 81, 60),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          iconName,
          color: Colors.white54,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: mSecondTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
