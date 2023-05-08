import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/net/flutter_fire.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/UserRegScreens/signup_screen.dart';
import 'package:get/get.dart';

class LocationRegScreen extends StatefulWidget {
  late String farmName;
  LocationRegScreen(this.farmName);
  //const BrachRegScreen({Key? key}) : super(key: key);

  @override
  State<LocationRegScreen> createState() => _LocationRegScreenState(farmName);
}

class _LocationRegScreenState extends State<LocationRegScreen> {
  //GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //late String _username,_password;
  late String farmName;
  _LocationRegScreenState(this.farmName);

  final TextEditingController _branchNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        //key: formKey,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).size.height * 0.1,
                  20,
                  MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: <Widget>[
                  Text(
                    "Add Location".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: mPrimaryColor),
                  ),
                  Image.asset(
                    "assets/icons/locationNew.jpg",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.9,
                    //color: Colors.purple,
                  ),
                  reusableTextField("Enter Location Name".tr, Icons.house, false,
                      _branchNameController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        await addBranch(_branchNameController.text, farmName);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Submit".tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }
                            return mPrimaryColor;
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
