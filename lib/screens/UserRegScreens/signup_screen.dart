import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/UserRegScreens/signin_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Colors.dart';

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
                padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
                child: Column(
                  children: <Widget>[
                    language(context, () {}),
                    Text(
                      "signup".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 4.h,
                        color: mPrimaryColor,
                      ),
                    ),
                    Image.asset(
                      "assets/icons/register.png",
                      fit: BoxFit.fitWidth,
                      width: 35.h,
                      height: 35.h,
                      color: mPrimaryTextColor,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    reusableTextField("enterUsername".tr, Icons.person_sharp,
                        false, _userNameTextController, null),
                    SizedBox(
                      height: 2.h,
                    ),
                    reusableTextField("enteremail".tr, Icons.email, false,
                        _emailTextController, validateEmail),
                    SizedBox(
                      height: 2.h,
                    ),
                    reusableTextField("enterPassword".tr, Icons.lock_sharp,
                        true, _passwordTextController, validatePassword),
                    firebaseUIButton(context, "signup".tr, () async {
                      if (_key2.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          )
                              .then((value) {
                            FirebaseFirestore.instance
                                .collection('User Data')
                                .add({
                              "email": _emailTextController.text,
                              "userName": _userNameTextController.text,
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                            });
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
                                    builder: (context) =>
                                        const SelectionScreen()));
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
                    signUpOption(),
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
