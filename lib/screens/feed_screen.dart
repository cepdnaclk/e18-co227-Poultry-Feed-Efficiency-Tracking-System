import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/BodyWeightScreen/addBody.dart';
import 'package:home_login/screens/BodyWeightScreen/deleteBody.dart';
import 'package:home_login/screens/BodyWeightScreen/updateBody.dart';
import 'package:home_login/screens/FeedIntakeScreens/addFeed.dart';
import 'package:home_login/screens/FeedIntakeScreens/deleteFeed.dart';
import 'package:home_login/screens/FeedIntakeScreens/updateFeed.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/view_screen.dart';
import 'package:sizer/sizer.dart';
import 'drawerMenu.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with TickerProviderStateMixin {
  List weightDataCobb500 = [];
  String startDate = '';
  String strainType = '';

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

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
                  title: Text("feedIntakeSelect".tr),
                  backgroundColor: mPrimaryColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
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
                              strainType = snapshot.data?.docs[0]['strain'];
                              //print(startDate);
                              updateFeedIntake(args.flockID, 0.4.toString(),
                                  50.toString(), startDate);

                              //print(mortal);
                              //print(totalChick);
                            }

                            return Container(); // Your grid code.
                          }),
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/feed-new.png",
                          fit: BoxFit.fitWidth,
                          width: context.width * 0.5,
                          // height: 420,
                          //color: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateFeedScreen(
                                  id_flock: args.flockID,
                                  startDateNavi: startDate,
                                  strainNavi: strainType,
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
                          onPressed: () {
                            print(args.flockID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddFeedScreen(
                                  id_flock: args.flockID,
                                  startDateNavi: startDate,
                                  strainNavi: strainType,
                                ),
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
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeleteFeedScreen(
                                  id_flock: args.flockID,
                                  startDateNavi: startDate,
                                  strainNavi: strainType,
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
        ),
      ],
    );
  }

  Future<void> updateFeedIntake(
      String id, String noOfBag, String weightBag, String date) async {
    num current = 0;
    num valueBags = double.parse(noOfBag);
    num valueBagWeight = double.parse(weightBag);

    try {
      //print("try 1");
      DocumentReference<Map<String, dynamic>> documentReference =
          FirebaseFirestore.instance
              .collection('Farmers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('flock')
              .doc(id)
              .collection('FeedIntake')
              .doc(date);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await transaction.get(documentReference);

        if (!snapshot.exists) {
          //print("done 1 befre");
          documentReference.set(
              {'Number_of_bags': valueBags, 'Weight_of_a_bag': valueBagWeight});
          //print("done 1");

          //return true;
        } else {
          try {
            //num newAmount = snapshot.data()!['Amount'] + value;
            //  current = snapshot.data()!['Amount'];
            transaction.update(documentReference, {
              'Number_of_bags': valueBags,
              'Weight_of_a_bag': valueBagWeight
            });
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
      /*  DocumentReference<Map<String, dynamic>> documentReference2 =
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
            num n = snapshot2.data()!['Avg_BodyWeight'];
            num newAmount = n - current + value;
            print("done 2.2 before 2");
            transaction2
                .update(documentReference2, {'Avg_BodyWeight': newAmount});
            print("done 2.2");
            //return true;
          } catch (e) {
            //rethrow;
          }
        }
      });*/
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
