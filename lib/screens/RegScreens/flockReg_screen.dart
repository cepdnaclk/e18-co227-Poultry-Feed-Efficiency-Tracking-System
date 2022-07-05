import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/net/flutter_fire.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/signup_screen.dart';
import 'package:get/get.dart';

class FlockRegScreen extends StatefulWidget {
  late String shedID, branchID, farmID;
  FlockRegScreen(this.shedID, this.branchID, this.farmID);
  //const BrachRegScreen({Key? key}) : super(key: key);

  @override
  State<FlockRegScreen> createState() =>
      _BranchRegScreenState(shedID, branchID, farmID);
}

class _BranchRegScreenState extends State<FlockRegScreen> {
  //GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //late String _username,_password;
  late String shedID, branchID, farmID;
  _BranchRegScreenState(this.shedID, this.branchID, this.farmID);

  //final TextEditingController _locationController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _strainController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

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
                    "Add Flock".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: mPrimaryColor),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    "assets/icons/shedNew.jpg",
                    fit: BoxFit.fitWidth,
                    width: 300,
                    height: 300,
                    //color: Colors.purple,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  reusableTextField("Enter Flock Name".tr, Icons.house, false,
                      _branchNameController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Start Date".tr, Icons.date_range,
                      false, _startDateController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Birth Date".tr, Icons.date_range,
                      false, _birthDateController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter the type".tr, Icons.type_specimen,
                      false, _typeController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter the strain".tr, Icons.egg, false,
                      _strainController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter the number of chickens".tr,
                      Icons.numbers, false, _numberController, null),
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
                        await addFlock(
                            _branchNameController.text,
                            shedID,
                            branchID,
                            farmID,
                            _startDateController.text,
                            _typeController.text,
                            _strainController.text,
                            _numberController.text,
                            _birthDateController.text);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Submit".tr,
                        style: TextStyle(
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
