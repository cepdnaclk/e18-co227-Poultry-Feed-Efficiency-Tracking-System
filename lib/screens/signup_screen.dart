import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/signin_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key2 = GlobalKey<FormState>();
  String errorMessage = '';

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: _key2,
        child: Scaffold(
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
                      "signup".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: mPrimaryColor,
                      ),
                    ),
                    logoWidget("assets/icons/register.png"),
                    const SizedBox(
                      height: 0,
                    ),
                    reusableTextField("enterUsername".tr, Icons.person_sharp,
                        false, _userNameTextController, null),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("enteremail".tr, Icons.email, false,
                        _emailTextController, validateEmail),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("enterPassword".tr, Icons.lock_sharp,
                        true, _passwordTextController, validatePassword),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "signup".tr, () async {
                      if (_key2.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          )
                              .then((value) {
                            Fluttertoast.showToast(
                                msg: 'User Account Created!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: mSecondColor,
                                textColor: Colors.white);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SelectionScreen()));
                          });
                          errorMessage = '';
                        } on FirebaseAuthException catch (error) {
                          errorMessage = error.message!;
                          Fluttertoast.showToast(
                              msg: errorMessage,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: mSecondColor,
                              textColor: Colors.black);
                        }
                        setState(() {});
                      }
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
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("have_acc".tr,
            style: TextStyle(color: mPrimaryTextColor, fontSize: 13)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: Text(
            "singin".tr,
            style: TextStyle(
                color: mPrimaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
        )
      ],
    );
  }
}
