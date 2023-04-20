import 'package:home_login/screens/IdealStrain.dart' as strlist;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/Colors.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sfchart;
import '../../net/auth.dart';
import '../UserRegScreens/signin_screen.dart';
import '../selection_screen.dart';


class CompareIdeal extends StatefulWidget {

  final String id_flock;

  CompareIdeal({Key? key, required this.id_flock}) : super(key: key);

  @override
  State<CompareIdeal> createState() => _CompareIdealState();
}

class _CompareIdealState extends State<CompareIdeal> {


  List<PoultryData> weightDataCurrent = [];
  List<PoultryData> feedDataCurrent = [];
  List<strlist.PoultryData> weightDataStrain = [];
  List<strlist.PoultryData> feedtDataStrain = [];

  List<PoultryData> FCRlistCurrent = [];
  List<PoultryData> FCRlistStrain = [];

  var selectedFarm, selectedBranch, selectedFlock, selectedShed;
  String branchName = "", farmName = "", shedName = "", flockName = "";
  bool _isButtonDisabled = true;
  AuthClass auth = AuthClass();

  String strain = '';
  int mortal = 0;
  String totalChick = '';
  int i = 0, j = 0, n = 0,k=0;
  int state = 0;

  double prevFeedAmntFirst = 0;
  double prevFeedAmntSecond = 0;
  double prevWeightAmntFirst = 0;
  double prevWeightAmntSecond = 0;
  double prevFCRFirst = 0;
  double prevFCRSecond = 0;
  int minlen=0;

  String startDateFirst = '';
  Map<String, double> dataMap = {};

  final colorList = <Color>[
    //Colors.greenAccent,
    mPrimaryColor,
  ];

  @override
  void initState() {

    ProcessFCR();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
   // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Compare With Ideal Strain'),



          backgroundColor: mPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //to compare the strain
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
                      return CircularProgressIndicator();
                    } else {

                      //creating empty list to add elements after each refresh
                      weightDataStrain=[];
                      feedtDataStrain=[];

                      startDateFirst = snapshot.data?.docs[0]['startdays'];
                      strain = snapshot.data?.docs[0]['strain'].trim();

                      if (strain == 'Cobb 500 - Broiler') {
                        weightDataStrain = strlist.PoultryData.weightDataCobb500;
                        feedtDataStrain =strlist.PoultryData.feedDataCobb500;
                      } else if (strain == 'Ross 308 - Broiler') {
                        weightDataStrain = strlist.PoultryData.weightDataRoss308;
                        feedtDataStrain =strlist.PoultryData.feedDataRoss308;
                      } else if (strain == 'Dekalb White - Layer') {
                        weightDataStrain = strlist.PoultryData.weightDataDekalbWhite;
                        feedtDataStrain = strlist.PoultryData.feedDataDekalbWhite;
                      } else if (strain == 'Shaver Brown - Layer') {
                        weightDataStrain = strlist.PoultryData.weightDataShaverBrown;
                        feedtDataStrain = strlist.PoultryData.feedDataShavorBrown;
                      }
                    }

                    weightDataStrain=fillMissingDataStrlist(weightDataStrain);
                    feedtDataStrain=fillMissingDataStrlist(feedtDataStrain);

                    ProcessFCR();


                    var color = 0xffd16fb2;

