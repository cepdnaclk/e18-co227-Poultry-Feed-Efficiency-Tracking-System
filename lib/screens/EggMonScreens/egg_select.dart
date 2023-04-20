import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/screens/EggMonScreens/add_egg.dart';
import 'package:home_login/screens/EggMonScreens/delete_egg.dart';
import 'package:home_login/screens/EggMonScreens/update_egg.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../drawerMenu.dart';


class EggSelectScreen extends StatefulWidget {
  const EggSelectScreen({Key? key}) : super(key: key);

  @override
  State<EggSelectScreen> createState() => _EggSelectScreenState();
}

class _EggSelectScreenState extends State<EggSelectScreen> with TickerProviderStateMixin {
  List weightDataCobb500 = [];
  String startDate = '';
  String strainType = '';

  DateTime date =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);

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
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;
    return Stack(
      children: [
        DrawerMenu(args.flockID),
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
                  title: Text("Egg Monitor Selection",
                    style: TextStyle(fontSize: 22),
                  ),
                  backgroundColor: mPrimaryColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Farmers')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('flock')
                              .where(FieldPath.documentId,
                              isEqualTo: args.flockID)
                              .snapshots(), // your stream url,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else {
                              //print(snapshot.toString());
                              startDate = snapshot.data?.docs[0]['startdays'];
                              strainType = snapshot.data?.docs[0]['strain'];

                            }

                            return Container(
                              height: 0,
                            ); // Your grid code.
                          }),
                     SizedBox(
                       height: 50,
                     ),
                      Center(
                        child: Image.asset(
                          "assets/images/eggFarmerlight.png",
                          fit: BoxFit.fitWidth,
                          width: context.width * 0.5,
                          // height: 420,
                          //color: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateEggScreen(
                                    id_flock: args.flockID,
                                    startDateNavi: startDate,
                                    strainNavi: strainType,

                                  )
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: mPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text("update".tr),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            print(args.flockID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEggScreen(
                                    id_flock: args.flockID,
                                    startDateNavi: startDate,
                                    strainNavi: strainType,
                                  )
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: mBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide(color: mPrimaryColor),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(
                            "add".tr,
                            style: TextStyle(
                              color: mPrimaryColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DeleteEggScreen(
                                      id_flock: args.flockID,
                                      startDateNavi: startDate,
                                      strainNavi: strainType,
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50), backgroundColor: mPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text("Delete".tr),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

