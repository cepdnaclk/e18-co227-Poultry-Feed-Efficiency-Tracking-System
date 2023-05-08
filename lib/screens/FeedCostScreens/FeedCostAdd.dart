import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../Colors.dart';
import '../reusable.dart';

class FeedCostAddScreen extends StatefulWidget {

  late String id_flock;

   FeedCostAddScreen(   {Key? key, required this.id_flock}) : super(key: key);

  @override
  State<FeedCostAddScreen> createState() => _FeedCostAddScreenState();
}

class _FeedCostAddScreenState extends State<FeedCostAddScreen> {

  List<String> items = [
    'starter',
    'grower',
    'finisher',
    'other'
  ];
  String? selectedItem;
  DateTime sdate =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime bdate =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime now = DateTime.now();




  final TextEditingController _WeightController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        //key: formKey,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).size.height * 0.1,
                  20,
                  MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: <Widget>[
                  Text(
                    "Add Feed Data",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: mPrimaryColor),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    "assets/icons/shedNew.jpg",
                    fit: BoxFit.fitWidth,
                    width: 300,
                    height: 300,
                    //color: Colors.purple,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  reusableTextField("Enter Brand of Feed", Icons.house, false,
                      _brandController, null),
                  const SizedBox(
                    height: 20,
                  ),


                  reusableTextField("Enter Weight of a Bag (kg)", Icons.house, false,
                      _WeightController, null),
                  const SizedBox(
                    height: 20,
                  ),

                  reusableTextField2("Enter the number of Bags",
                      Icons.numbers, false, _numberController, null, ""),
                  const SizedBox(
                    height: 20,
                  ),


                  reusableTextField2("Enter the Price of Bag",
                      Icons.numbers, false, _priceController, null, ""),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.egg,
                          color: mPrimaryColor,
                        ),
                        labelText: 'Select the Feed Type',
                        labelStyle:
                        TextStyle(color: Colors.black38, fontSize: 2.5.h),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.h),
                            borderSide: BorderSide(
                              width: 2,
                              color: mPrimaryColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.h),
                          borderSide:
                          BorderSide(width: 2.0, color: mPrimaryColor),
                        )),
                    value: selectedItem,
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,
                          style: TextStyle(
                              color: Colors.black38, fontSize: 2.5.h)),
                    ))
                        .toList(),
                    onChanged: (item) => setState(() => selectedItem = item),
                  ),
                  Row(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 15.0),
                          child: reusableTextField3(
                              sdate.toString().substring(0, 10),
                              Icons.date_range,
                              false,
                              _startDateController,
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
                                initialDate: sdate,
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
                                          foregroundColor: mPrimaryColor, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (ndate == null) return;
                              setState(() => sdate = ndate);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(180, 50), backgroundColor: mBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                    width: 2.0,
                                    color: mPrimaryColor,
                                  )),
                              elevation: 20,
                              shadowColor: Colors.transparent,
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text(
                              "Set The Start Date".tr,
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  // Row(
                  //   //mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 6.0, vertical: 15.0),
                  //         child: reusableTextField3(
                  //             bdate.toString().substring(0, 10),
                  //             Icons.date_range,
                  //             false,
                  //             _birthDateController,
                  //             null,
                  //             false),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 6.0, vertical: 15.0),
                  //         child: ElevatedButton(
                  //           onPressed: () async {
                  //             DateTime? ndate = await showDatePicker(
                  //               context: context,
                  //               initialDate: bdate,
                  //               firstDate: DateTime(2022),
                  //               lastDate: DateTime.now(),
                  //               builder: (context, child) {
                  //                 return Theme(
                  //                   data: Theme.of(context).copyWith(
                  //                     colorScheme: ColorScheme.light(
                  //                       primary: mNewColor,
                  //                       onPrimary: Colors.white, // <-- SEE HERE
                  //                       onSurface: mSecondColor, // <-- SEE HERE
                  //                     ),
                  //                     textButtonTheme: TextButtonThemeData(
                  //                       style: TextButton.styleFrom(
                  //                         primary:
                  //                         mPrimaryColor, // button text color
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   child: child!,
                  //                 );
                  //               },
                  //             );
                  //             if (ndate == null) return;
                  //             setState(() => bdate = ndate);
                  //           },
                  //           style: ElevatedButton.styleFrom(
                  //             fixedSize: const Size(180, 50), backgroundColor: mBackgroundColor,
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(30.0),
                  //                 side: BorderSide(
                  //                   width: 2.0,
                  //                   color: mPrimaryColor,
                  //                 )),
                  //             elevation: 20,
                  //             shadowColor: Colors.transparent,
                  //             textStyle: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           child: Text(
                  //             "Set The Birth Date".tr,
                  //             style: TextStyle(color: Colors.black38),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        await addFeedCostData(
                             widget.id_flock,
                            _WeightController.text,
                             sdate.toString(),
                             selectedItem.toString(),
                            _numberController.text,
                            _priceController.text,
                            _brandController.text,
                            DateFormat('yyyy-MM-dd – kk:mm').format(now).toString()
                        //late String shedID, branchID, farmID;

                        );
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Submit".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }
                            return mPrimaryColor;
                          }),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(30)))),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
}



Future<void> addFeedCostData(String id,String _numcontrollerBagWeight,
     String date,String type,String _numcontrollerBags, String _numcontrollerPrice, String brand, String key ) async {

  num valueBags = double.parse(_numcontrollerBags);
  num valueBagWeight = double.parse(_numcontrollerBagWeight);
  num valueBagPrice = double.parse(_numcontrollerPrice);


  try {

    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance
        .collection('Farmers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('flock')
        .doc(id)
        .collection('FeedCost')
        .doc(key);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await transaction.get(documentReference);

      if (!snapshot.exists) {

        documentReference.set(
            { 'Bags': valueBags.toString(),
              'Weight': valueBagWeight.toString(),
              'Price': valueBagPrice.toString(),
              'type': type,
              'sdate' : date.substring(0,10),
              'Brand' : brand

            });

      } else {
        try {

          transaction.update(documentReference, {
            'Bags': valueBags,
            'Weight': valueBagWeight,
            'Price': valueBagPrice,
            'type': type,
            'sdate' : date.substring(0,10),
            'Brand' : brand
          });

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
      num feedCost = valueBags *  valueBagPrice;
      print(feedCost);
      DocumentReference<Map<String, dynamic>> documentReference2 =
          FirebaseFirestore.instance
              .collection('Farmers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('flock')
              .doc(id)
              .collection('FeedPrice')
              .doc('main');

      FirebaseFirestore.instance.runTransaction((transaction2) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot2 =
            await transaction2.get(documentReference2);

        if (!snapshot2.exists) {

          documentReference2.set({'feed_Cost': feedCost.toString()});

        } else {
          try {

            String n = snapshot2.data()!['feed_Cost'];
            num newAmount = double.parse(n) + feedCost;

            transaction2
                .update(documentReference2, {'feed_Cost': newAmount.toString()});

          } catch (e) {
            //rethrow;
          }
        }
      });
  } catch (e) {
    //
  }
}