import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/Colors.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sfchart;
import '../../net/auth.dart';
import 'package:intl/intl.dart';


class CompareActive extends StatefulWidget {

  final String id_flock;

  CompareActive({Key? key, required this.id_flock}) : super(key: key);

  @override
  State<CompareActive> createState() => _CompareActiveState();


}

class _CompareActiveState extends State<CompareActive> {



  List<BarChart> mortalityData = <BarChart>[];
  List<BarChart> mortalitySecond = <BarChart>[];
  List<PoultryData> weightDataCurrent = [];
  List<PoultryData> feedDataCurrent = [];
  List<PoultryData> weightDataCompared = [];
  List<PoultryData> feedDataCompared = [];


  List<String> legalBranchNames=[];
  List<String> legalShedNames=[];
  List<String> legalFlockNames=[];

  DateTime date =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<PoultryData> FCRlistCurrent = [];
  List<PoultryData> FCRlistCompared = [];

  List<DropdownMenuItem<String>> farmItems = [];
  List<DropdownMenuItem<String>> branchItems = [];
  List<DropdownMenuItem<String>> shedItems = [];
  List<DropdownMenuItem<String>> flockItems = [];

  bool isSelectedFarmBranchShed=false;
  bool isSelectedFarm=false;
  bool isSelectedFarmBranch =false;

  late DateTime startDate;
  double prevFeedAmntFirst = 0;
  double prevFeedAmntSecond = 0;
  double prevWeightAmntFirst = 0;
  double prevWeightAmntSecond = 0;
  double prevFCRFirst = 0;
  double prevFCRSecond = 0;
  int minlen=0;

  var selectedFarm, selectedBranch, selectedFlock, selectedShed;
  String branchName = "", farmName = "", shedName = "", flockName = "";
  bool _isButtonDisabled = true;
  AuthClass auth = AuthClass();

  String strain = '';
  String secondFlock='';
  String firstFlock='';
  String strainFlock2='';

  String startDateFirst = '';
  String startDateSecond = '';


  int mortal = 0;
  String totalChick = '';
  int i = 0, j = 0, n = 0,k=0,t=0,z=0,p=0;
  int state = 0;

  Map<String, double> dataMap = {};
  @override
  void initState() {

    ProcessFCR();
    super.initState();
  }

  final colorList = <Color>[

    mPrimaryColor,
  ];


