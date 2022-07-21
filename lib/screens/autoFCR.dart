import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/selectBodyWeight.dart';
import 'package:home_login/screens/griddashboard.dart';

class FCRAutoScreen extends StatefulWidget {
  // final String totalChicksNavi;
  // final int mortalNavi;
  // final num feedBagNavi;
  // final num bagWeightNavi;
  // final num avgWeightNavi;
  final DateTime date;
  final String id;

  //FCRAutoScreen({Key? key}) : super(key: key);
  FCRAutoScreen({
    Key? key,
    // required this.totalChicksNavi,
    // required this.mortalNavi,
    // required this.feedBagNavi,
    // required this.bagWeightNavi,
    // required this.avgWeightNavi,
    required this.date,
    required this.id,
  }) : super(key: key);

  @override
  State<FCRAutoScreen> createState() => _FCRAutoScreenState();
}

class _FCRAutoScreenState extends State<FCRAutoScreen> {
  final TextEditingController _datecontroller = TextEditingController();
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // num feedbag = 0, bagWeight = 0;
  // num avgWeight = 0;
  int mortal = 0, s_count = 0;
  String totalChick = '', flockID = '';
  num feedbag = 0, bagWeight = 0;
  num avgWeight = 0;

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    flockID = widget.id;
    //selectedDate = widget.date;
    return Stack(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Farmers')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('flock')
                .where(FieldPath.documentId, isEqualTo: flockID)
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
                .doc(flockID)
                .collection('FeedIntake')
                .where(FieldPath.documentId,
                    isEqualTo: selectedDate.toString().substring(0, 10))
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
                print(selectedDate.toString().substring(0, 10) +
                    feedbag.toString());
                print(selectedDate.toString().substring(0, 10) +
                    bagWeight.toString());
              }

              return Container(); // Your grid code.
            }),
        //Body Weight
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Farmers")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('flock')
                .doc(flockID)
                .collection('BodyWeight')
                .where(FieldPath.documentId,
                    isEqualTo: selectedDate.toString().substring(0, 10))
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
                print(selectedDate.toString().substring(0, 10) +
                    avgWeight.toString());
              }

              return Container(); // Your grid code.
            }),

        Scaffold(
            appBar: AppBar(
              title: Text("Auto FCR"),
              backgroundColor: mPrimaryColor,
            ),
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
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
                              selectedDate.toString().substring(0, 10),
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
                                initialDate: selectedDate,
                                firstDate: DateTime(2022),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: mNewColor,
                                        onPrimary: Colors.white, // <-- SEE HERE
                                        onSurface: mSecondColor, // <-- SEE HERE
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
                              setState(() => selectedDate = ndate);
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
                        print(selectedDate);
                        displayFCRdialog(
                            s_count, mortal, avgWeight, feedbag, bagWeight);
                        //popupDialog(s_count, mortal, flockID);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => FCRAutoScreen(),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 50),
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
                      child: Text("Calculate"),
                    ),
                  ),
                ],
              ),
            )),
      ],
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
