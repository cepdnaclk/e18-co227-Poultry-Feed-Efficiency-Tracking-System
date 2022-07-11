import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewScreen extends StatefulWidget {
   ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}



class _ViewScreenState extends State<ViewScreen> {

    List<BarChart> mortalityData = <BarChart>[];
    //List<PoultryData> weightDataCurrent=[PoultryData(0, 0)];
     List<PoultryData> weightDataCurrent= [];
    List<PoultryData> feedDataCurrent= [];
    List<PoultryData> weightDataStrain= [];


    int i=0,j=0,n=0;


    //this is for testing
   final List<PoultryData> weightDataCobb500 =[
     PoultryData(0,  42),
     PoultryData(1,  63),
     PoultryData(2,  74),
     PoultryData(3,  90),
     PoultryData(4,  109),
     PoultryData(5,  134),
     PoultryData(6,  163),
     PoultryData(7,  193),
     PoultryData(8,  228),
     PoultryData(9,  269),
     PoultryData(10, 313),
     PoultryData(11, 362),
     PoultryData(12, 414),
     PoultryData(13, 469),
     PoultryData(14, 528),
     PoultryData(15, 589),
     PoultryData(16, 654),
     PoultryData(17, 722),
     PoultryData(18, 792),
     PoultryData(19, 865),
     PoultryData(20, 941),
     PoultryData(21, 1018),
     PoultryData(22, 1098),
     PoultryData(23, 1180),
     PoultryData(24, 1264),
     PoultryData(25, 1349),
     PoultryData(26, 1436),
     PoultryData(27, 1525),
     PoultryData(28, 1615),
     PoultryData(29, 1706),
     PoultryData(30, 1798),
     PoultryData(31, 1892),
     PoultryData(32, 1986),
     PoultryData(33, 2081),
     PoultryData(34, 2177),
     PoultryData(35, 2273),
     PoultryData(36, 2369),
     PoultryData(37, 2466),
     PoultryData(38, 2563),
     PoultryData(39, 2661),
     PoultryData(40, 2758),
     PoultryData(41, 2855),
     PoultryData(42, 2952),
     PoultryData(43, 3049),
     PoultryData(44, 3145),
     PoultryData(45, 3240),
     PoultryData(46, 3335),
     PoultryData(47, 3430),
     PoultryData(48, 3524),
     PoultryData(49, 3617),
     PoultryData(50, 3707),
     PoultryData(51, 3797),
     PoultryData(52, 3885),
     PoultryData(53, 3973),
     PoultryData(54, 4059),
     PoultryData(55, 4144),
     PoultryData(56, 4227),
     PoultryData(57, 4309),
     PoultryData(58, 4389),
     PoultryData(59, 4466),
     PoultryData(60, 4542),
     PoultryData(61, 4616),
     PoultryData(62, 4688),
     PoultryData(63, 4759),

   ];






  final List<PoultryData> feedDataCobb500 =[

    PoultryData(8,  37),
    PoultryData(9,  43),
    PoultryData(10, 50),
    PoultryData(11, 57),
    PoultryData(12, 64),
    PoultryData(13, 72),
    PoultryData(14, 74),
    PoultryData(15, 78),
    PoultryData(16, 85),
    PoultryData(17, 91),
    PoultryData(18, 103),
    PoultryData(19, 110),
    PoultryData(20, 114),
    PoultryData(21, 118),
    PoultryData(22, 123),
    PoultryData(23, 128),
    PoultryData(24, 133),
    PoultryData(25, 137),
    PoultryData(26, 144),
    PoultryData(27, 150),
    PoultryData(28, 156),
    PoultryData(29, 160),
    PoultryData(30, 164),
    PoultryData(31, 167),
    PoultryData(32, 170),
    PoultryData(33, 174),
    PoultryData(34, 177),
    PoultryData(35, 179),
    PoultryData(36, 182),
    PoultryData(37, 186),
    PoultryData(38, 190),
    PoultryData(39, 193),
    PoultryData(40, 197),
    PoultryData(41, 203),
    PoultryData(42, 208),
    PoultryData(43, 213),
    PoultryData(44, 218),
    PoultryData(45, 224),
    PoultryData(46, 228),
    PoultryData(47, 231),
    PoultryData(48, 236),
    PoultryData(49, 241),
    PoultryData(50, 243),
    PoultryData(51, 244),
    PoultryData(52, 245),
    PoultryData(53, 247),
    PoultryData(54, 247),
    PoultryData(55, 246),
    PoultryData(56, 245),
    PoultryData(57, 243),
    PoultryData(58, 241),
    PoultryData(59, 239),
    PoultryData(60, 237),
    PoultryData(61, 234),
    PoultryData(62, 232),
    PoultryData(63, 228),


  ];


/*
   final List<PoultryData> feedDataCurrent =[

     PoultryData(8,  44),
     PoultryData(9,  55),
     PoultryData(10, 70),

   ];

 */

