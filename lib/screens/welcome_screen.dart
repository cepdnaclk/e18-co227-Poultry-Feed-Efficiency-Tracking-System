import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/signin_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/welcome_back.png"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 20, 0),
            child: Column(
              children: <Widget>[
                Text(
                  "welcomeTitle".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 165, 53, 130)),
                ),
                SizedBox(height: 40),
                logoWidget("assets/icons/welcome.jpg"),
                SizedBox(
                  height: 50,
                ),
                welcomeButton(context, () {}),
                SizedBox(
                  height: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Container welcomeButton(BuildContext context, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      },
      child: Text('getStart'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return Color.fromARGB(255, 165, 53, 130);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}
