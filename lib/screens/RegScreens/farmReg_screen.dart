import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/net/flutter_fire.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/signup_screen.dart';
import 'package:home_login/constants.dart';

class FarmRegScreen extends StatefulWidget {
  const FarmRegScreen({Key? key}) : super(key: key);

  @override
  State<FarmRegScreen> createState() => _FarmRegScreenState();
}

class _FarmRegScreenState extends State<FarmRegScreen> {
  //GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //late String _username,_password;

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
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
                    "Add Farm".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: mPrimaryColor),
                  ),
                  Image.asset(
                    "assets/images/farm.png",
                    fit: BoxFit.fitWidth,
                    width: 420,
                    height: 420,
                    //color: Colors.purple,
                  ),
                  reusableTextField("Enter Farm Name".tr, Icons.house, false,
                      _farmNameController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Farm Registration Number".tr,
                      Icons.app_registration, false, _locationController, null),
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
                        await addFarmer(
                            _farmNameController.text, _locationController.text);
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
