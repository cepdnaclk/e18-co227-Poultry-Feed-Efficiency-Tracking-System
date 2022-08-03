import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/view_screen.dart';
import 'package:home_login/screens/strain.dart' as strainList;
import 'package:sizer/sizer.dart';

class AddBodyWeight extends StatefulWidget {
  final String id_flock;
  final String startDateNavi;
  final String strainNavi;
  // const AddBodyWeight({Key? key}) : super(key: key);
  AddBodyWeight({
    Key? key,
    required this.id_flock,
    required this.startDateNavi,
    required this.strainNavi,
  }) : super(key: key);

  @override
  State<AddBodyWeight> createState() => _AddBodyWeightState();
}

class _AddBodyWeightState extends State<AddBodyWeight> {
  //List weightDataCobb500 = [];
  List<strainList.PoultryData> weightDataStrain = [];
  List<strainList.PoultryData> feedtDataStrain = [];

  late DateTime startDate;
  int days = 0;
  int index = 0;

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final TextEditingController _datecontroller = TextEditingController();
  final TextEditingController _numcontroller = TextEditingController();

  //List<strainList.PoultryData> _list = strainList.PoultryData.feedDataCobb500;
  @override
  void initState() {
    startDate = DateTime.parse(widget.startDateNavi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    days = date.difference(startDate).inDays;
    //print(_list[13].valueOf(13));
    if (widget.strainNavi == 'Cobb 500 - Broiler') {
      weightDataStrain = strainList.PoultryData.weightDataCobb500;
      feedtDataStrain = strainList.PoultryData.feedDataCobb500;
    } else if (widget.strainNavi == 'Ross 308 - Broiler') {
      weightDataStrain = strainList.PoultryData.weightDataRoss308;
      feedtDataStrain = strainList.PoultryData.feedDataRoss308;
    } else if (widget.strainNavi == 'Dekalb White - Layer') {
      weightDataStrain = strainList.PoultryData.weightDataDekalbWhite;
      feedtDataStrain = strainList.PoultryData.feedDataDekalbWhite;
    } else if (widget.strainNavi == 'Shaver Brown - Layer') {
      weightDataStrain = strainList.PoultryData.weightDataShaverBrown;
      feedtDataStrain = strainList.PoultryData.feedDataShavorBrown;
    }
    //print(_list[days].valueOf(days));

    // strainList.PoultryData chick = weightDataCobb500[20];

    // print(chick);
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "addBodyWeight".tr,
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
                      .collection('BodyWeight')
                      .where(FieldPath.documentId,
                          isEqualTo: date.toString().substring(0, 10))
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    num amount = -1;
                    try {
                      amount = snapshot.data?.docs[0]['Average_Weight'];
                    } catch (e) {
                      amount = -1;
                    }
                    if (amount == -1 || amount == 0) {
                      return SizedBox(
                        height: 30.0,
                        // child: Text(
                        //   "You haven't recorded average weight for " +
                        //       date.toString().substring(0, 10),
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       fontSize: 20, color: mPrimaryTextColor),
                        // ),
                      );
                    } else {
                      return SizedBox(
                        height: 30.0,
                        // child: Text(
                        //   "You have already recorded ${snapshot.data?.docs[0]['Average_Weight']} average weight for ${date.toString().substring(0, 10)}",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       fontSize: 20, color: mPrimaryTextColor),
                        // ),
                      );
                    }
                  }),
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
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: mSecondColor, // <-- SEE HERE
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
                          if (ndate.difference(startDate).inDays < 0) return;
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

              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 5.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: mPrimaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Days: " + days.toString(),
                    style: TextStyle(fontSize: 18, color: mNewColor),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "   Ideal " + widget.strainNavi + " avg weight",
                    style: TextStyle(fontSize: 15, color: mPrimaryColor),
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
                      weightDataStrain[days].valueOf(days).toString() + " g",
                      style: TextStyle(fontSize: 17, color: mNewColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "   Start Date",
                    style: TextStyle(fontSize: 15, color: mPrimaryColor),
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
                      widget.startDateNavi,
                      style: TextStyle(fontSize: 17, color: mNewColor),
                    ),
                  ),
                ],
              ),
              // Text("Expected feed intake: " +
              //     weightDataStrain[index].valueOf(days).toString()),

              //reuseTextField("Mortality"),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
                //child: reuseTextField1("Number of chicks"),

                child: reusableTextField2("avgWeightofChick".tr, Icons.numbers,
                    false, _numcontroller, null, "g"),
              ),

              SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset(
                  "assets/images/weight.png",
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
                    await addBodyWeight(widget.id_flock, _numcontroller.text,
                        date.toString().substring(0, 10));
                    _numcontroller.clear();
                    setState(() {});
                    //Navigator.of(context).pop();

                    ///displayFCRdialog();
                    Fluttertoast.showToast(
                        msg: 'Successfully Added!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: mNewColor3,
                        textColor: mPrimaryColor);
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
                  child: Text("add".tr),
                ),
              ),
            ],
          ),
        ),
      ),
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
