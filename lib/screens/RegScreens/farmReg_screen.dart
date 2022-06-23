import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/net/flutter_fire.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/signup_screen.dart';

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
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).size.height * 0.1,
                  20,
                  MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: <Widget>[
                  const Text(
                    "Add Farm",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 165, 53, 130)),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    "assets/icons/farm.png",
                    fit: BoxFit.fitWidth,
                    width: 300,
                    height: 300,
                    //color: Colors.purple,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
<<<<<<< HEAD:lib/screens/RegScreens/farmReg_screen.dart
                  reusableTextField("Enter Farm Name", Icons.house, false,_farmNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Farm location", Icons.location_on,false, _locationController),
=======
                  reusableTextField("Enter Farm Name", Icons.house, false,
                      _farmNameController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Farm location", Icons.location_on,
                      false, _locationController, null),
>>>>>>> 6fa7ff3cdbe89e9ed041ba1c944387ecbcfb2f1c:lib/screens/farmReg_screen.dart
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
                        "Submit",
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
                            return Color.fromARGB(255, 165, 53, 130);
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
