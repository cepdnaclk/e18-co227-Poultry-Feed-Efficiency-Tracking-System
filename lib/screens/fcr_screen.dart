import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';

class FCRScreen extends StatefulWidget {
  const FCRScreen({Key? key}) : super(key: key);

  @override
  State<FCRScreen> createState() => _FCRScreenState();
}

class _FCRScreenState extends State<FCRScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("FCR CALCULATION"),
          backgroundColor: mPrimaryColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //reuseTextField("Mortality"),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
              child: reuseTextField("Avg. weight of a chick"),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 15.0),
                    child: reuseTextField("No. of Feed Bags"),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 15.0),
                    child: reuseTextField("Weight per bag"),
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: mPrimaryColor,
                  elevation: 20,
                  shadowColor: mSecondColor,
                ),
                onPressed: () {},
                child: const Text("Calculate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextField reuseTextField(String text) {
  return TextField(
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(color: Colors.black38),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            width: 2.0,
            color: mPrimaryColor,
          )),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
    ),
  );
}