                    return Container(
                      height: 0,
                    ); // Your grid code.
                  }),

              //to get current data
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

                      weightDataCurrent = []; // create new empty list

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
                              legendItemText: 'Active Batch',
                              //color: Colors.deepOrange ,
                              color: mPrimaryColor,
                              dataSource: weightDataCurrent,
                              xValueMapper: (PoultryData chick, _) => chick.day,
                              yValueMapper: (PoultryData chick, _) =>
                              chick.amount,
                            ),
                            sfchart.LineSeries<strlist.PoultryData, int>(
                              legendItemText: 'Ideal $strain',
                              color: Colors.orange,
                              dataSource: weightDataStrain.sublist(0, i),
                              xValueMapper: (strlist.PoultryData chick, _) => chick.day,
                              yValueMapper: (strlist.PoultryData chick, _) =>
                              chick.amount,
                            ),
                          ],
                        ),
                      );
                    }
                  }),

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

                          feedDataCurrent.add(PoultryData(k, product));

                          amntbags = 0.0;
                          amntKilo = 0.0;
                        } catch (e) {
                          amntKilo = -1.0;
                          amntbags = -1.0;
                        }
                      }

                      feedDataCurrent=fillMissingData(feedDataCurrent);

                      ProcessFCR();
                      //print(flockItems);
                      return Column(
                        children: [
                          Container(
                            height: 400,
                            margin: EdgeInsets.all(10),
                            child: sfchart.SfCartesianChart(
                              legend: sfchart.Legend(
                                  isVisible: true,
                                  position: sfchart.LegendPosition.bottom),
                              title: sfchart.ChartTitle(text: 'Feed Performance'),
                              primaryXAxis: sfchart.CategoryAxis(
                                //labelPosition: sfchart.ChartDataLabelPosition.inside,
                                  title: sfchart.AxisTitle(text: 'Days')),
                              primaryYAxis: sfchart.CategoryAxis(
                                  title: sfchart.AxisTitle(text: 'Feed (g)')),
                              series: <sfchart.ChartSeries>[
                                sfchart.LineSeries<PoultryData, int>(
                                  legendItemText: 'Active Batch',
                                  //color: Colors.deepOrange ,
                                  color: mPrimaryColor,
                                  dataSource: feedDataCurrent,
                                  xValueMapper: (PoultryData chick, _) => chick.day,
                                  yValueMapper: (PoultryData chick, _) =>
                                  chick.amount,
                                ),
                                sfchart.LineSeries<strlist.PoultryData, int>(
                                  legendItemText: 'Ideal $strain', color: Colors.orange,
                                  dataSource: feedtDataStrain.sublist(8, k),
                                  xValueMapper: (strlist.PoultryData chick, _) => chick.day,
                                  yValueMapper: (strlist.PoultryData chick, _) => chick.amount,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
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
                                  legendItemText: 'Active Batch',
                                  color: mPrimaryColor,
                                  dataSource: FCRlistCurrent,
                                  xValueMapper: (PoultryData chick, _) => chick.day,
                                  yValueMapper: (PoultryData chick, _) => chick.amount,
                                ),
                                sfchart.LineSeries<PoultryData, int>(
                                  legendItemText: 'Ideal $strain',
                                  color: Colors.orange,
                                  dataSource: FCRlistStrain,
                                  xValueMapper: (PoultryData chick, _) => chick.day,
                                  yValueMapper: (PoultryData chick, _) => chick.amount,
                                ),
                              ],
                            ),
                          ),


                        ],
                      );
                    }
                  }),

              SizedBox(height: 5.h),
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
    for (strlist.PoultryData data in feedtDataStrain) {
      if (data.day == day) {
        feedAmount += data.amount;
        break;
      }
    }

    for (strlist.PoultryData data in weightDataStrain) {
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
    FCRlistStrain.add(PoultryData(day, FCR ));

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
    for (strlist.PoultryData data in feedtDataStrain) {
      if (data.day > maxDaySecond) {
        maxDaySecond = data.day;
      }
    }

    for (strlist.PoultryData data in weightDataStrain) {
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


    FCRlistStrain=[];
    for (int fcrDay = 1; fcrDay <= minlen; fcrDay++) {
      calFCRSecond(fcrDay);
    }
  }


  List<strlist.PoultryData> fillMissingDataStrlist(List<strlist.PoultryData> data) {
    List<strlist.PoultryData> filledData = [];

    for (int i = 0; i < data.length - 1; i++) {
      strlist.PoultryData currentData = data[i];
      strlist.PoultryData nextData = data[i+1];

      filledData.add(currentData);

      double slope = (nextData.amount - currentData.amount) / (nextData.day - currentData.day);

      for (int j = currentData.day + 1; j < nextData.day; j++) {
        double amount = currentData.amount + slope * (j - currentData.day);
        filledData.add(strlist.PoultryData(j, amount));
      }
    }

    filledData.add(data.last);

    return filledData;
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

