import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/screens/IdealStrain.dart' as strainList;
import 'package:intl/intl.dart';


import '../UserRegScreens/signin_screen.dart';
import '../selection_screen.dart';
import 'FeedCostAdd.dart';

class FeedCostView extends StatefulWidget {
  final String id_flock;
  final String startDateNavi;
  final String strainNavi;

  FeedCostView({
    Key? key,
    required this.id_flock,
    required this.startDateNavi,
    required this.strainNavi,
  }) : super(key: key);

  @override
  State<FeedCostView> createState() => _FeedCostViewState();
}

class _FeedCostViewState extends State<FeedCostView> {
  List<strainList.PoultryData> weightDataStrain = [];
  List<strainList.PoultryData> feedtDataStrain = [];

  late DateTime startDate;
  int days = 0;
  int index = 0;

  DateTime date =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);






  @override
  void initState() {
    startDate = DateTime.parse(widget.startDateNavi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Feed Cost View"),
          backgroundColor: mPrimaryColor,

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                builddialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SelectionScreen()));
              },
            ),
          ]),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Farmers')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('flock')
                  .doc(widget.id_flock)
                  .collection('FeedCost')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(mPrimaryColor),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: ListView(
                    children: snapshot.data!.docs.map((document) {


                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.5),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(5, 10),
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 5),
                            ],
                          ),
                          child: Container(
                              height:
                              MediaQuery.of(context).size.height / 12,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(14.5),
                                color: mSecondColor,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left:30, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        //alignment: Alignment.centerLeft,

                                        Padding(
                                          padding: const EdgeInsets.only(right: 80),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              RichText(
                                                  text: TextSpan(children: [
                                                    WidgetSpan(

                                                      child: Image.asset(
                                                        'assets/icons/brand.png',
                                                        width: 20,
                                                        height: 20,
                                                      ),

                                                    ),
                                                    TextSpan(
                                                      text:
                                                      " ${document['Brand']}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  ])),
                                              RichText(
                                                  text: TextSpan(children: [
                                                    WidgetSpan(
                                                      child: Image.asset(
                                                        'assets/icons/bagWeightIcon.png',
                                                        width: 20,
                                                        height: 20,
                                                      ),

                                                    ),
                                                    TextSpan(
                                                      text:
                                                      " ${document['Weight']} kg",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  ])),
                                              RichText(
                                                  text: TextSpan(children: [
                                                    WidgetSpan(
                                                        child: Icon(
                                                          Icons.numbers,
                                                          size: 20,
                                                        )),
                                                    TextSpan(
                                                      text:
                                                      " ${document['Bags']}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  ])),
                                            ],
                                          ),
                                        ),

                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                                  WidgetSpan(

                                                    child: Image.asset(
                                                      'assets/icons/bagPriceIcon.png',
                                                      width: 20,
                                                      height: 20,
                                                    ),

                                                  ),
                                                  TextSpan(
                                                    text:
                                                    " ${document['Price']}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ])),
                                            RichText(
                                                text: TextSpan(children: [

                                                  WidgetSpan(
                                                      child: Icon(
                                                        Icons.text_fields,
                                                        size: 20,
                                                      )),
                                                  TextSpan(
                                                    text:
                                                    " ${document['type']}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ])),
                                            RichText(
                                                text: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                        Icons.app_registration,
                                                        size: 20,
                                                      )),
                                                  TextSpan(
                                                    text:
                                                    " ${document['sdate']}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ])),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),


                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [


                                      GestureDetector(
                                        onTap: () {

                                          openDialog dialog = openDialog(id: widget.id_flock, brand_name: document['Brand'],
                                              bag_weight: document['Weight'], num_bag : document['Bags'], bag_price: document['Price'], start_date: document['sdate'], type:document['type'], keyValue: document.id,);
                                          showDialog(context: context, builder: (BuildContext context) => dialog);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 30,top: 20),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          openDialogDelete(document.id);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 30,top:5,bottom: 20),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              )),
                        ),
                      );

                    }

                    ).toList(),
                  ),
                );
              }),
        ),
      ),
                         
      

      floatingActionButtonLocation: null,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30,bottom: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: mBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: mPrimaryColor),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return FeedCostAddScreen( id_flock: widget.id_flock);
                },
              ),
            );
          },
          child: Container(

            alignment: Alignment.center,
            width: double.infinity,
            height: 20,
            child: Text(
              "Add New Feed Detail",
              style: TextStyle(
                color: mPrimaryColor,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),



    );
  }

  Future openDialogDelete(String id) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Want to delete this feed detail?".tr),
      actions: [
        TextButton(
            onPressed: () async {
              // delete function here
              removeFeedDetail(id);
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

  Future<bool> removeFeedDetail(String id) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('flock')
            .doc(widget.id_flock)
            .collection('FeedCost')
            .doc(id)
            .delete();
        return true;
      } else {
        throw ("This is my first general exception");
      }
    } catch (e) {
      rethrow;
    }
  }

}


