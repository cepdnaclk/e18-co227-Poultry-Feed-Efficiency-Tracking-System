import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
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
                  MediaQuery.of(context).size.height * 0.05,
                  20,
                  MediaQuery.of(context).size.height * 0.5),
              child: Column(
                children: <Widget>[
                  language(context, () {}),
                  Text(
                    "singin".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 165, 53, 130)),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    "assets/icons/loginFarmer.png",
                    fit: BoxFit.fitWidth,
                    width: 300,
                    height: 300,
                    color: Colors.purple,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  reusableTextField("enteremail".tr, Icons.person_sharp, false,
                      _emailTextController, validateEmail),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("enterPassword".tr, Icons.lock_sharp, true,
                      _passwordTextController, validatePasswordSignIn),
                  const SizedBox(
                    height: 20,
                  ),
                  firebaseUIButton(context, "singin".tr, () async {
                    if (_key.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                        )
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: 'Signed In',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:
                                  const Color.fromARGB(255, 253, 180, 233),
                              textColor: Colors.black);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        });
                        errorMessage = '';
                      } on FirebaseAuthException catch (error) {
                        errorMessage = error.message!;
                        Fluttertoast.showToast(
                            msg: errorMessage,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor:
                                const Color.fromARGB(255, 253, 180, 233),
                            textColor: Colors.black);
                      }
                      setState(() {});
                    }
                  }),
                  const SizedBox(
                    height: 5,
                  ),
                  signUpOption(),
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

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("dont_acc".tr,
            style: TextStyle(color: Color.fromARGB(255, 165, 53, 130))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: Text(
            "signup".tr,
            style: const TextStyle(
                color: Color.fromARGB(255, 165, 53, 130),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

Container language(BuildContext context, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
    child: IconButton(
      icon: const Icon(Icons.language),
      color: const Color.fromARGB(255, 165, 53, 130),
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
                    color: Color.fromARGB(255, 165, 53, 130),
                  );
                },
                itemCount: locale.length),
          ),
        );
      });
}

void updateLanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
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

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';

  return null;
}

String? validatePasswordSignIn(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }

  return null;
}