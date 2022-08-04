import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/autoFCR.dart';
import 'package:home_login/screens/selectBodyWeight.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/manualFCR.dart';
import 'package:sizer/sizer.dart';
import 'package:home_login/screens/strain.dart' as strainList;

import 'drawerMenu.dart';

class FCRScreen extends StatefulWidget {
  const FCRScreen({Key? key}) : super(key: key);

  @override
  State<FCRScreen> createState() => _FCRScreenState();
}

class _FCRScreenState extends State<FCRScreen> with TickerProviderStateMixin {
  String startDate = '';
  String strainType = '';
  List<strainList.PoultryData> weightDataStrain = [];
  List<strainList.PoultryData> feedtDataStrain = [];

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final TextEditingController _datecontroller = TextEditingController();
  double translateX = 0.0;
  double translateY = 0.0;
  double scale = 1;
  bool toggle = false;
  late AnimationController _animationController;
  int mortal = 0, s_count = 0;
  String totalChick = '';
  int days = 0;
  num idealWeightperchick = 0;
  num idealFeedperchick = 0;
  // num feedbag = 0, bagWeight = 0;
  // num avgWeight = 0;

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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Stack(
      children: [
        //Feed intake
        // StreamBuilder(
        //     stream: FirebaseFirestore.instance
        //         .collection("Farmers")
        //         .doc(FirebaseAuth.instance.currentUser!.uid)
        //         .collection('flock')
        //         .doc(args.flockID)
        //         .collection('FeedIntake')
        //         .where(FieldPath.documentId,
        //             isEqualTo: date.toString().substring(0, 10))
        //         .snapshots(), // your stream url,
        //     builder:
        //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //       if (!snapshot.hasData) {
        //         return CircularProgressIndicator();
        //       } else if (snapshot.data!.docs.isEmpty ||
        //           snapshot.data!.docs.isEmpty) {
        //         return CircularProgressIndicator();
        //         //return "Please update the Feed Page";
        //       } else {
        //         //print(snapshot.toString());
        //         feedbag = snapshot.data?.docs[0]['Number_of_bags'];
        //         bagWeight = snapshot.data?.docs[0]['Weight_of_a_bag'];
        //         print(date.toString().substring(0, 10) + feedbag.toString());
        //         print(date.toString().substring(0, 10) + bagWeight.toString());
        //       }

        //       return Container(); // Your grid code.
        //     }),
        // //Body Weight
        // StreamBuilder(
        //     stream: FirebaseFirestore.instance
        //         .collection("Farmers")
        //         .doc(FirebaseAuth.instance.currentUser!.uid)
        //         .collection('flock')
        //         .doc(args.flockID)
        //         .collection('BodyWeight')
        //         .where(FieldPath.documentId,
        //             isEqualTo: date.toString().substring(0, 10))
        //         .snapshots(), // your stream url,
        //     builder:
        //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //       if (!snapshot.hasData) {
        //         return CircularProgressIndicator();
        //       } else if (snapshot.data!.docs.isEmpty ||
        //           snapshot.data!.docs.isEmpty) {
        //         return CircularProgressIndicator();
        //         //return "Please update the Feed Page";
        //       } else {
        //         //print(snapshot.toString());
        //         avgWeight = snapshot.data?.docs[0]['Average_Weight'];
        //         print(date.toString().substring(0, 10) + avgWeight.toString());
        //       }

        //       return Container(); // Your grid code.
        //     }),

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
                  title: Text("FCRCalculation".tr),
                  backgroundColor: mPrimaryColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              mortal = snapshot.data?.docs[0]['Mortal'];
                              totalChick = snapshot.data?.docs[0]['count'];
                              startDate = snapshot.data?.docs[0]['startdays'];
                              strainType = snapshot.data?.docs[0]['strain'];
                              days = date
                                  .difference(DateTime.parse(startDate))
                                  .inDays;
                              //print(_list[13].valueOf(13));
                              if (strainType == 'Cobb 500 - Broiler') {
                                weightDataStrain =
                                    strainList.PoultryData.weightDataCobb500;
                                feedtDataStrain =
                                    strainList.PoultryData.feedDataCobb500;
                              } else if (strainType == 'Ross 308 - Broiler') {
                                weightDataStrain =
                                    strainList.PoultryData.weightDataRoss308;
                                feedtDataStrain =
                                    strainList.PoultryData.feedDataRoss308;
                              } else if (strainType == 'Dekalb White - Layer') {
                                weightDataStrain = strainList
                                    .PoultryData.weightDataDekalbWhite;
                                feedtDataStrain =
                                    strainList.PoultryData.feedDataDekalbWhite;
                              } else if (strainType == 'Shaver Brown - Layer') {
                                weightDataStrain = strainList
                                    .PoultryData.weightDataShaverBrown;
                                feedtDataStrain =
                                    strainList.PoultryData.feedDataShavorBrown;
                              }

                              s_count = int.parse(totalChick);
                              idealWeightperchick =
                                  weightDataStrain[days].valueOf(days);
                              idealFeedperchick =
                                  feedtDataStrain[days].valueOf(days);

                              print(mortal);
                              print(totalChick);
                              print(startDate);
                              print(strainType);
                            }

                            return Container(
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(
                                    child: Image.asset(
                                      "assets/images/FCR-new.png",
                                      fit: BoxFit.fitWidth,
                                      width: context.width * 0.65,
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
                                            builder: (context) =>
                                                FCRManualScreen(
                                              mortalNavi: mortal,
                                              totalChicksNavi: totalChick,
                                            ),
                                          ),
                                        );
                                        //displayFCRdialog();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(200, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        primary: mPrimaryColor,
                                        elevation: 20,
                                        shadowColor: mSecondColor,
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      child: Text("calculatefcr".tr),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "startdate".tr,
                                        style: TextStyle(
                                            fontSize: 15, color: mPrimaryColor),
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: mPrimaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            startDate,
                                            style: TextStyle(
                                                fontSize: 15, color: mNewColor),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "type".tr,
                                        style: TextStyle(
                                            fontSize: 15, color: mPrimaryColor),
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: mPrimaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            strainType,
                                            style: TextStyle(
                                                fontSize: 15, color: mNewColor),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "days".tr,
                                        style: TextStyle(
                                            fontSize: 15, color: mPrimaryColor),
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: mPrimaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            days.toString(),
                                            style: TextStyle(
                                                fontSize: 15, color: mNewColor),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "idealWeight".tr,
                                        style: TextStyle(
                                            fontSize: 15, color: mPrimaryColor),
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: mPrimaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            idealWeightperchick.toString() +
                                                " g",
                                            style: TextStyle(
                                                fontSize: 15, color: mNewColor),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "idealFeed".tr,
                                        style: TextStyle(
                                            fontSize: 15, color: mPrimaryColor),
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: mPrimaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            idealFeedperchick.toString() + " g",
                                            style: TextStyle(
                                                fontSize: 15, color: mNewColor),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 5.h,
                                        width: 75.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: mPrimaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(
                                          "expectedfcr".tr +
                                              (idealFeedperchick /
                                                      idealWeightperchick)
                                                  .toStringAsPrecision(3),
                                          style: TextStyle(
                                              fontSize: 2.5.h,
                                              color: mNewColor),
                                        )),
                                  ),
                                ]),
                              ),
                            ); // Your grid code.
                          }),
                      //reuseTextField("Mortality"),

                      // Row(
                      //   //mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 6.0, vertical: 15.0),
                      //         child: reusableTextField3(
                      //             date.toString().substring(0, 10),
                      //             Icons.date_range,
                      //             false,
                      //             _datecontroller,
                      //             null,
                      //             false),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 6.0, vertical: 15.0),
                      //         child: ElevatedButton(
                      //           onPressed: () async {
                      //             DateTime? ndate = await showDatePicker(
                      //               context: context,
                      //               initialDate: date,
                      //               firstDate: DateTime(2022),
                      //               lastDate: DateTime.now(),
                      //               builder: (context, child) {
                      //                 return Theme(
                      //                   data: Theme.of(context).copyWith(
                      //                     colorScheme: ColorScheme.light(
                      //                       primary: mNewColor,
                      //                       onPrimary:
                      //                           Colors.white, // <-- SEE HERE
                      //                       onSurface:
                      //                           mSecondColor, // <-- SEE HERE
                      //                     ),
                      //                     textButtonTheme: TextButtonThemeData(
                      //                       style: TextButton.styleFrom(
                      //                         primary:
                      //                             mPrimaryColor, // button text color
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   child: child!,
                      //                 );
                      //               },
                      //             );
                      //             if (ndate == null) return;
                      //             setState(() => date = ndate);
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //             fixedSize: const Size(180, 50),
                      //             shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(30.0),
                      //                 side: BorderSide(
                      //                   width: 2.0,
                      //                   color: mPrimaryColor,
                      //                 )),
                      //             primary: mBackgroundColor,
                      //             elevation: 20,
                      //             shadowColor: Colors.transparent,
                      //             textStyle: TextStyle(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           child: Text(
                      //             "Touch to Pick Date",
                      //             style: TextStyle(color: Colors.black38),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Center(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       print(date);
                      //       popupDialog(s_count, mortal, args.flockID);
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => FCRAutoScreen(),
                      //       //   ),
                      //       // );
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       fixedSize: const Size(300, 50),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30.0),
                      //       ),
                      //       primary: mPrimaryColor,
                      //       elevation: 20,
                      //       shadowColor: mSecondColor,
                      //       textStyle: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     child: Text("Calculate FCR automatically"),
                      //   ),
                      // ),
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

  void popupDialog(int startCount, int mortal, String FlockID) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text("Checking for Update".tr),
          content: Text("Do you have updated the Mortality".tr),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No".tr)),
            TextButton(
                onPressed: () {
                  //displayFCRdialog(
                  //startCount, mortal, avgWeight, noBag, avgBagWeight);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FCRAutoScreen(
                        date: date,
                        id: FlockID,
                      ),
                    ),
                  );
                },
                child: Text("Yes".tr))
          ],
          //child: ListView.separated(
          //shrinkWrap: true,
        );
      },
    );
  }

  void displayFCRdialog(
      int startCount, int mortal, num avgWeight, num noBag, num avgBagWeight) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            backgroundColor: mBackgroundColor,
            title: const Text(
              "Current FCR",
              textAlign: TextAlign.center,
            ),
            content: Text("Starting Count: " +
                startCount.toString() +
                "\nTotal Mortality: " +
                mortal.toString() +
                "\nTotal Chicks Live: " +
                (startCount - mortal).toString() +
                "\nTotal Weight of Feed: " +
                (noBag * avgBagWeight).toString() +
                " kg" +
                "\n\nFCR = " +
                (noBag * avgBagWeight / ((startCount - mortal) * avgWeight))
                    .toStringAsFixed(3)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
              ),
            ],
            //child: ListView.separated(
            //shrinkWrap: true,
          );
        });
  }
}