////////////// 2023/3 update ////////////
class openDialog extends StatefulWidget {

  final String id;
  final String keyValue;
  final String brand_name;
  final String bag_weight;
  final String num_bag;
  final String bag_price;
  final String start_date;
  final String type;




  const openDialog({Key? key, required this.id, required this.brand_name, required this.bag_weight, required this.num_bag, required this.bag_price, required this.start_date, required this.type, required this.keyValue}) : super(key: key);

  @override
  State<openDialog> createState() => _openDialogState();
}

class _openDialogState extends State<openDialog> {

  List<String> items = [
    'starter',
    'grower',
    'finisher',
    'other'
  ];
  String? selectedItem;

  bool _brandNameChecked = false;
  bool _sdateChecked = false;
  bool _bagWeightChecked = false;
  bool _typeChecked = false;
  bool _numBagChecked = false;
  bool _bagPriceChecked = false;
  TextEditingController _brandNameController = TextEditingController();
  TextEditingController _sdateController = TextEditingController();
  TextEditingController _bagWeightController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _bagpriceController = TextEditingController();
  TextEditingController _numBagController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Feed  Details",
        style: TextStyle(color: mTitleTextColor),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add entry and check to change",
              style: TextStyle(color: mPrimaryColor),

            ),
            Row(
              children: [
                Checkbox(value: _brandNameChecked,
                    onChanged: (value){
                      setState(() {
                        _brandNameChecked = value!;
                      });
                    },
                  activeColor: mPrimaryColor,

                    ),
                Expanded(child: TextField(
                  controller: _brandNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Brand Name",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: mPrimaryColor,
                    ),
                  ),
                ),
                ),


                ),
              ],

            ),
            SizedBox(height: 8,),

            Row(
              children: [
                Checkbox(value: _sdateChecked,
                    onChanged: (value){
                      setState(() {
                        _sdateChecked = value!;
                      });
                    },
                activeColor: mPrimaryColor,
                ),
                Expanded(child: TextField(
                  controller: _sdateController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Start date",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: mPrimaryColor,
                    ),
                  ),
                ),
                ),
                ),
              ],
            ),

            SizedBox(height: 8,),

            Row(
              children: [
                Checkbox(value: _bagWeightChecked,
                    onChanged: (value){
                      setState(() {
                        _bagWeightChecked = value!;
                      });
                    }
                    ,activeColor: mPrimaryColor,
                    ),
                Expanded(child: TextField(
                  controller: _bagWeightController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Bag Weight",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: mPrimaryColor,
                    ),
                  ),
                ),
                ),
                ),
              ],
            ),



            const SizedBox(
              height: 8,
            ),

            Row(
              children: [
                Checkbox(value: _typeChecked,
                    onChanged: (value){
                      setState(() {
                        _typeChecked = value!;
                      });
                    },
                activeColor: mPrimaryColor,
                ),

                Expanded(
                  child: DropdownButtonFormField<String>(

                    value: selectedItem,
                    hint: Text('Select Feed type'),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,
                          style: TextStyle(
                              color: mTitleTextColor, fontSize: 15)),
                    ))
                        .toList(),
                    onChanged: (item) => setState(() => selectedItem = item),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mPrimaryColor),
                      ),
                    ),



                  ),
                ),
              ],
            ),




            SizedBox(height: 8,),

            Row(
              children: [
                Checkbox(value: _numBagChecked,
                    onChanged: (value){
                      setState(() {
                        _numBagChecked = value!;
                      });
                    },
                activeColor: mPrimaryColor,
                ),
                Expanded(child: TextField(
                  controller: _numBagController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Number of Bags",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: mPrimaryColor,
                    ),
                  ),
                ),
                ),
                ),

              ],
            ),

            SizedBox(height: 8,),

            Row(
              children: [
                Checkbox(value: _bagPriceChecked,
                    onChanged: (value){
                      setState(() {
                        _bagPriceChecked = value!;
                      });
                    },
                  activeColor: mPrimaryColor,
                    ),
                Expanded(child: TextField(
                  controller: _bagpriceController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Bag price",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: mPrimaryColor,
                    ),
                  ),
                ),
                ),
                ),
              ],
            ),



          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_brandNameChecked && _brandNameController.text.isNotEmpty) {
              await updateFeedType(widget.id, _brandNameController.text,widget.keyValue);
              _brandNameController.clear();
            }
            if (_sdateChecked && _sdateController.text.isNotEmpty) {
              await updateSdate(widget.id, _sdateController.text,widget.keyValue);
              _sdateController.clear();
            }
            if (_bagWeightChecked && _bagWeightController.text.isNotEmpty) {
              await updateBagWeight(widget.id, _bagWeightController.text,widget.keyValue);
              _bagWeightController.clear();
            }
            if (_typeChecked && selectedItem!.isNotEmpty) {
              await updateFeedType(widget.id, selectedItem! ,widget.keyValue);

            }
            if (_numBagChecked && _numBagController.text.isNotEmpty) {
              await updateNumBags(widget.id, _numBagController.text,widget.keyValue);
              _numBagController.clear();
            }

            if (_bagPriceChecked && _bagpriceController.text.isNotEmpty) {
              await updatePrice(widget.id, _bagpriceController.text,widget.keyValue);
              _bagpriceController.clear();
            }


            //Navigator.of(context).pop();
          },
          child: Text("Change".tr,
            style: TextStyle(color: mNewColor2),
          ),
        ),
      ],
    );
  }
}

