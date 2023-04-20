import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:get/get.dart';
import '../drawerMenu.dart';
import 'package:sizer/sizer.dart';

class UpdateEggScreen extends StatefulWidget {
  final String id_flock;
  final String startDateNavi;
  final String strainNavi;


  const UpdateEggScreen({Key? key, required this.id_flock, required this.startDateNavi, required this.strainNavi}) : super(key: key);

  @override
  State<UpdateEggScreen> createState() => _UpdateEggScreenState();
}

class _UpdateEggScreenState extends State<UpdateEggScreen> with TickerProviderStateMixin {
  DateTime date =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);

  String selectedWeek = "1";
  List<DropdownMenuItem<String>> dateItems = [];

  late num recordedFirstEggs;
  late num recordedSecondEggs;
  late num recordedFirstEggWeight;
  late num recordedSecondEggWeight;

  final TextEditingController _firstEggs = TextEditingController();
  final TextEditingController _secondEggs = TextEditingController();
  final TextEditingController _firstEggWeight = TextEditingController();
  final TextEditingController _secondEggWeight = TextEditingController();

  int _currentValue = 3;

  double translateX = 0.0;
  double translateY = 0.0;
  double scale = 1;
  bool toggle = false;
  late AnimationController _animationController;

  late StreamBuilder _widget;

  @override
  void initState() {

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );



    _widget = StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Farmers")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('flock')
            .doc(widget.id_flock)
            .collection('NumberofEggs')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //dateItems = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {


              String date;
              try {

                date = snapshot.data!.docs[i].id;

                dateItems.add(
                  DropdownMenuItem(
                    child: Text(
                      date,
                      style: TextStyle(color: mPrimaryColor),
                    ),


                    value: "$date",
                  ),
                );

                print(dateItems[0].value);

              } catch (e) {
                //amount = -1;
              }
            }
            //print(dateItems);
            return Container(
              height: 0,
            );

          }
        });




    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Stack(children: [
      DrawerMenu(widget.id_flock),
      AnimatedContainer(
        duration: Duration(milliseconds: 500),
        transform: Matrix4.translationValues(translateX, translateY, 0)
          ..scale(scale),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ClipRRect(
            borderRadius:
            (toggle) ? BorderRadius.circular(20) : BorderRadius.circular(0),
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
                    }),
                title: Text("Update Weekly Egg Details".tr
                    ,style: TextStyle(fontSize: 22),
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
                            .collection('NumberofEggs')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                
                                
                              ),
                            );
                          } else {
                            //print(dateItems);
                            return Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
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
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                            alignment: Alignment.center,
                                            hint: new Text(
                                              "Select Week",
                                              style: TextStyle(
                                                color: mPrimaryColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                            items: dateItems.toSet().toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedWeek = newValue.toString();


                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Selected Week",
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
                                            "${selectedWeek}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: mPrimaryColor,
                                            ),
                                          ),
                                        )],
                                    ),
                                  ),

                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("Farmers")
                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                          .collection('flock')
                                          .doc(widget.id_flock)
                                          .collection('NumberofEggs')
                                          .where(FieldPath.documentId,
                                          isEqualTo: selectedWeek)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        num amount = -1;
                                        num amount2 = -1;
                                        num amount3 = -1;
                                        num amount4 = -1;
                                        try {
                                          amount = snapshot.data?.docs[0]
                                          ['First GrEgg'];
                                          amount2 = snapshot.data?.docs[0]
                                          ['Second GrEgg'];
                                          amount3 = snapshot.data?.docs[0]
                                          ['First GRWeight'];
                                          amount4 = snapshot.data?.docs[0]
                                          ['Second GRWeight'];
                                          recordedFirstEggs = amount;
                                          recordedSecondEggs = amount2;
                                          recordedFirstEggWeight = amount3;
                                          recordedSecondEggWeight = amount4;
                                          //print(amount);
                                        } catch (e) {
                                          amount = -1;
                                        }
                                        if (amount == -1 || amount == 0) {
                                          return Center(

                                          );
                                        } else {
                                          return Padding(
                                            padding: EdgeInsets.only(left: 10,right: 10),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                     "Recorded First Grade Eggs",
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
                                                        "${recordedFirstEggs}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: mPrimaryColor),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Recorded First Grade Egg Weight",
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
                                                        "${recordedFirstEggWeight}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: mPrimaryColor),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Recorded Second Grade Eggs",
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
                                                        "${recordedSecondEggs}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: mPrimaryColor),
                                                      ),
                                                    ),

                                                  ],
                                                ),

                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Recorded Second Grade Egg Weight",
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
                                                        "${recordedSecondEggWeight}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: mPrimaryColor),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }),

                                ],
                              ),
                            );

                          }
                        }),




                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Enter Number of first grade eggs".tr,
                          Icons.numbers, false, _firstEggs, null, ""),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Enter first grade egg weight".tr,
                          Icons.monitor_weight, false, _firstEggWeight, null, ""),
                    ),


                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Enter Number of Second grade eggs".tr,
                          Icons.numbers, false, _secondEggs, null, ""),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Enter second grade egg weight".tr,
                          Icons.monitor_weight, false, _secondEggWeight, null, ""),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Selected Week for Update",
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
                              _currentValue.toString(),
                              style: TextStyle(fontSize: 17, color: mNewColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Number of first grade Eggs added",
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
                              _firstEggs.text,
                              style: TextStyle(fontSize: 17, color: mNewColor),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Number of second grade Eggs added",
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
                              _secondEggs.text,
                              style: TextStyle(fontSize: 17, color: mNewColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "First grade Egg weight added",
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
                              _firstEggWeight.text,
                              style: TextStyle(fontSize: 17, color: mNewColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Second grade Egg weight added",
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
                              _secondEggWeight.text,
                              style: TextStyle(fontSize: 17, color: mNewColor),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/eggs.png",
                        fit: BoxFit.fitWidth,
                        width: context.width * 0.6,

                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          bool isInputsValid = true;

                          if (_firstEggs.text.isEmpty ||
                              _secondEggs.text.isEmpty ||
                              _currentValue.toString().isEmpty ||
                              _firstEggWeight.text.isEmpty ||
                              _secondEggWeight.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: 'All fields are required!',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: mNewColor3,
                              textColor: mPrimaryColor,
                            );
                            isInputsValid = false;
                          } else {
                            bool firstEggsValid = int.tryParse(_firstEggs.text) != null;
                            bool secondEggsValid = int.tryParse(_secondEggs.text) != null;
                            bool currentValueValid = int.tryParse(_currentValue.toString()) != null;
                            bool firstEggWeightValid = double.tryParse(_firstEggWeight.text) != null;
                            bool secondEggWeightValid = double.tryParse(_secondEggWeight.text) != null;

                            if (!firstEggsValid || !secondEggsValid || !currentValueValid) {
                              Fluttertoast.showToast(
                                msg: 'First 2 fields should be integers!',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: mNewColor3,
                                textColor: mPrimaryColor,
                              );
                              isInputsValid = false;
                            } else if (!firstEggWeightValid || !secondEggWeightValid) {
                              Fluttertoast.showToast(
                                msg: 'Egg weight fields should be numbers!',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: mNewColor3,
                                textColor: mPrimaryColor,
                              );
                              isInputsValid = false;
                            }
                          }

                          if (isInputsValid) {
                            await updateEggs(
                              widget.id_flock,
                              _firstEggs.text,
                              _secondEggs.text,
                              _currentValue.toString(),
                              _firstEggWeight.text,
                              _secondEggWeight.text,
                            );
                            _firstEggs.clear();
                            _secondEggs.clear();
                            _firstEggWeight.clear();
                            _secondEggWeight.clear();
                            setState(() {});

                            Fluttertoast.showToast(
                              msg: 'Successfully Added!',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: mNewColor3,
                              textColor: mPrimaryColor,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(180, 50),
                          backgroundColor: mPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 20,
                          shadowColor: mSecondColor,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("Add"),
                      ),
                    ),
                    // Center(
                    //   child: ElevatedButton(
                    //     onPressed: () async {
                    //       await updateEggs(widget.id_flock, _firstEggs.text,_secondEggs.text,
                    //           _currentValue.toString() );
                    //       _firstEggs.clear();
                    //       _secondEggs.clear();
                    //       setState(() {});
                    //
                    //       ///displayFCRdialog();
                    //       Fluttertoast.showToast(
                    //           msg: 'Successfully Updated!',
                    //           toastLength: Toast.LENGTH_SHORT,
                    //           gravity: ToastGravity.BOTTOM,
                    //           timeInSecForIosWeb: 1,
                    //           backgroundColor: mNewColor3,
                    //           textColor: mPrimaryColor);
                    //     },
                    //
                    //     style: ElevatedButton.styleFrom(
                    //       fixedSize: const Size(180, 50), backgroundColor: mPrimaryColor,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30.0),
                    //       ),
                    //       elevation: 20,
                    //       shadowColor: mSecondColor,
                    //       textStyle: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     child: Text("Update"),
                    //   ),
                    // ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
  Future<void> updateEggs(String id, String firstEgg,String secondEgg, String week,String firstEggWeight,String secondEggWeight) async {
    num curFirstValue = 0;
    num curSecondValue = 0;
    num firstValue = int.parse(firstEgg);
    num secondValue = int.parse(secondEgg);
    num firstWeightValue = double.parse(firstEggWeight);
    num secondWeightValue = double.parse(secondEggWeight);
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
      FirebaseFirestore.instance
          .collection('Farmers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('flock')
          .doc(id)
          .collection('NumberofEggs')
          .doc(week);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await transaction.get(documentReference);
        if (!snapshot.exists) {

          documentReference.set({'First GrEgg': firstValue,
            'Second GrEgg': secondValue,
            'First GRWeight': firstWeightValue,
            'Second GRWeight': secondWeightValue});

        } else {
          try {


            transaction.update(documentReference,{'First GrEgg': firstValue,
              'Second GrEgg': secondValue,
              'First GRWeight': firstWeightValue,
              'Second GRWeight': secondWeightValue});



          } catch (e) {

          }
        }
      });
    } catch (e) {

    }
    try {

      num CumFirstWeightVal= firstValue * firstWeightValue;
      num CumSecondWeightVal= secondValue * secondWeightValue;


      DocumentReference<Map<String, dynamic>> documentReference2 =
      FirebaseFirestore.instance
          .collection('Farmers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('flock')
          .doc(id)
          .collection('EggData')
          .doc('main');


      FirebaseFirestore.instance.runTransaction((transaction2) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot2 =
        await transaction2.get(documentReference2);
        print(documentReference2);
        if (!snapshot2.exists) {

          print('came here');
          documentReference2.set({'Cum Gr1Egg Weight': CumFirstWeightVal,
            'Cum Gr2Egg Weight': CumSecondWeightVal,
          });

        } else {
          try {


            curFirstValue = snapshot2.data()!['Cum Gr1Egg Weight'];
            curSecondValue = snapshot2.data()!['Cum Gr2Egg Weight'];
            num newValue1= CumFirstWeightVal+curFirstValue;
            num newValue2= CumSecondWeightVal+curSecondValue;

            transaction2.update(documentReference2, {'Cum Gr1Egg Weight': newValue1,
              'Cum Gr2Egg Weight': newValue2,
            });

          } catch (e) {

          }
        }
      });
    } catch (e) {
      //
    }
  }

}