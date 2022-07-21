import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';

class DeleteBodyWeight extends StatefulWidget {
  DeleteBodyWeight({Key? key}) : super(key: key);

  @override
  State<DeleteBodyWeight> createState() => _DeleteBodyWeightState();
}

class _DeleteBodyWeightState extends State<DeleteBodyWeight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mPrimaryColor,
        title: Text("Delete Body Weight"),
      ),
      body: Center(child: Text("welcome to Delete Body Weight Page")),
    );
  }
}
