import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/signin_screen.dart';
import '../net/auth.dart';
import 'griddashboard.dart';
import 'package:home_login/constants.dart';

class HomeScreen extends StatefulWidget {
  final String farmNavi, branchNavi, shedNavi;

  //const HomeScreen({Key? key}) : super(key: key);

  const HomeScreen({
    Key? key,
    required this.farmNavi,
    required this.branchNavi,
    required this.shedNavi,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthClass auth = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xff392850),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            decoration: BoxDecoration(
              color: mPrimaryColor,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
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
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                color: mTitleTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Farm : " + widget.farmNavi,
                            style: TextStyle(
                              color: mTitleTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Branch : " + widget.branchNavi,
                            style: TextStyle(
                              color: mTitleTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Shed : " + widget.shedNavi,
                            style: TextStyle(
                              color: mTitleTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            await auth.logout();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => SignInScreen()),
                                (route) => false);
                          },
                          icon: Icon(Icons.logout))
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
                  height: 5,
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
