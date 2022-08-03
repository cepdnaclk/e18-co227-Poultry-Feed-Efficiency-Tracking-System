import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/BodyWeightScreen/addBody.dart';
import 'package:home_login/screens/BodyWeightScreen/deleteBody.dart';
import 'package:home_login/screens/BodyWeightScreen/updateBody.dart';
import 'package:home_login/screens/MortalScreens/addMortal.dart';
import 'package:home_login/screens/MortalScreens/deleteMortal.dart';
import 'package:home_login/screens/MortalScreens/updateMortal.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/view_screen.dart';
import 'drawerMenu.dart';

class MortalityScreen extends StatefulWidget {
  const MortalityScreen({Key? key}) : super(key: key);

  @override
  State<MortalityScreen> createState() => _MortalityScreenState();
}

class _MortalityScreenState extends State<MortalityScreen>
    with TickerProviderStateMixin {
  List weightDataCobb500 = [];
  String startDate = '';

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final TextEditingController _datecontroller = TextEditingController();
  final TextEditingController _numcontroller = TextEditingController();

  double translateX = 0.0;
  double translateY = 0.0;
  double scale = 1;
  bool toggle = false;
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Stack(
      children: [
        DrawerMenu(args.flockID),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          transform: Matrix4.translationValues(translateX, translateY, 0)
            ..scale(scale),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ClipRRect(
              borderRadius: (toggle)
                  ? BorderRadius.circular(20)
                  : BorderRadius.circular(0),
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_arrow,
                      progress: _animationController,
                    ),
                    onPressed: () {
                      toggle = !toggle;
                      if (toggle) {
                        translateX = 200.0;
                        translateY = 80.0;
                        scale = 0.8;
                        _animationController.forward();
                      } else {
                        translateX = 0.0;
                        translateY = 0.0;
                        scale = 1;
                        _animationController.reverse();
                      }
                      setState(() {});
                    },
                    //icon: Icon(Icons.menu),
                  ),
                  title: Text("MORTALITY".tr),
                  backgroundColor: mPrimaryColor,
                ),
                body: Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Farmers')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('flock')
                            .where(FieldPath.documentId,
                                isEqualTo: args.flockID)
                            .snapshots(), // your stream url,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            //print(snapshot.toString());
                            startDate = snapshot.data?.docs[0]['startdays'];
                            //print(startDate);
                            // AddMortal(
                            //     args.flockID, "60", startDate);

                            //print(mortal);
                            //print(totalChick);
                          }

                          return Container(); // Your grid code.
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateMortal(
                                id_flock: args.flockID,
                                // startDateNavi: startDate,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: mPrimaryColor,
                          elevation: 20,
                          shadowColor: mSecondColor,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("update".tr),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        // add foction
                        onPressed: () {
                          print(args.flockID);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddMortal(id_flock: args.flockID),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: mBackgroundColor,
                          side: BorderSide(color: mPrimaryColor),
                          elevation: 20,
                          shadowColor: mSecondColor,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text(
                          "add".tr,
                          style: TextStyle(
                            color: mPrimaryColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      // delete
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeleteMortal(
                                id_flock: args.flockID,
                                // startDateNavi: startDate,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: mPrimaryColor,
                          elevation: 20,
                          shadowColor: mSecondColor,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("Delete".tr),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> addBodyWeight(String id, String amount, String date) async {
    //num current = 0;
    num value = double.parse(amount);
    try {
      //print("try 1");
      DocumentReference<Map<String, dynamic>> documentReference =
          FirebaseFirestore.instance
              .collection('Farmers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('flock')
              .doc(id)
              .collection('BodyWeight')
              .doc(date);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await transaction.get(documentReference);

        if (!snapshot.exists) {
          //print("done 1 befre");
          documentReference.set({'Average_Weight': value});
          //print("done 1");

          //return true;
        } else {
          try {
            //num newAmount = snapshot.data()!['Amount'] + value;
            //current = snapshot.data()!['Average_Weight'];
            transaction.update(documentReference, {'Average_Weight': value});
            //print("done 1.2");
            //print(current);
            //return true;
          } catch (e) {
            //rethrow;
          }
        }
      });
      //return true;
    } catch (e) {
      // return false;
    }
    try {
      //print("try 2");
      DocumentReference<Map<String, dynamic>> documentReference2 =
          FirebaseFirestore.instance
              .collection('Farmers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('flock')
              .doc(id);

      FirebaseFirestore.instance.runTransaction((transaction2) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot2 =
            await transaction2.get(documentReference2);
        print(documentReference2);
        if (!snapshot2.exists) {
          //print("snap 2 noy exist");
          documentReference2.update({'Avg_BodyWeight': value});
          print("done 2");
          print(value);
          //return true;
        } else {
          try {
            print("done 2.2 before");
            //num n = snapshot2.data()!['Avg_BodyWeight'];
            num newAmount = value;
            print("done 2.2 before 2");
            transaction2
                .update(documentReference2, {'Avg_BodyWeight': newAmount});
            print("done 2.2");
            //return true;
          } catch (e) {
            //rethrow;
          }
        }
      });
    } catch (e) {
      //
    }
  }
}

// TextField reuseTextField1(String text) {
//   return TextField(
//     decoration: InputDecoration(
//       labelText: text,
//       labelStyle: TextStyle(color: Colors.black38),
//       filled: true,
//       floatingLabelBehavior: FloatingLabelBehavior.auto,
//       fillColor: Colors.white,
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: BorderSide(
//             width: 2.0,
//             color: mPrimaryColor,
//           )),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(30.0),
//         borderSide: BorderSide(
//           color: mPrimaryColor,
//           width: 2.0,
//         ),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(30.0),
//         borderSide: BorderSide(
//           color: mPrimaryColor,
//           width: 2.0,
//         ),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(30.0),
//         borderSide: BorderSide(
//           color: mPrimaryColor,
//           width: 2.0,
//         ),
//       ),
//     ),
//   );
// }

TextFormField reusableTextField3(
    String text,
    IconData icon,
    bool isPasswordType,
    TextEditingController controller,
    validator,
    bool val) {
  return TextFormField(
    onTap: () {
      print("shamod");
    },
    enabled: val,
    controller: controller,
    validator: validator,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.brown,
    style: TextStyle(color: Colors.black38),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: mPrimaryColor,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black38),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      fillColor: Colors.grey[50],
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            width: 2,
            color: mPrimaryColor,
          )),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
