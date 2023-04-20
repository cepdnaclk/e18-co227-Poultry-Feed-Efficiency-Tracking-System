import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import '../drawerMenu.dart';
import 'package:sizer/sizer.dart';

class AddEggScreen extends StatefulWidget {
  final String id_flock;
  final String startDateNavi;
  final String strainNavi;
  const AddEggScreen({Key? key, required this.id_flock, required this.startDateNavi, required this.strainNavi}) : super(key: key);

  @override
  State<AddEggScreen> createState() => _AddEggScreenState();
}

class _AddEggScreenState extends State<AddEggScreen> with TickerProviderStateMixin {
  DateTime date =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);


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
                title: Text("Add Weekly Egg Data".tr
                  ,style: TextStyle(fontSize: 22),
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



                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Select the Week",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: mPrimaryTextColor,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 1.h),
                            child: Column(
                              children: [
                                Text(
                                  '<<<<Swipe>>>>',
                                  style: TextStyle(
                                    color: mNewColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Container(
                                  height: 7.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.h),
                                    border: Border.all(
                                      color: mPrimaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: NumberPicker(
                                      value: _currentValue,
                                      minValue: 0,
                                      maxValue: 1000,
                                      axis: Axis.horizontal,
                                      itemHeight: 4.h,
                                      itemWidth: 5.h,
                                      selectedTextStyle: TextStyle(
                                        color: mPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                      textStyle: TextStyle(
                                        color: mPrimaryColor.withOpacity(0.5),
                                      ),
                                      onChanged: (value) =>
                                          setState(() => _currentValue = value),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 20.0),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Enter Number of first grade eggs".tr,
                          Icons.numbers, false, _firstEggs, null, ""),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, ),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Enter Number of Second grade eggs".tr,
                          Icons.numbers, false, _secondEggs, null, ""),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 20),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Avg. Weight of First Grade Egg".tr,
                          Icons.monitor_weight, false, _firstEggWeight, null, ""),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Avg. Weight of Second Grade Egg".tr,
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
                            "Selected Week to add",
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
                            "Average Weight of first grade Egg",
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
                            "Average Weight of second grade Egg",
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



                    SizedBox(
                      height: 50,
                    )
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