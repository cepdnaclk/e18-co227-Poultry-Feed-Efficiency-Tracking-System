import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/signin_screen.dart';
import '../net/auth.dart';
import 'drawerMenu.dart';
import 'griddashboard.dart';
import 'package:home_login/constants.dart';

class HomeScreen extends StatefulWidget {
  final String farmNavi,
      branchNavi,
      shedNavi,
      flockNavi,
      farmName,
      branchName,
      shedName,
      flockName;

  //const HomeScreen({Key? key}) : super(key: key);

  HomeScreen({
    Key? key,
    required this.farmNavi,
    required this.branchNavi,
    required this.shedNavi,
    required this.flockNavi,
    required this.farmName,
    required this.branchName,
    required this.shedName,
    required this.flockName,
  }) : super(key: key);

  // FirebaseAuth.instance;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //var branchName, farmName, shedName, flockName;
  AuthClass auth = AuthClass();
  double translateX = 0.0;
  double translateY = 0.0;
  double scale = 1;
  bool toggle = false;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //backgroundColor: const Color(0xff392850),
      //backgroundColor: Colors.white,
      children: [
        DrawerMenu(widget.flockNavi),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          transform: Matrix4.translationValues(translateX, translateY, 0)
            ..scale(scale),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ClipRRect(
              borderRadius: (toggle)
                  ? BorderRadius.circular(20)
                  : BorderRadius.circular(0),
              child: Scaffold(
                appBar: AppBar(
                    backgroundColor: mPrimaryColor,
                    elevation: 0.0,
                    leading: IconButton(
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_arrow,
                        progress: _animationController,
                      ),
                      onPressed: () {
                        toggle = !toggle;
                        if (toggle) {
                          translateX = 200.0;
                          translateY = 80.0;
                          scale = 0.8;
                          _animationController.forward();
                        } else {
                          translateX = 0.0;
                          translateY = 0.0;
                          scale = 1;
                          _animationController.reverse();
                        }
                        setState(() {});
                      },
                      //icon: Icon(Icons.menu),
                    ),
                    title: Text('Home'),
                    // backgroundColor: mPrimaryColor,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.language),
                        onPressed: () {
                          builddialog(context);
                        },
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
                    ]),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("User Data")
                                            .where("uid",
                                                isEqualTo: FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return Text(
                                            snapshot.data?.docs[0]['userName'],
                                            style: TextStyle(
                                                color: mTitleTextColor,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 60,
                                          child: Text(
                                            "Farm",
                                            style: TextStyle(
                                              color: mTitleTextColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " : " + widget.farmName,
                                          style: TextStyle(
                                            color: mTitleTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          child: Text(
                                            "Branch",
                                            style: TextStyle(
                                              color: mTitleTextColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " : " + widget.branchName,
                                          style: TextStyle(
                                            color: mTitleTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          child: Text(
                                            "Shed",
                                            style: TextStyle(
                                              color: mTitleTextColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " : " + widget.shedName,
                                          style: TextStyle(
                                            color: mTitleTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          child: Text(
                                            "Flock",
                                            style: TextStyle(
                                              color: mTitleTextColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " : " + widget.flockName,
                                          style: TextStyle(
                                            color: mTitleTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
                            height: 5,
                          ),
                          GridDashboard(widget.flockNavi)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
