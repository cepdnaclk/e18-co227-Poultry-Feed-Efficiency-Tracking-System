import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_login/Colors.dart';
import 'package:get/get.dart';
import '../drawerMenu.dart';
import 'package:sizer/sizer.dart';

class DeleteEggScreen extends StatefulWidget {
  final String id_flock;
  final String startDateNavi;
  final String strainNavi;


  const DeleteEggScreen({Key? key, required this.id_flock, required this.startDateNavi, required this.strainNavi}) : super(key: key);

  @override
  State<DeleteEggScreen> createState() => _DeleteEggScreenState();
}

class _DeleteEggScreenState extends State<DeleteEggScreen> with TickerProviderStateMixin {
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
            return Container();

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
                title: Text("Delete Eggs".tr
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
                              child: CircularProgressIndicator(),
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
                                              //Text(selectedDate);
                                              print(selectedWeek);
                                            });
                                          }),
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
                                                SizedBox(height: 15),
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
                                                SizedBox(height: 15),
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
                                                SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Recorded first Grade Egg Weight",
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
                                                SizedBox(height: 15),
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
                          await deleteEggAmount(widget.id_flock, selectedWeek);
                          _firstEggs.clear();
                          _secondEggs.clear();
                          setState(() {});

                          ///displayFCRdialog();
                          Fluttertoast.showToast(
                              msg: 'Successfully Deleted!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: mNewColor3,
                              textColor: mPrimaryColor);
                        },

                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(180, 50), backgroundColor: mPrimaryColor,
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
                        child: Text("Delete"),
                      ),
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
  Future<void> deleteEggAmount(String id, String week) async {
    //num current = 0;
    //num value = double.parse(amount);
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
          //print("done 1 befre");
          //documentReference.set({'Average_Weight': value});
          //print("done 1");

          //return true;
        } else {
          try {

            transaction.delete(documentReference);

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
          //documentReference2.update({'Avg_BodyWeight': value});
          print("done 2");
          //print(value);
          //return true;
        } else {
          try {
            print("done 2.2 before");
            //num n = snapshot2.data()!['Avg_BodyWeight'];
            //num newAmount = value;
            print("done 2.2 before 2");
            // transaction2
            //     .update(documentReference2, {'Avg_BodyWeight': newAmount});
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