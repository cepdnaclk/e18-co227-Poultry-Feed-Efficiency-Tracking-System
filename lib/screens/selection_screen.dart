import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/screens/RegScreens/ViewScreens/farm_view.dart';
import 'package:home_login/screens/home_screen.dart';
import '../net/auth.dart';
import 'UserRegScreens/signin_screen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  List<DropdownMenuItem<String>> farmItems = [];
  List<DropdownMenuItem<String>> branchItems = [];
  List<DropdownMenuItem<String>> shedItems = [];


  List<String> legalBranchNames=[];
  List<String> legalShedNames=[];
  List<String> legalFlockNames=[];

  var selectedFarm, selectedBranch, selectedFlock, selectedShed;
  String branchName = "", farmName = "", shedName = "", flockName = "";
  bool _isButtonDisabled = true;
  bool _islegal = false;
  AuthClass auth = AuthClass();

  bool isSelectedFarmBranchShed=false;
  bool isSelectedFarm=false;
  bool isSelectedFarmBranch =false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mPrimaryColor,
          title: Text('batch_Selection'.tr),
            actions: <Widget>[
              ///////// 2023/3 update /////////
              IconButton(
                  onPressed: () async {
                    await auth.logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => SignInScreen()),
                            (route) => false);
                  },
                  icon: Icon(Icons.logout)),


              ///////// 2023/3 update /////////
            ]
        ),
        // ignore: unnecessary_new
        body: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 20.0),

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
                    return  Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(mPrimaryColor),
                      ),
                    );
                  } else {
                    farmItems = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      farmItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['Name'],
                            style: TextStyle(color: Colors.red),
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

                        SizedBox(
                          width: 200,
                          child: DropdownButton<String>(
                            alignment: Alignment.centerLeft,
                            items: farmItems,
                            onChanged: (farmValue) {


                              //Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedFarm = farmValue!;
                                //farmName = getFarm(selectedFarm.toString());
                                void getFarm() async {
                                  final doc = await FirebaseFirestore.instance
                                      .collection('Farmers')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
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
                    .orderBy('FarmID')
                    .where('FarmID', isLessThanOrEqualTo: selectedFarm)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return  Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(mPrimaryColor),
                      ),
                    );
                  } else {
                    branchItems = [];
                    legalBranchNames=[];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {

                      isSelectedFarmBranchShed=false;
                      DocumentSnapshot snap = snapshot.data!.docs[i];

                      if(snap['FarmID'] == selectedFarm){

                         legalBranchNames.add(snap['BranchName']);
                         isSelectedFarmBranchShed=true;

                      }


                      branchItems.add(
                        DropdownMenuItem(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snap['BranchName'],
                            //snap.id,
                            style: TextStyle(
                                color:  isSelectedFarmBranchShed ? Colors.red : mPrimaryColor),
                          ),
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Row(
                      children: <Widget>[
                        SizedBox(
                          width: 70,
                        ),
                        farmName != ""
                            ? DropdownButton<String>(
                          items: branchItems,
                          onChanged: (branchValue) {
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
                            "Choose your Location".tr,
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
                              "Choose your Location".tr,
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
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(mPrimaryColor),

                    ),
                  );
                } else {
                  shedItems = [];
                  legalShedNames=[];

                  for (int i = 0; i < snapshot.data!.docs.length; i++) {

                    isSelectedFarmBranch=false;
                    DocumentSnapshot snap = snapshot.data!.docs[i];

                    if(snap['BranchID'] == selectedBranch && snap['FarmID'] == selectedFarm){
                      legalShedNames.add( snap['ShedName']);
                      isSelectedFarmBranch=true;
                    }



                    shedItems.add(
                      DropdownMenuItem(
                        child: Text(
                          snap['ShedName'],
                          style: TextStyle(
                            color: isSelectedFarmBranch ? Colors.red : mPrimaryColor,
                          ),
                        ),
                        value: "${snap.id}",
                      ),
                    );
                  }
                  return Row(
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                      ),
                      branchName != ""
                          ? DropdownButton<String>(
                        items: shedItems,
                        onChanged: (shedValue) {
                          setState(() {
                            selectedShed = shedValue!;
                            void getShed() async {
                              final doc = await FirebaseFirestore.instance
                                  .collection('Farmers')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
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
              },
            ),


            SizedBox(
              height: 15.0,
            ),

            //For Flock

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Farmers")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('flock')
                    //.where('ShedID', isEqualTo: selectedShed)
                    //.where('BranchID', isEqualTo: selectedBranch)
                    //.where('FarmID', isEqualTo: selectedFarm)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return  Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(mPrimaryColor),

                      ),
                    );
                  } else {
                    List<DropdownMenuItem<String>> flockItems = [];



                    for (int i = 0; i < snapshot.data!.docs.length; i++) {

                      isSelectedFarmBranchShed = false;
                      DocumentSnapshot snap = snapshot.data!.docs[i];

                      if(snap['BranchID'] == selectedBranch && snap['FarmID'] == selectedFarm && snap['ShedID'] == selectedShed){
                          legalFlockNames.add(snap['FlockName']);
                          isSelectedFarmBranchShed = true;
                      }


                      flockItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['FlockName'],
                            style: TextStyle(
                              color: isSelectedFarmBranchShed ? Colors.red : mPrimaryColor,
                            ),
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
                    backgroundColor: mPrimaryColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(36.0),
                    ),
                  ),
                  onPressed: _isButtonDisabled
                      ? null
                      : () {

                       //checks whether the selected fields actually represent a batch
                        if(legalBranchNames.contains(branchName) &&
                            legalShedNames.contains(shedName) &&
                            legalFlockNames.contains(flockName)){

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

                        }
                        else{
                          Fluttertoast.showToast(
                              msg: "Please Select fields decribed by red colour or else change the Farm",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: mSecondColor,
                              textColor: Colors.white);
                        }

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
                    backgroundColor: mBackgroundColor,
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
                SizedBox(
                  height: 20,
                ),
                helpOption(context),

              ],
            ),
          ],
        ));
  }

  Row helpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Help"),
                  content: Text("Proceed button will be only available \n"
                      "-If the user selects exactly one entity from all the dropdown menu\n"
                      "-If the user has  registered for atleast one field under each category\n\n"
                      "-If all the fields the user selected under each dropdown is in red\n\n"
                      "If you are unable to move in please use the Farm Registration button to Register "
                      "the farm details.\n"
                      "It is mandatory for a farm to have a tuple of farm/location/shed/flock",
                   style: TextStyle(color: mNewColor),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            "Need help?",
            style: TextStyle(
              color: mPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

}