  @override
  Widget build(BuildContext context) {
   // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Active Batch Comparison'),
          backgroundColor: mPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //////////////// 2023/3 update  /////////////////////////

              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Select one of your existing Batch to compare with the current Batch',
                  style: TextStyle(color: mNewColor,
                    fontSize: 18

                  ),

                ),
              ),
              SizedBox(height: 20.0),

              //For Farm
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Farmers")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Farms')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.only(left: 60,right: 60),
                      child: Container(

                        decoration: BoxDecoration(
                          border: Border.all(color: mPrimaryColor),
                          borderRadius: BorderRadius.circular(10),

                          
                        ),
                        child: Row(

                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: farmItems,
                                    onChanged: (farmValue) {
                                      setState(() {
                                        selectedFarm = farmValue!;
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
                                      });
                                    },
                                    value: selectedFarm,
                                    isExpanded: true,
                                    hint: new Text(
                                      "Select a Farm",
                                      style: TextStyle(
                                        color: mPrimaryColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                    dropdownColor: Colors.white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: mPrimaryColor, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),

              

              SizedBox(
                height: 15.0,
              ),

              //For Branch
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('Branch')
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
                            //alignment: Alignment.centerLeft,
                            child: Text(
                              snap['BranchName'],
                              //snap.id,
                              style: TextStyle(
                                  color: isSelectedFarmBranchShed ? Colors.red : mPrimaryColor
                              ),
                            ),
                            value: "${snap.id}",
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.only(left: 60,right: 60),
                        child: Container(


                            decoration: BoxDecoration(
                            border: Border.all(color: mPrimaryColor),
                             borderRadius: BorderRadius.circular(10),

                            ),
                          child: Row(

                            children: <Widget>[

                              //SizedBox(width: 10.0),
                              farmName != "" ?

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                    //alignment: AlignmentDirectional.centerEnd,
                                    items: branchItems,
                                    onChanged: (branchValue) {


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
                                        "Select a Location",
                                        style: TextStyle(
                                          color: mPrimaryColor,
                                          fontSize: 17,
                                        ),
                                    ),
                                          dropdownColor: Colors.white,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: TextStyle(color: mPrimaryColor, fontSize: 18),
                                  ),
                                      ),
                                ),
                              )
                                  : IgnorePointer(
                                    ignoring: true,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        items: null,
                                        onChanged: null,
                                        value: selectedBranch,
                                        isExpanded: false,

                                        hint: Padding(

                                          padding: const EdgeInsets.only(left:10),
                                          child: new Text(
                                            "Select a Location",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: mPrimaryColor,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        dropdownColor: Colors.white,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: mPrimaryColor, fontSize: 18),
                                      ),
                                    ),
                                  )
                            ],
                          ),
                        ),
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
                    //.where('BranchID', isEqualTo: selectedBranch)
                    //.where('FarmID', isEqualTo: selectedFarm)
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
                            style: TextStyle(color: isSelectedFarmBranch ? Colors.red : mPrimaryColor,
                            ),
                          ),
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.only(left: 60, right: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: mPrimaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            branchName != "" ?
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: shedItems,
                                    onChanged: (shedValue) {
                                      setState(() {
                                        selectedShed = shedValue!;
                                        void getShed() async {
                                          final doc = await FirebaseFirestore
                                              .instance
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
                                    hint: Text(
                                      "Select a shed",
                                      style: TextStyle(
                                        color: mPrimaryColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                    dropdownColor: Colors.white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: mPrimaryColor, fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                                : IgnorePointer(
                              ignoring: true,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  items: null,
                                  onChanged: null,
                                  value: selectedShed,
                                  isExpanded: false,
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Select a Shed",
                                      style: TextStyle(
                                        color: mPrimaryColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: mPrimaryColor, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                       flockItems = [];

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
                              style: TextStyle(color: isSelectedFarmBranchShed ? Colors.red : mPrimaryColor),
                            ),
                            value: "${snap.id}",
                          ),
                        );
                      }


                      return Padding(
                        padding: const EdgeInsets.only(left: 60,right: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: mPrimaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                             //to remove duplicates

                             //flockItems = flockItems.toSet().toList();
                              shedName != ""
                                  ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: DropdownButtonHideUnderline(

                                        child: DropdownButton<String>(
                                items: flockItems,
                                onChanged: (flockValue) {

                                        //Scaffold.of(context).showSnackBar(snackBar);
                                        setState(() {
                                          selectedFlock = flockValue!;
                                          ProcessFCR();
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
                                        "Select a Flock",
                                        style: TextStyle(
                                          color: mPrimaryColor,
                                          fontSize: 17,
                                        ),
                                ),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: mPrimaryColor, fontSize: 18),
                              ),
                                      ),
                                    ),
                                  )
                                  : IgnorePointer(
                                ignoring: true,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: null,
                                    onChanged: null,
                                    value: selectedFlock,
                                    isExpanded: false,
                                    hint: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Select a Flock",
                                        style: TextStyle(
                                          color: mPrimaryColor,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    dropdownColor: Colors.white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: mPrimaryColor, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),

              SizedBox(
                height: 30.0,
              ),


              //getting the name of Current flock
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Farmers')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .where(FieldPath.documentId, isEqualTo: widget.id_flock)
                      .snapshots(), // your stream url,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(mPrimaryColor),
                      );
                    } else {
                      startDateFirst = snapshot.data?.docs[0]['startdays'];
                      strain = snapshot.data?.docs[0]['strain'].trim();
                      firstFlock = snapshot.data?.docs[0]['FlockName'].trim();


                    }

                    return Padding(
                      
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current Batch",

                            style: TextStyle(
                              color: mNewColor,
                              fontSize: 20,

                            ),

                          ),
                          SizedBox(
                               height: 20,
                           ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Flock Name",
                                style: TextStyle(fontSize: 15, color: mPrimaryColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: mPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(

                                  firstFlock.toString(),
                                  style: TextStyle(fontSize: 17, color: mNewColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Strain type",
                                style: TextStyle(fontSize: 15, color: mPrimaryColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: mPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  strain+"",
                                  style: TextStyle(fontSize: 17, color: mNewColor),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 30,
                          ),



                        ],
                      ),
                    ); // Your grid code.
                  }),




              //getting the name of second flock
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Farmers')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .where(FieldPath.documentId, isEqualTo: selectedFlock)
                      .snapshots(), // your stream url,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(mPrimaryColor),
                      );
                    } else {

                      startDateSecond = snapshot.data?.docs[0]['startdays'];
                      strainFlock2 = snapshot.data?.docs[0]['strain'].trim();
                      secondFlock = snapshot.data?.docs[0]['FlockName'].trim();
                      print("Start Date Batch 2 - "+startDateSecond);

                    }

                    return Padding(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Compared Batch",
                            style: TextStyle(
                              color: mNewColor,
                              fontSize: 20,
                            ),

                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Flock Name",
                                style: TextStyle(fontSize: 15, color: mPrimaryColor),
                              ),

                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: mPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(

                                  secondFlock.toString(),
                                  style: TextStyle(fontSize: 17, color: mNewColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Strain type",
                                style: TextStyle(fontSize: 15, color: mPrimaryColor),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: mPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(

                                  strainFlock2.toString(),
                                  style: TextStyle(fontSize: 17, color: mNewColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ); // Your grid code.
                  }),


              ////////////////// 2023/3 update //////////////////
              ///weight Data Strain data collection selected flock
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(selectedFlock)
                      .collection('BodyWeight')
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
                      List<String> flockItems;

                      weightDataCompared = []; // create new empty list

                      for (t = 0; t < snapshot.data!.docs.length; t++) {

                        double amount = -1;
                        DateTime date;
                        int days = 0;

                        try {

                          date = DateTime.parse(snapshot.data!.docs[t].id.trim());
                          days = date.difference(DateTime.parse(startDateSecond.trim())).inDays;
                          amount = snapshot.data?.docs[t]['Average_Weight'];
                          weightDataCompared.add(PoultryData(days, amount));

                          amount = 0.0;
                        } catch (e) {
                          amount = -1;
                        }
                      }

                      if(weightDataCompared.isNotEmpty){
                        weightDataCompared=fillMissingData(weightDataCompared);

                      }

                      return Container(
                        height: 0,
                      );
                    }
                  }),



              ///weight data current data collection widget.flock id and graph
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(widget.id_flock)
                      .collection('BodyWeight')
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
                      List<String> flockItems;

                      weightDataCurrent = [];

                      for (i = 0; i < snapshot.data!.docs.length; i++) {

                        double amount = -1;
                        DateTime date;
                        int days = 0;

                        try {

                          date = DateTime.parse(snapshot.data!.docs[i].id.trim());
                          days = date.difference(DateTime.parse(startDateFirst.trim())).inDays;
                          amount = snapshot.data?.docs[i]['Average_Weight'];
                          weightDataCurrent.add(PoultryData(days, amount));

                          amount = 0.0;
                        } catch (e) {
                          amount = -1;
                        }


                      }
                      weightDataCurrent=fillMissingData(weightDataCurrent);
                      //print(flockItems);
                      return Container(
                        height: 400,
                        margin: EdgeInsets.all(10),
                        child: sfchart.SfCartesianChart(
                          legend: sfchart.Legend(
                              isVisible: true,
                              position: sfchart.LegendPosition.bottom),
                              title: sfchart.ChartTitle(text: 'Weight performance'),
                              primaryXAxis: sfchart.CategoryAxis(
                              title: sfchart.AxisTitle(text: 'Days')),
                              primaryYAxis: sfchart.CategoryAxis(
                              title: sfchart.AxisTitle(text: 'Weight (g)')),
                              series: <sfchart.ChartSeries>[
                                sfchart.LineSeries<PoultryData, int>(
                              legendItemText: 'Current Batch',
                              //color: Colors.deepOrange ,
                              color: mPrimaryColor,
                              dataSource: weightDataCurrent,

                              xValueMapper: (PoultryData chick, _) => chick.day,
                              yValueMapper: (PoultryData chick, _) =>
                              chick.amount,
                            ),
                            sfchart.LineSeries<PoultryData, int>(
                              legendItemText: 'Compared Batch',
                              color: Colors.orange,
                              dataSource: weightDataCompared,
                              xValueMapper: (PoultryData chick, _) => chick.day,
                              yValueMapper: (PoultryData chick, _) =>
                              chick.amount,
                            ),
                          ],
                        ),
                      );
                    }
                  }),


              ///feed data strain data collection selected flock
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(selectedFlock)
                      .collection('FeedIntake')
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

                      feedDataCompared = []; // create new empty list
                      for (j = 0; j < snapshot.data!.docs.length; j++) {

                        double amntbags = -1.0;
                        double amntKilo = -1.0;

                        DateTime date;
                        int days = 0;

                        try {

                          date = DateTime.parse(snapshot.data!.docs[j].id.trim());
                          days = date.difference(DateTime.parse(startDateSecond.trim())).inDays;
                          amntbags = snapshot.data?.docs[j]['Number_of_bags'];
                          amntKilo = snapshot.data?.docs[j]['Weight_of_a_bag'];
                          double product = amntKilo * amntbags;

                          feedDataCompared.add(PoultryData(days, product));

                          amntbags = 0.0;
                          amntKilo = 0.0;
                        } catch (e) {
                          amntKilo = -1.0;
                          amntbags = -1.0;
                        }
                      }

                      if(feedDataCompared.isNotEmpty){
                        feedDataCompared=fillMissingData(feedDataCompared);
                      }

                      //feedDataCompared=fillMissingData(feedDataCompared);


                      return Container(
                       height: 0,
                      );
                    }
                  }),




              ///feed data current data collection widget.flock id and graph
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(widget.id_flock)
                      .collection('FeedIntake')
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

                      feedDataCurrent = []; // create new empty list

                      int days = 0;
                      for (k = 0; k < snapshot.data!.docs.length; k++) {


                        double amntbags = -1.0;
                        double amntKilo = -1.0;
                        DateTime date;


                        try {

                          date = DateTime.parse(snapshot.data!.docs[k].id.trim());
                          days = date.difference(DateTime.parse(startDateFirst.trim())).inDays;
                          amntbags = snapshot.data?.docs[k]['Number_of_bags'];
                          amntKilo = snapshot.data?.docs[k]['Weight_of_a_bag'];

                          double product = amntKilo * amntbags;

                          feedDataCurrent.add(PoultryData(days, product));

                          amntbags = 0.0;
                          amntKilo = 0.0;
                        } catch (e) {
                          amntKilo = -1.0;
                          amntbags = -1.0;
                        }

                        feedDataCurrent=fillMissingData(feedDataCurrent);




                      }
                      ProcessFCR();
                      // j=days;
                      //
                      // if(j==0){
                      //   n=0;
                      // }
                      // else{
                      //   n=k;
                      // }



                      return Container(
                        height: 400,
                        margin: EdgeInsets.all(10),
                        child: sfchart.SfCartesianChart(
                          legend: sfchart.Legend(
                              isVisible: true,
                              position: sfchart.LegendPosition.bottom),
                          title: sfchart.ChartTitle(text: 'Feed Performance'),
                          primaryXAxis: sfchart.CategoryAxis(
                              title: sfchart.AxisTitle(text: 'Days')),
                          primaryYAxis: sfchart.CategoryAxis(
                              title: sfchart.AxisTitle(text: 'Feed (g)')),
                          series: <sfchart.ChartSeries>[

                            sfchart.LineSeries<PoultryData,int>(
                              legendItemText: 'Current Batch',
                              //color: Colors.deepOrange ,
                              color: mPrimaryColor,
                              dataSource: feedDataCurrent,
                              xValueMapper: (PoultryData chick, _) => chick.day,
                              yValueMapper: (PoultryData chick, _) =>
                              chick.amount,

                            ),

                            sfchart.LineSeries<PoultryData, int>(
                              legendItemText: 'Compared Batch', color: Colors.orange,
                              dataSource: feedDataCompared,
                              xValueMapper: (PoultryData chick, _) => chick.day,
                              yValueMapper: (PoultryData chick, _) => chick.amount,
                            ),
                          ],
                        ),
                      );
                    }
                  }),


              SizedBox(height: 20),



              //retreiving mortality data
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(selectedFlock)
                      .collection('Mortality')
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

                      mortalitySecond=[];
                      for (n = 0; n < snapshot.data!.docs.length; n++) {


                        int mortalamnt = -1;
                        int mortalDate = -1;

                        try {
                          //print(snapshot.data!.docs[j].id);
                          mortalamnt = snapshot.data?.docs[n]['Amount'];



                          mortalitySecond.add(BarChart(n, mortalamnt));

                        } catch (e) {
                          mortalamnt = -1;
                        }
                      }
                      //print(flockItems);
                      return Container(
                        height: 0,
                      );
                    }
                  }),

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(widget.id_flock)
                      .collection('Mortality')
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

                      mortalityData=[];
                      for (n = 0; n < snapshot.data!.docs.length; n++) {


                        int mortalamnt = -1;
                        int mortalDate = -1;
                        //String Strdouble;
                        try {
                          //print(snapshot.data!.docs[j].id);
                          mortalamnt = snapshot.data?.docs[n]['Amount'];





                          mortalityData.add(BarChart(n, mortalamnt));




                        } catch (e) {
                          mortalamnt = -1;
                        }
                      }
                      //print(flockItems);
                      return Column(
                        children: [

                          Container(
                            height: 400,
                            margin: EdgeInsets.all(10),
                            child: sfchart.SfCartesianChart(
                              legend: sfchart.Legend(
                                  isVisible: true,
                                  position: sfchart.LegendPosition.bottom
                              ),
                              title: sfchart.ChartTitle(text: 'Cumulative FCR performance'),
                              primaryXAxis: sfchart.CategoryAxis(
                                title: sfchart.AxisTitle(text: 'Days'),
                              ),
                              primaryYAxis: sfchart.NumericAxis(
                                title: sfchart.AxisTitle(text: 'FCR'),
                                numberFormat: NumberFormat.decimalPattern(),
                              ),
                              series: <sfchart.ChartSeries>[
                                sfchart.LineSeries<PoultryData, int>(
                                  legendItemText: 'Current Batch',
                                  color: mPrimaryColor,
                                  dataSource: FCRlistCurrent,
                                  xValueMapper: (PoultryData chick, _) => chick.day,
                                  yValueMapper: (PoultryData chick, _) => chick.amount,
                                ),
                                sfchart.LineSeries<PoultryData, int>(
                                  legendItemText: 'Compared Batch',
                                  color: Colors.orange,
                                  dataSource: FCRlistCompared,
                                  xValueMapper: (PoultryData chick, _) => chick.day,
                                  yValueMapper: (PoultryData chick, _) => chick.amount,
                                ),
                              ],
                            ),
                          ),


                          SizedBox(
                            height: 30,
                          ),
                          Container(
                              height: 400,
                              margin: EdgeInsets.all(10),
                              child: sfchart.SfCartesianChart(
                                  title: sfchart.ChartTitle(
                                      text: 'Mortility On Daily basis'),
                                  primaryXAxis: sfchart.CategoryAxis(
                                    //labelPosition: sfchart.ChartDataLabelPosition.inside,
                                      title: sfchart.AxisTitle(text: 'Day')),
                                  legend: sfchart.Legend(
                                      isVisible: true,
                                      position: sfchart.LegendPosition.bottom),
                                      series: <sfchart.ChartSeries>[
                                      sfchart.BarSeries<BarChart, int>(
                                      legendItemText: 'Death Count',
                                      dataSource: mortalityData,
                                      xValueMapper: (BarChart data, _) => data.date,
                                      yValueMapper: (BarChart data, _) =>
                                      data.amount,
                                      // Width of the bars
                                      width: 1,
                                      // Spacing between the bars
                                      spacing: 0.5,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                      color: mPrimaryColor,
                                    )
                                  ])),
                        ],
                      );
                    }
                  }),

              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Farmers')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .where(FieldPath.documentId, isEqualTo: widget.id_flock)
                      .snapshots(), // your stream url,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(mPrimaryColor),

                      );
                    } else {
                      mortal = snapshot.data?.docs[0]['Mortal'];
                      totalChick = snapshot.data?.docs[0]['count'];
                      dataMap['Mortality'] = mortal.toDouble();


                    }






                    return Container(
                      //padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.only(top: 20),

                      child: Column(
                        children: [
                          Text(
                            "Mortality as a Percantage of Start Count",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: PieChart(
                              dataMap: dataMap,
                              chartType: ChartType.ring,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.right,
                                  legendTextStyle:
                                  TextStyle(color: mPrimaryTextColor)),
                              baseChartColor: mPrimaryColor.withOpacity(0.7),
                              chartRadius: 180,
                              ringStrokeWidth: 20,
                              chartLegendSpacing: 30,
                              centerTextStyle:
                              TextStyle(color: mPrimaryTextColor),
                              centerText: "Start Count",

                              //baseChartColor: mPrimaryColor,
                              colorList: colorList,

                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              totalValue: double.parse(totalChick),
                            ),
                          )
                        ],
                      ),

                    );
                  }),
            ],
          ),
        ));
  }

  void calFCRfirst(int day) {
    double feedAmount = prevFeedAmntFirst;
    double weightAmount = prevWeightAmntFirst;

    // Add the current day's values to the cumulative values
    for (PoultryData data in feedDataCurrent) {
      if (data.day == day) {
        feedAmount += data.amount;
        break;
      }
    }


    for (PoultryData data in weightDataCurrent) {
      if (data.day == day) {
        weightAmount += data.amount;
        break;
      }
    }

    // Calculate the FCR if both values are available
    double FCR = 0;
    print("Got here");
    if (weightAmount != 0 ) {
      FCR = feedAmount / weightAmount;

    }

    // Add the result to the FCR list
    FCRlistCurrent.add(PoultryData(day, FCR != 0 ? FCR : prevFCRFirst));

    // Update the previous values for the next iteration
    prevFeedAmntFirst = feedAmount;
    prevWeightAmntFirst = weightAmount;
    prevFCRFirst = FCR != 0 ? FCR : prevFCRFirst;
  }
  void calFCRSecond(int day) {
    double feedAmount = prevFeedAmntSecond;
    double weightAmount = prevWeightAmntSecond;

    // Add the current day's values to the cumulative values
    for (PoultryData data in feedDataCompared) {
      if (data.day == day) {
        feedAmount += data.amount;
        break;
      }
    }

    for (PoultryData data in weightDataCompared) {
      if (data.day == day) {
        weightAmount += data.amount;
        break;
      }
    }


    // Calculate the FCR if both values are available
    double FCR = 0;
    if (weightAmount != 0 && feedAmount!=0) {
      FCR = feedAmount / weightAmount;
    }

    // Add the result to the FCR list
    FCRlistCompared.add(PoultryData(day, FCR ));

    // Update the previous values for the next iteration
    prevFeedAmntSecond = feedAmount;
    prevWeightAmntSecond = weightAmount;
    prevFCRSecond = FCR != 0 ? FCR : prevFCRSecond;
  }

  void ProcessFCR(){
    prevFeedAmntFirst = 0;
    prevFeedAmntSecond = 0;
    prevWeightAmntFirst = 0;
    prevWeightAmntSecond = 0;
    prevFCRFirst = 0;
    prevFCRSecond = 0;
    minlen=0;

    ///Calculating FCR
    // Iterate through the days until both lists have data
    int maxDayFirst = 0;
    for (PoultryData data in feedDataCurrent) {
      if (data.day > maxDayFirst) {
        maxDayFirst = data.day;
      }
    }

    for (PoultryData data in weightDataCurrent) {
      if (data.day > maxDayFirst) {
        maxDayFirst = data.day;
      }
    }

    ///Calculating FCR
    // Iterate through the days until both lists have data
    int maxDaySecond = 0;
    for (PoultryData data in feedDataCompared) {
      if (data.day > maxDaySecond) {
        maxDaySecond = data.day;
      }
    }

    for (PoultryData data in weightDataCompared) {
      if (data.day > maxDaySecond) {
        maxDaySecond = data.day;
      }
    }


    // Find the minimum length of the feedDataCurrent and weightDataCurrent lists
    if(maxDayFirst<maxDaySecond){
      minlen = maxDayFirst;
    }
    else{
      minlen = maxDaySecond;
    }

    if(maxDayFirst==0){
      minlen=maxDaySecond;
    }

    if(maxDaySecond==0){
      minlen=maxDayFirst;
    }

    FCRlistCurrent=[];
    for (int fcrDay = 1; fcrDay <= minlen; fcrDay++) {

      calFCRfirst(fcrDay);
    }


    FCRlistCompared=[];
    for (int fcrDay = 1; fcrDay <= minlen; fcrDay++) {
      calFCRSecond(fcrDay);
    }
  }


  List<PoultryData> fillMissingData(List<PoultryData> data) {
    List<PoultryData> filledData = [];

    for (int i = 0; i < data.length - 1; i++) {
      PoultryData currentData = data[i];
      PoultryData nextData = data[i+1];

      filledData.add(currentData);

      double slope = (nextData.amount - currentData.amount) / (nextData.day - currentData.day);

      for (int j = currentData.day + 1; j < nextData.day; j++) {
        double amount = currentData.amount + slope * (j - currentData.day);
        filledData.add(PoultryData(j, amount));
      }
    }

    filledData.add(data.last);

    return filledData;
  }

}

class PoultryData {
  final double amount;
  final int day;

  PoultryData(this.day, this.amount);
}

// Class for chart data source, this can be modified based on the data in Firestore
class BarChart {
  final int amount;
  final int date;

  BarChart(this.date, this.amount);
}
