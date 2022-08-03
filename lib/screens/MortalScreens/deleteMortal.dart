import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/view_screen.dart';
//import 'drawerMenu.dart';

class DeleteMortal extends StatefulWidget {
  final String id_flock;
  // const DeleteMortal({Key? key}) : super(key: key);
  DeleteMortal({
    Key? key,
    required this.id_flock,
  }) : super(key: key);

  @override
  State<DeleteMortal> createState() => _DeleteMortalState();
}

class _DeleteMortalState extends State<DeleteMortal>
    with TickerProviderStateMixin {
  List weightDataCobb500 = [];

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
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Stack(
      children: [
        //DrawerMenu(args.flockID),
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
                  title: Text(
                    "Delete Mortality".tr,
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: mPrimaryColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Farmers")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('flock')
                              .doc(widget.id_flock)
                              .collection('Mortality')
                              .where(FieldPath.documentId,
                                  isEqualTo: date.toString().substring(0, 10))
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            num amount = -1;
                            try {
                              amount = snapshot.data?.docs[0]['Amount'];
                            } catch (e) {
                              amount = -1;
                            }
                            if (amount == -1 || amount == 0) {
                              return Center(
                                // height: 60.0,
                                child: Text(
                                  "You haven't recorded mortalities for " +
                                      date.toString().substring(0, 10),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: mPrimaryTextColor),
                                ),
                              );
                            } else {
                              return Center(
                                //height: 60.0,
                                child: Text(
                                  "You have already recorded ${snapshot.data?.docs[0]['Amount']} mortalities for ${date.toString().substring(0, 10)}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: mPrimaryTextColor),
                                ),
                              );
                            }
                          }),

                      //reuseTextField("Mortality"),
                      SizedBox(
                        height: 20.0,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 6.0, vertical: 10.0),
                      //   //child: reuseTextField1("Number of chicks"),

                      //   child: reusableTextField2(
                      //       "Enter new Mortality count".tr,
                      //       Icons.numbers,
                      //       false,
                      //       _numcontroller,
                      //       null),
                      // ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 15.0),
                              child: reusableTextField3(
                                  date.toString().substring(0, 10),
                                  Icons.date_range,
                                  false,
                                  _datecontroller,
                                  null,
                                  false),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 15.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  DateTime? ndate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: mNewColor,
                                            onPrimary:
                                                Colors.white, // <-- SEE HERE
                                            onSurface:
                                                mSecondColor, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary:
                                                  mPrimaryColor, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (ndate == null) return;
                                  setState(() => date = ndate);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(180, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                        width: 2.0,
                                        color: mPrimaryColor,
                                      )),
                                  primary: mBackgroundColor,
                                  elevation: 20,
                                  shadowColor: Colors.transparent,
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: Text(
                                  "pickDate".tr,
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/dead.png",
                          fit: BoxFit.fitWidth,
                          width: context.width * 0.4,
                          // height: 420,
                          //color: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            // print(args.flockID);
                            // print(_numcontroller.text);
                            // print(date);

                            // await DeleteMortality(widget.id_flock, "0",
                            //     date.toString().substring(0, 10));
                            // _numcontroller.clear();
                            openDialogDelete(widget.id_flock, "0",
                                date.toString().substring(0, 10));
                            setState(() {});
                            //Navigator.of(context).pop();

                            ///displayFCRdialog();
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

  Future openDialogDelete(String id, String amount, String date) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Want to delete mortalities for ".tr + date),
          actions: [
            TextButton(
                onPressed: () async {
                  // delete function here
                  // removeFarm(id);
                  DeleteMortality(id, amount, date);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Yes".tr,
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                "No".tr,
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      );

  Future<void> DeleteMortality(String id, String amount, String date) async {
    num current = 0;
    num value = int.parse(amount);
    try {
      print("try 1");
      DocumentReference<Map<String, dynamic>> documentReference =
          FirebaseFirestore.instance
              .collection('Farmers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('flock')
              .doc(id)
              .collection('Mortality')
              .doc(date);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await transaction.get(documentReference);

        if (!snapshot.exists) {
          print("done 1 before");
          documentReference.set({'Amount': value});
          print("done 1");

          //return true;
        } else {
          try {
            //num newAmount = snapshot.data()!['Amount'] + value;
            current = snapshot.data()!['Amount'];
            transaction.update(documentReference, {'Amount': value});
            print("done 1.2");
            print(current);
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
      print("try 2");
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
          print("snap 2 noy exist");
          documentReference2.update({'Mortal': value});
          print("done 2");
          print(value);
          //return true;
        } else {
          try {
            print("done 2.2 before");
            num n = snapshot2.data()!['Mortal'];
            num newAmount = n - current;
            print("done 2.2 before 2");
            transaction2.update(documentReference2, {'Mortal': newAmount});
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
