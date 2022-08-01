//import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/farm_view.dart';
import 'package:home_login/screens/home_screen.dart';

import '../net/flutter_fire.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  var selectedFarm, selectedBranch, selectedFlock, selectedShed;
  String branchName = "", farmName = "", shedName = "", flockName = "";
  bool _isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    print(selectedFarm);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mPrimaryColor,
          title: Text('batch_Selection'.tr),
        ),
        // ignore: unnecessary_new
        body: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 40.0),

            //For Farm
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Farmers")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Farms')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<DropdownMenuItem<String>> farmItems = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      farmItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['Name'],
                            style: TextStyle(color: mPrimaryColor),
                          ),

                          //value: "${snap.id}",
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 70,
                        ),
                        //Icon(FontAwesomeIcons.coins,
                        //size: 25.0, color: Color(0xff11b719)),
                        //SizedBox(width: 10.0),
                        DropdownButton<String>(
                          alignment: Alignment.centerLeft,
                          items: farmItems,
                          onChanged: (farmValue) {
                            final snackBar = SnackBar(
                              content: Text(
                                'Selected farm is $farmValue',
                                //style: TextStyle(color: Color(0xff11b719)),
                                style: TextStyle(color: mTitleTextColor),
                              ),
                            );

                            //Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              selectedFarm = farmValue!;
                              //farmName = getFarm(selectedFarm.toString());
                              void getFarm() async {
                                final doc = await FirebaseFirestore.instance
                                    .collection('Farmers')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('Farms')
                                    .doc(selectedFarm)
                                    .get();

                                farmName = doc['Name'];
                                setState(() {});
                              }

                              getFarm();
                              //farmName = ;
                            });
                          },
                          value: selectedFarm,
                          isExpanded: false,
                          hint: new Text(
                            'Choose your Farm'.tr,
                            style: TextStyle(
                              color: mPrimaryColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),

            SizedBox(
              height: 15.0,
            ),

            //For Branch
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Farmers")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Branch')
                    .where('FarmID', isEqualTo: selectedFarm)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<DropdownMenuItem<String>> branchItems = [];

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      branchItems.add(
                        DropdownMenuItem(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snap['BranchName'],
                            //snap.id,
                            style: TextStyle(color: mPrimaryColor),
                          ),
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //rcrossAxisAlignment: CrossAxisAlignment.star
                      children: <Widget>[
                        SizedBox(
                          width: 70,
                        ),
                        //SizedBox(width: 10.0),
                        farmName != ""
                            ? DropdownButton<String>(
                                //alignment: AlignmentDirectional.centerEnd,
                                items: branchItems,
                                onChanged: (branchValue) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Selected branch is $branchValue',
                                      style: TextStyle(color: mTitleTextColor),
                                    ),
                                  );

                                  //Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    selectedBranch = branchValue!;
                                    void getBranch() async {
                                      final doc = await FirebaseFirestore
                                          .instance
                                          .collection('Farmers')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('Branch')
                                          .doc(selectedBranch)
                                          .get();

                                      branchName = doc['BranchName'];
                                      setState(() {});
                                    }

                                    getBranch();
                                  });
                                },
                                value: selectedBranch,
                                isExpanded: false,
                                hint: new Text(
                                  "Choose your Branch".tr,
                                  style: TextStyle(
                                    color: mPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                              )
                            : IgnorePointer(
                                ignoring: true,
                                child: DropdownButton<String>(
                                  items: null,
                                  onChanged: null,
                                  value: selectedBranch,
                                  isExpanded: false,
                                  hint: new Text(
                                    "Choose your Branch".tr,
                                    style: TextStyle(
                                      color: mPrimaryColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              )
                      ],
                    );
                  }
                }),

            SizedBox(
              height: 15.0,
            ),
            //For Shed
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Farmers")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Shed')
                    .where('BranchID', isEqualTo: selectedBranch)
                    .where('FarmID', isEqualTo: selectedFarm)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<DropdownMenuItem<String>> shedItems = [];

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      shedItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['ShedName'],
                            style: TextStyle(color: mPrimaryColor),
                          ),
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 70,
                        ),
                        //SizedBox(width: 10.0),
                        branchName != ""
                            ? DropdownButton<String>(
                                items: shedItems,
                                onChanged: (shedValue) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Selected Shed is $shedValue',
                                      style: TextStyle(color: mTitleTextColor),
                                    ),
                                  );

                                  //Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    selectedShed = shedValue!;
                                    void getShed() async {
                                      final doc = await FirebaseFirestore
                                          .instance
                                          .collection('Farmers')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('Shed')
                                          .doc(selectedShed)
                                          .get();

                                      shedName = doc['ShedName'];
                                      setState(() {});
                                    }

                                    getShed();
                                  });
                                },
                                value: selectedShed,
                                isExpanded: false,
                                hint: Center(
                                  child: new Text(
                                    "Choose your Shed".tr,
                                    style: TextStyle(
                                      color: mPrimaryColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              )
                            : IgnorePointer(
                                ignoring: true,
                                child: DropdownButton<String>(
                                  items: null,
                                  onChanged: null,
                                  value: selectedShed,
                                  isExpanded: false,
                                  hint: new Text(
                                    "Choose your Shed".tr,
                                    style: TextStyle(
                                      color: mPrimaryColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    );
                  }
                }),
            SizedBox(
              height: 15.0,
            ),

            //For Flock

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Farmers")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('flock')
                    .where('ShedID', isEqualTo: selectedShed)
                    .where('BranchID', isEqualTo: selectedBranch)
                    .where('FarmID', isEqualTo: selectedFarm)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<DropdownMenuItem<String>> flockItems = [];

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      flockItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['FlockName'],
                            style: TextStyle(color: mPrimaryColor),
                          ),
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 70,
                        ),
                        //SizedBox(width: 10.0),
                        shedName != ""
                            ? DropdownButton<String>(
                                items: flockItems,
                                onChanged: (flockValue) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Selected flock is $flockValue',
                                      style: TextStyle(color: mTitleTextColor),
                                    ),
                                  );
                                  //Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    selectedFlock = flockValue!;
                                    void getFlock() async {
                                      final doc = await FirebaseFirestore
                                          .instance
                                          .collection('Farmers')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('flock')
                                          .doc(selectedFlock)
                                          .get();

                                      flockName = doc['FlockName'];
                                    }

                                    _isButtonDisabled = false;
                                    getFlock();
                                  });
                                },
                                value: selectedFlock,
                                isExpanded: false,
                                hint: new Text(
                                  "Choose your Flock".tr,
                                  style: TextStyle(
                                    color: mPrimaryColor,
                                    fontSize: 17,
                                  ),
                                ),
                              )
                            : IgnorePointer(
                                ignoring: true,
                                child: DropdownButton<String>(
                                  items: null,
                                  onChanged: null,
                                  value: selectedFlock,
                                  isExpanded: false,
                                  hint: new Text(
                                    "Choose your Flock".tr,
                                    style: TextStyle(
                                      color: mPrimaryColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    );
                  }
                }),

            SizedBox(
              height: 150.0,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: mPrimaryColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(36.0),
                    ),
                  ),
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen(
                                    farmNavi: selectedFarm,
                                    branchNavi: selectedBranch,
                                    shedNavi: selectedShed,
                                    flockNavi: selectedFlock,
                                    farmName: farmName,
                                    branchName: branchName,
                                    shedName: shedName,
                                    flockName: flockName);
                              },
                            ),
                          );
                        },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: Text(
                      'Proceed'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //foregroundColor: mPrimaryColor,
                    //backgroundColor: ,
                    primary: mBackgroundColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(36.0),
                    ),

                    side: BorderSide(color: mPrimaryColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FarmView();
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      'farmreg'.tr,
                      style: TextStyle(
                        color: mPrimaryColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
