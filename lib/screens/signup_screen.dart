import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
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
                Text(
                  "signup".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 165, 53, 130)),
                ),
                SizedBox(height: 15),
                logoWidget("assets/icons/signup.jpg"),
                SizedBox(
                  height: 0,
                ),
                reusableTextField("enterUsername".tr, Icons.person_sharp, false,
                    _userNameTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "enteremail".tr, Icons.email, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("enterPassword".tr, Icons.lock_sharp, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "signup".tr, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                SizedBox(
                  height: 5,
                ),
                signUpOption(),
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

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("have_acc".tr,
            style: TextStyle(
                color: Color.fromARGB(255, 165, 53, 130), fontSize: 13)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: Text(
            "singin".tr,
            style: TextStyle(
                color: Color.fromARGB(255, 165, 53, 130),
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
        )
      ],
    );
  }
}
