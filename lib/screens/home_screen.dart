import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_login/constants.dart';
import 'griddashboard.dart';
import 'package:home_login/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xff392850),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              color: mPrimaryColor,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Shamil khan",
                            style: TextStyle(
                              color: mTitleTextColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                color: mTitleTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      /*
                    IconButton(

                      icon: Image.asset("assets/notification.png",width: 24,),
                      alignment: Alignment.topCenter,
                      onPressed: (){},
                    ),
                    */
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const GridDashboard()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
