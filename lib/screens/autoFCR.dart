import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FCRAutoScreen extends StatefulWidget {
  
  FCRAutoScreen({Key? key}) : super(key: key);

  @override
  State<FCRAutoScreen> createState() => _FCRAutoScreenState();
}

class _FCRAutoScreenState extends State<FCRAutoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto"),
      ),
    );
  }
}
