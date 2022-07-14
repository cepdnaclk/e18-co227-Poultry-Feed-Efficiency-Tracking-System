import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/autoFCR.dart';
import 'package:home_login/screens/body_weight.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/manualFCR.dart';

import 'drawerMenu.dart';

class FCRScreen extends StatefulWidget {
  const FCRScreen({Key? key}) : super(key: key);

  @override
  State<FCRScreen> createState() => _FCRScreenState();
}

class _FCRScreenState extends State<FCRScreen> with TickerProviderStateMixin {
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
  num feedbag = 0, bagWeight = 0;
  num avgWeight = 0;

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
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Farmers')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('flock')
                .where(FieldPath.documentId, isEqualTo: args.flockID)
                .snapshots(), // your stream url,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                //print(snapshot.toString());
                mortal = snapshot.data?.docs[0]['Mortal'];
                totalChick = snapshot.data?.docs[0]['count'];
                s_count = int.parse(totalChick);
                print(mortal);
                print(totalChick);
              }

              return Container(); // Your grid code.
            }),
        //Feed intake
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Farmers")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('flock')
                .doc(args.flockID)
                .collection('FeedIntake')
                .where(FieldPath.documentId,
                    isEqualTo: date.toString().substring(0, 10))
                .snapshots(), // your stream url,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.data!.docs.isEmpty ||
                  snapshot.data!.docs.isEmpty) {
                return CircularProgressIndicator();
                //return "Please update the Feed Page";
              } else {
                //print(snapshot.toString());
                feedbag = snapshot.data?.docs[0]['Number_of_bags'];
                bagWeight = snapshot.data?.docs[0]['Weight_of_a_bag'];
                print(date.toString().substring(0, 10) + feedbag.toString());
                print(date.toString().substring(0, 10) + bagWeight.toString());
              }

              return Container(); // Your grid code.
            }),
        //Body Weight
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Farmers")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('flock')
                .doc(args.flockID)
                .collection('BodyWeight')
                .where(FieldPath.documentId,
                    isEqualTo: date.toString().substring(0, 10))
                .snapshots(), // your stream url,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.data!.docs.isEmpty ||
                  snapshot.data!.docs.isEmpty) {
                return CircularProgressIndicator();
                //return "Please update the Feed Page";
              } else {
                //print(snapshot.toString());
                avgWeight = snapshot.data?.docs[0]['Average_Weight'];
                print(date.toString().substring(0, 10) + avgWeight.toString());
              }

              return Container(); // Your grid code.
            }),

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
                  title: Text("FCR CALCULATION"),
                  backgroundColor: mPrimaryColor,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //reuseTextField("Mortality"),
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FCRManualScreen(
                                mortalNavi: mortal,
                                totalChicksNavi: totalChick,
                              ),
                            ),
                          );
                          //displayFCRdialog();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: mPrimaryColor,
                          elevation: 20,
                          shadowColor: mSecondColor,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("Calculate FCR Manually"),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 15.0),
                            child: reusableTextField3(
                                date.toString().substring(0, 10),
                                Icons.date_range,
                                false,
                                _datecontroller,
                                null,
                                false),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                DateTime? ndate = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: mNewColor,
                                          onPrimary:
                                              Colors.white, // <-- SEE HERE
                                          onSurface:
                                              mSecondColor, // <-- SEE HERE
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary:
                                                mPrimaryColor, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (ndate == null) return;
                                setState(() => date = ndate);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(180, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                      width: 2.0,
                                      color: mPrimaryColor,
                                    )),
                                primary: mBackgroundColor,
                                elevation: 20,
                                shadowColor: Colors.transparent,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Text(
                                "Touch to Pick Date",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print(date);
                          popupDialog(
                              s_count, mortal, avgWeight, feedbag, bagWeight);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FCRAutoScreen(),
                          //   ),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: mPrimaryColor,
                          elevation: 20,
                          shadowColor: mSecondColor,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("Calculate FCR automatically"),
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

  // void displayFCRdialog() {
  //   showDialog(
  //       context: context,
  //       builder: (builder) {
  //         return AlertDialog(
  //           backgroundColor: mBackgroundColor,
  //           title: const Text(
  //             "Output",
  //             textAlign: TextAlign.center,
  //           ),
  //           content: const Text("-----Details-----\n-----Details-----"),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Close"),
  //             ),
  //           ],
  //           //child: ListView.separated(
  //           //shrinkWrap: true,
  //         );
  //       });
  // }

  void popupDialog(
      int startCount, int mortal, num avgWeight, num noBag, num avgBagWeight) {
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
                  displayFCRdialog(
                      startCount, mortal, avgWeight, noBag, avgBagWeight);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => FCRAutoScreen(
                  //       date: date,
                  //     ),
                  //   ),
                  // );
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
