import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/view_screen.dart';
import 'package:sizer/sizer.dart';

class UpdateFeedScreen extends StatefulWidget {
  final String id_flock;
  String startDateNavi;
  // const AddBodyWeight({Key? key}) : super(key: key);
  UpdateFeedScreen({
    Key? key,
    required this.id_flock,
    required this.startDateNavi,
  }) : super(key: key);

  @override
  State<UpdateFeedScreen> createState() => _UpdateFeedScreenState();
}

class _UpdateFeedScreenState extends State<UpdateFeedScreen> {
  List<DropdownMenuItem<String>> dateItems = [];
  String selectedDate = "";
  num recordedNo_Bag = 0;
  num recordedBag_weight = 0;

  //DateTime date =
  //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final TextEditingController _datecontroller = TextEditingController();
  final TextEditingController _numcontrollerBags = TextEditingController();
  final TextEditingController _numcontrollerBagWeight = TextEditingController();

  late StreamBuilder _widget;

  @override
  void initState() {
    selectedDate = widget.startDateNavi;

    _widget = StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Farmers")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('flock')
            .doc(widget.id_flock)
            .collection('FeedIntake')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              DocumentSnapshot snap = snapshot.data!.docs[i];

              double amount = -1;
              String date;
              try {
                // amount =
                //     snapshot.data?.docs[i]['Average_Weight'];
                date = snapshot.data!.docs[i].id;
                //print(date);

                //print(snapshot.data!.docs[i].id);

                //print(amount);
                //print("----------------------");
                //print('');
                //weightDataCurrent.add(PoultryData(i, amount));
                //dateItems.add(date);
                dateItems.add(
                  DropdownMenuItem(
                    child: Text(
                      date,
                      style: TextStyle(color: mPrimaryColor),
                    ),

                    //value: "${snap.id}",
                    value: "$date",
                  ),
                );

                // print(date);

                //print(dateItems);
                //amount = 0.0;
                //print(dateItems);
              } catch (e) {
                //amount = -1;
              }
            }
            //print(dateItems);
            return Container();
            print(dateItems);
          }
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "updatefeedIntake".tr,
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: mPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _widget,
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(widget.id_flock)
                      .collection('FeedIntake')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      //print(dateItems);
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Container(
                                height: 25,
                                width: 40.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: mPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: DropdownButton(
                                    alignment: Alignment.center,
                                    hint: new Text(
                                      'selectDate'.tr,
                                      style: TextStyle(
                                        color: mPrimaryColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    items: dateItems.toSet().toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedDate = newValue
                                            .toString()
                                            .substring(0, 10);
                                        //Text(selectedDate);
                                        print(selectedDate);
                                      });
                                    }),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "    " + "selectedDate".tr,
                                  style: TextStyle(
                                      fontSize: 16, color: mPrimaryColor),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: mPrimaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    "${selectedDate}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: mPrimaryColor,
                                    ),
                                  ),
                                ),

                                /*TextField(
                                 decoration: InputDecoration(
                                   enabledBorder: OutlineInputBorder(
                                     borderSide: BorderSide(width: 1, color: mPrimaryColor), //<-- SEE HERE
                                   ),
                                   hintText: "$selectedDate" ,
                                 ),
                               )
                                */
                              ],
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Farmers")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('flock')
                                    .doc(widget.id_flock)
                                    .collection('FeedIntake')
                                    .where(FieldPath.documentId,
                                        isEqualTo: selectedDate
                                            .toString()
                                            .substring(0, 10))
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  num amount = -1;
                                  num amount2 = -1;
                                  try {
                                    amount = snapshot.data?.docs[0]
                                        ['Number_of_bags'];
                                    amount2 = snapshot.data?.docs[0]
                                        ['Weight_of_a_bag'];
                                    recordedNo_Bag = amount;
                                    recordedBag_weight = amount2;
                                    //print(amount);
                                  } catch (e) {
                                    amount = -1;
                                  }
                                  if (amount == -1 || amount == 0) {
                                    return Center(
                                        // child: Text(
                                        //   "You haven't recorded average weight for " +
                                        //       date
                                        //           .toString()
                                        //           .substring(0, 10),
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(
                                        //       fontSize: 20,
                                        //       color: mPrimaryTextColor),
                                        // ),
                                        );
                                  } else {
                                    return Container(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "    " + "recordedBags".tr,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: mPrimaryColor),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 25,
                                                width: 30.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: mPrimaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Text(
                                                  "${recordedNo_Bag}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: mPrimaryColor),
                                                ),
                                              ),

                                              /*TextField(
                                 decoration: InputDecoration(
                                   enabledBorder: OutlineInputBorder(
                                     borderSide: BorderSide(width: 1, color: mPrimaryColor), //<-- SEE HERE
                                   ),
                                   hintText: "$selectedDate" ,
                                 ),
                               )
                                */
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "    " + "recordedBagWeight".tr,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: mPrimaryColor),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 25,
                                                width: 30.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: mPrimaryColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Text(
                                                  "${recordedBag_weight}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: mPrimaryColor),
                                                ),
                                              ),

                                              /*TextField(
                                 decoration: InputDecoration(
                                   enabledBorder: OutlineInputBorder(
                                     borderSide: BorderSide(width: 1, color: mPrimaryColor), //<-- SEE HERE
                                   ),
                                   hintText: "$selectedDate" ,
                                 ),
                               )
                                */
                                            ],
                                          )
                                        ],
                                      ),

                                      // child: Text(
                                      //   "You have already recorded ${snapshot.data?.docs[0]['Average_Weight']} average weight for ${date.toString().substring(0, 10)}",
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //       fontSize: 20,
                                      //       color: mPrimaryTextColor),
                                      // ),
                                    );
                                  }
                                }),

                            /*
                           Row(
                             children: [
                               Text("Selected Date"),
                               TextField(
                                 decoration: InputDecoration(
                                   border: OutlineInputBorder(),
                                   hintText: "$selectedDate" ,
                                 ),
                               ),
                             ],
                           )
                           */
                          ],
                        ),
                      );
                      print(dateItems);
                    }
                  }),

              SizedBox(
                height: 20.0,
              ),

              //reuseTextField("Mortality"),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
                //child: reuseTextField1("Number of chicks"),

                child: reusableTextField2("noofBags".tr, Icons.numbers, false,
                    _numcontrollerBags, null),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
                //child: reuseTextField1("Number of chicks"),

                child: reusableTextField2("bagWeight".tr, Icons.numbers, false,
                    _numcontrollerBagWeight, null),
              ),

              SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  "assets/images/feed-new.png",
                  fit: BoxFit.fitWidth,
                  width: context.width * 0.4,
                  // height: 420,
                  //color: Colors.purple,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // print(args.flockID);
                    // print(_numcontroller.text);
                    // print(date);
                    await updateFeedIntake(
                        widget.id_flock,
                        _numcontrollerBags.text,
                        _numcontrollerBagWeight.text,
                        selectedDate.toString().substring(0, 10));
                    _numcontrollerBags.clear();
                    _numcontrollerBagWeight.clear();
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
                  child: Text("update".tr),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
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

class PoultryData {
  final double amount;
  final int day;

  PoultryData(this.day, this.amount);
}
