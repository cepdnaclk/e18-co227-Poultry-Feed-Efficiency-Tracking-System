import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();



}

class _SignInScreenState extends State<SignInScreen> {


  //GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //late String _username,_password;


  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
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
                    "Sign In",
                    style: TextStyle(
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
                  reusableTextField("Enter Username", Icons.person_sharp, false,
                      _emailTextController),




                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_sharp, true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  firebaseUIButton(context, "Sign In", () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }).onError((error, stackTrace) {
                      //print("Error ${error.toString()}");

                    });
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
        const Text("Don't have account?",
            style: TextStyle(color: Color.fromARGB(255, 165, 53, 130))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
                color: Color.fromARGB(255, 165, 53, 130),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
