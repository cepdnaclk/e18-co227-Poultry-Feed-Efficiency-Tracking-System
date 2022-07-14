import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_login/screens/griddashboard.dart';

class FCRAutoScreen extends StatefulWidget {
  // final String totalChicksNavi;
  // final int mortalNavi;
  // final num feedBagNavi;
  // final num bagWeightNavi;
  // final num avgWeightNavi;
  final DateTime date;

  //FCRAutoScreen({Key? key}) : super(key: key);
  FCRAutoScreen({
    Key? key,
    // required this.totalChicksNavi,
    // required this.mortalNavi,
    // required this.feedBagNavi,
    // required this.bagWeightNavi,
    // required this.avgWeightNavi,
    required this.date,
  }) : super(key: key);

  @override
  State<FCRAutoScreen> createState() => _FCRAutoScreenState();
}

class _FCRAutoScreenState extends State<FCRAutoScreen> {
  // late DateTime selectedDate;
  // num feedbag = 0, bagWeight = 0;
  // num avgWeight = 0;
  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto"),
      ),
    );
  }
}
