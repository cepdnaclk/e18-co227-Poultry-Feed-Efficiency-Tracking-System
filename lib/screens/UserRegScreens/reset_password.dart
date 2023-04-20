import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/UserRegScreens/signin_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';


import '../../Colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _key2 = GlobalKey<FormState>();
  String errorMessage = '';


  TextEditingController _emailTextController = TextEditingController();

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
                      "Reset Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: mPrimaryColor,
                      ),
                    ),
                    Image.asset(
                      "assets/images/resetFarmerNew.png",
                      fit: BoxFit.fitWidth,
                      width: 40.h,
                      height: 40.h,
                      color: mPrimaryTextColor,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),

                    reusableTextField("enteremail".tr, Icons.email, false,
                        _emailTextController, validateEmail),

                    firebaseUIButton(context, 'Reset Password', () async {

                      FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text)
                          .then((value) => Navigator.of(context).pop());
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