Future<bool> updateFeedType(
    String id,
    String typeValue, String keyValue,
    ) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance
        .collection('Farmers')
        .doc(uid)
        .collection('flock')
        .doc(id)
        .collection('FeedCost')
        .doc(keyValue);
    FirebaseFirestore.instance.runTransaction((transaction) async {

      await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'type': typeValue});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updatebrandName(
    String id,
    String branchName, String keyValue,
    ) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance
        .collection('Farmers')
        .doc(uid)
        .collection('flock')
        .doc(id)
        .collection('FeedCost')
        .doc(keyValue);
    FirebaseFirestore.instance.runTransaction((transaction) async {

      await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'Brand': branchName});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateSdate(
    String id,
    String startDateValue, String keyValue,
    ) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance
        .collection('Farmers')
        .doc(uid)
        .collection('flock')
        .doc(id)
        .collection('FeedCost')
        .doc(keyValue);
    FirebaseFirestore.instance.runTransaction((transaction) async {

      await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'sdate': startDateValue});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updatePrice(
    String id,
    String priceValue, String keyValue,
    ) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance
        .collection('Farmers')
        .doc(uid)
        .collection('flock')
        .doc(id)
        .collection('FeedCost')
        .doc(keyValue);
    FirebaseFirestore.instance.runTransaction((transaction) async {

      await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'Price': priceValue});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateNumBags(
    String id,
    String countValue, String keyValue,
    ) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance
        .collection('Farmers')
        .doc(uid)
        .collection('flock')
        .doc(id)
        .collection('FeedCost')
        .doc(keyValue);
    FirebaseFirestore.instance.runTransaction((transaction) async {

      await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'Bags': countValue});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateBagWeight(
    String id,
    String weightValue, String keyValue,
    ) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance
        .collection('Farmers')
        .doc(uid)
        .collection('flock')
        .doc(id)
        .collection('FeedCost')
        .doc(keyValue);
    FirebaseFirestore.instance.runTransaction((transaction) async {

      await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'Weight': weightValue});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}
