import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/net/auth.dart';
import 'package:home_login/screens/UserRegScreens/reset_password.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/UserRegScreens/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../Colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  AuthClass auth = AuthClass();

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: _key,
        child: Scaffold(
          //key: formKey,
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
                      "singin".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 4.h,
                        color: mPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Image.asset(
                      "assets/icons/loginFarmer.png",
                      fit: BoxFit.fitWidth,
                      width: 35.h,
                      height: 35.h,
                      color: mPrimaryTextColor,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    reusableTextField("enteremail".tr, Icons.person_sharp,
                        false, _emailTextController, validateEmail),
                    SizedBox(
                      height: 2.h,
                    ),
                    reusableTextField("enterPassword".tr, Icons.lock_sharp,
                        true, _passwordTextController, validatePasswordSignIn),

                    forgetPassword(context),
                    firebaseUIButton(context, "singin".tr, () async {
                      if (_key.currentState!.validate()) {
                        try {
                          auth
                              .storetokenanddata(await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          ))
                              .then((value) {
                            Fluttertoast.showToast(
                                msg: 'Signed In',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: mSecondColor,
                                textColor: Colors.black);

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

  Widget forgetPassword(BuildContext context){
     return Container(
       width: MediaQuery.of(context).size.width,
       height: 30,
       alignment: Alignment.bottomRight,
       child: TextButton(
         onPressed: () {
           Navigator.push(
               context,
               MaterialPageRoute(
                   builder: (context) =>
                   const ResetPasswordScreen()));

         },
         child: Text(
           "Forgot Password?",
           textAlign: TextAlign.right,
           style: TextStyle(
             color: mNewColor,
             fontSize: 12

           ),
         ),
       ),
     );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("dont_acc".tr, style: TextStyle(color: mPrimaryTextColor)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: Text(
            "signup".tr,
            style: TextStyle(
                color: mPrimaryTextColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

Container language(BuildContext context, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 4.h,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    child: IconButton(
      icon: const Icon(Icons.language),
      color: mPrimaryColor,
      alignment: Alignment.topRight,
      onPressed: () {
        builddialog(context);
      },
    ),
  );
}

final List locale = [
  {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
  {'name': 'தமிழ்', 'locale': Locale('ta', 'IN')},
  {'name': 'සිංහල', 'locale': Locale('si', 'SL')}
];

void builddialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: const Text("Choose a Language"),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          //print(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                        },
                        child: Text(locale[index]['name'])),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: mPrimaryColor,
                  );
                },
                itemCount: locale.length),
          ),
        );
      });
}

void updateLanguage(Locale locale) {
  Get.updateLocale(locale);
  Get.back();
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'E-mail address is required.';
  }

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}



 ////////// 2023/3 update/////////
String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }

  String pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}\[\]|\\:;"<>,./?]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
      Password must be at least 8 characters long, 
      and include at least one uppercase letter, 
      one number, and one symbol (!@#\$%^&*()_+{}[]|\\:;"<>,./?)
    ''';

  return null;
}

String? validatePasswordSignIn(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }

  return null;
}