  @override
  Widget build(BuildContext context) {


    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    String strain;




    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Poultry Analysis'),
            backgroundColor: mPrimaryColor,

          ),
        body: ListView(


          children: [


        //to compare the strain
        StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Farmers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('flock')
            .where(FieldPath.documentId, isEqualTo: args.flockID)
            .snapshots(), // your stream url,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            //print(snapshot.toString());
            strain = snapshot.data?.docs[0]['strain'].trim();
            //print(strain);
            // print(strain);
            if(strain == 'Cobb 500 - Broiler'){
              weightDataStrain = weightDataCobb500;
            }

          }

          //var color = 0xff453658;
          var color = 0xffd16fb2;

          return Container(
            height: 0,
          ); // Your grid code.
        }
        ),


            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Farmers")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('flock')
                    .doc(args.flockID)
                    .collection('BodyWeight')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {


                    List<String> flockItems;
                    //late final List <ChartData> weightDataCurrent;

                    //final Map<String, int> someMap = {

                    //};
                    for (i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];

                      double amount = -1;
                      String date;
                      try {
                        amount = snapshot.data?.docs[i]['Average_Weight'];
                        date = snapshot.data!.docs[i].id;
                        //print(snapshot.data!.docs[i].id);
                        //print(i);
                        //print(amount);
                        //print('');
                        weightDataCurrent.add(PoultryData(i, amount));

                        amount=0.0;
                      } catch (e) {
                        amount = -1;
                      }

                    }
                    //print(flockItems);
                    return Container(
                      height: 400,
                      margin: EdgeInsets.all(10),
                      child:  SfCartesianChart(
                        legend: Legend(isVisible: true, position :LegendPosition.bottom ),

                        title: ChartTitle(text: 'Weight performance'),
                        series: <ChartSeries>[
                          LineSeries<PoultryData,int>(
                            legendItemText: 'Active Batch',
                            //color: Colors.deepOrange ,
                            color: mPrimaryColor,
                            dataSource: weightDataCurrent,

                            xValueMapper: (PoultryData chick, _)=> chick.day,
                            yValueMapper: (PoultryData chick, _)=> chick.amount,

                          ),
                          LineSeries<PoultryData,int>(
                            legendItemText: 'Equivalent ideal strain',
                            color: Colors.orange ,
                            dataSource: weightDataStrain.sublist(0,i),
                            xValueMapper: (PoultryData chick, _)=> chick.day,
                            yValueMapper: (PoultryData chick, _)=> chick.amount,

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
                    .doc(args.flockID)
                    .collection('FeedIntake')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {


                    //List<String> flockItems;
                    //late final List <ChartData> weightDataCurrent;

                    //final Map<String, int> someMap = {

                    //};
                    for ( j = 0; j < snapshot.data!.docs.length; j++) {
                      DocumentSnapshot snap = snapshot.data!.docs[j];

                      double amntbags= -1.0;
                      double amntKilo= -1.0;
                      String date;
                      //String Strdouble;
                      try {

                        print(snapshot.data!.docs[j].id);
                        amntbags = snapshot.data?.docs[j]['Number_of_bags'];
                        amntKilo = snapshot.data?.docs[j]['Weight_of_a_bag'] ;
                        date = snapshot.data!.docs[j].id;
                        //print(snapshot.data!.docs[j].id);
                        //print(j);
                        //print(amntbags);
                        //print(amntKilo);
                        print('');
                        double product= amntKilo * amntbags;
                        print(product);
                        int k=j+8;
                        feedDataCurrent.add(PoultryData(k , product));


                        amntbags=0.0;
                        amntKilo=0.0;

                      } catch (e) {
                        amntKilo = -1.0;
                        amntbags = -1.0;

                      }

                    }
                    //print(flockItems);
                    return Container(
                      height: 400,
                      margin: EdgeInsets.all(10),
                      child:  SfCartesianChart(
                        legend: Legend(isVisible: true, position :LegendPosition.bottom ),

                        title: ChartTitle(text: 'Feed Performance'),
                        series: <ChartSeries>[
                          LineSeries<PoultryData,int>(
                            legendItemText: 'Active Batch',
                            //color: Colors.deepOrange ,
                            color: mPrimaryColor,
                            dataSource: feedDataCurrent,
                            xValueMapper: (PoultryData chick, _)=> chick.day,
                            yValueMapper: (PoultryData chick, _)=> chick.amount,

                          ),
                          LineSeries<PoultryData,int>(

                            legendItemText: 'Equivalent ideal strain',
                            color: Colors.orange,
                            dataSource: feedDataCobb500.sublist(0,j),
                            xValueMapper: (PoultryData chick, _)=> chick.day,
                            yValueMapper: (PoultryData chick, _)=> chick.amount,

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
                    .doc(args.flockID)
                    .collection('Mortality')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {


                    //List<String> flockItems;
                    //late final List <ChartData> weightDataCurrent;

                    //final Map<String, int> someMap = {

                    //};
                    for ( n = 0; n < snapshot.data!.docs.length; n++) {
                      DocumentSnapshot snap = snapshot.data!.docs[n];

                      int mortalamnt = -1;
                      int mortalDate = -1;
                      //String Strdouble;
                      try {

                        //print(snapshot.data!.docs[j].id);
                        mortalamnt = snapshot.data?.docs[n]['Amount'];

                       // mortalDate = snapshot.data!.docs[n];
                        //print(snapshot.data!.docs[j].id);
                        //print(j);
                        //print(amntbags);
                        //print(amntKilo);

                        mortalityData.add(BarChart( n , mortalamnt));




                      } catch (e) {

                        mortalamnt = -1;

                      }

                    }
                    //print(flockItems);
                    return Container(
                      height: 400,
                      margin: EdgeInsets.all(10),
                        child: SfCartesianChart(

                            legend: Legend(isVisible: true, position :LegendPosition.bottom ),
                            series: <ChartSeries>[
                              BarSeries<BarChart, int>(
                                  legendItemText: 'Death Count',
                                  dataSource: mortalityData,
                                  xValueMapper: (BarChart data, _) => data.date,
                                  yValueMapper: (BarChart data, _) => data.amount,
                                  // Width of the bars
                                  width: 1,
                                  // Spacing between the bars
                                  spacing: 0.5,
                                   borderRadius: BorderRadius.all(Radius.circular(15)),
                                   color: mPrimaryColor,
                              )
                            ]
                        )
                    );
                  }
                }),






          ],
        )
    );


  }
}

class PoultryData{
  final double amount;
  final int day;


  PoultryData(this.day,this.amount);
}

// Class for chart data source, this can be modified based on the data in Firestore
class BarChart {
  final int amount;
  final int date;

  BarChart(this.date,this.amount);



}
  