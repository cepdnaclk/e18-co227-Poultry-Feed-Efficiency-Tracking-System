import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewScreen extends StatelessWidget {
   ViewScreen({Key? key}) : super(key: key);

   //this is for testing
  final List<PoultryData> weightDataStrain =[
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
  ];

   final List<PoultryData> weightDataCurrent =[
     PoultryData(0,  45),
     PoultryData(1,  54),
     PoultryData(2,  66),
     PoultryData(3,  70),
     PoultryData(4,  86),
     PoultryData(5,  115),
     PoultryData(6,  146),
     PoultryData(7,  180),
     PoultryData(8,  220),
     PoultryData(9,  280),
     PoultryData(10, 330),
   ];

  final List<PoultryData> feedDataStrain =[

    PoultryData(8,  37),
    PoultryData(9,  43),
    PoultryData(10, 50),

  ];

   final List<PoultryData> feedDataCurrent =[

     PoultryData(8,  44),
     PoultryData(9,  55),
     PoultryData(10, 70),

   ];


  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Poultry Analysis'),
            backgroundColor: mPrimaryColor,

          ),
        body: ListView(


          children: [

            Container(
              height: 400,
              margin: EdgeInsets.all(10),
              child:  SfCartesianChart(
                legend: Legend(isVisible: true, position :LegendPosition.bottom ),

                title: ChartTitle(text: 'Weight performance'),
                series: <ChartSeries>[
                  LineSeries<PoultryData,int>(
                    legendItemText: 'Active Batch',
                    color: Colors.deepOrange ,
                    dataSource: weightDataCurrent,
                    xValueMapper: (PoultryData chick, _)=> chick.day,
                    yValueMapper: (PoultryData chick, _)=> chick.amount,

                  ),
                  LineSeries<PoultryData,int>(
                    legendItemText: 'Equivalent ideal strain',
                    color: Colors.blue ,
                    dataSource: weightDataStrain,
                    xValueMapper: (PoultryData chick, _)=> chick.day,
                    yValueMapper: (PoultryData chick, _)=> chick.amount,

                  ),
                ],
              ),
            ),


            Container(
              height: 400,
              margin: EdgeInsets.all(10),
              child:  SfCartesianChart(
                legend: Legend(isVisible: true, position :LegendPosition.bottom ),

                title: ChartTitle(text: 'Feed Performance'),
                series: <ChartSeries>[
                  LineSeries<PoultryData,int>(
                    legendItemText: 'Active Batch',
                    color: Colors.deepOrange ,
                    dataSource: feedDataCurrent,
                    xValueMapper: (PoultryData chick, _)=> chick.day,
                    yValueMapper: (PoultryData chick, _)=> chick.amount,

                  ),
                  LineSeries<PoultryData,int>(

                    legendItemText: 'Equivalent ideal strain',
                    color: Colors.blue ,
                    dataSource: feedDataStrain,
                    xValueMapper: (PoultryData chick, _)=> chick.day,
                    yValueMapper: (PoultryData chick, _)=> chick.amount,

                  ),
                ],
              ),
            ),



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