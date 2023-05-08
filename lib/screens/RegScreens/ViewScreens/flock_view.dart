import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:home_login/screens/RegScreens/flockReg_screen.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/UserRegScreens/signin_screen.dart';
import '../../../Colors.dart';
import '../../../net/flutter_fire.dart';
import 'package:home_login/screens/home_screen.dart';



class FlockScreen extends StatefulWidget {
  final String shedName, branchName, farmName;
  final String branchID;
  final String farmID;
  final String shedID;
  const FlockScreen(this.shedName, this.branchName, this.farmName,
      this.branchID, this.farmID, this.shedID,
      {Key? key})
      : super(key: key);


  @override

  _FlockScreen createState() =>
      _FlockScreen(shedName, branchName, farmName, farmID, branchID, shedID);
}

class _FlockScreen extends State<FlockScreen> {

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String shedName, branchName, farmName;
  String branchID;
  String farmID;
  String shedID;
  _FlockScreen(this.shedName, this.branchName, this.farmName, this.branchID,
      this.farmID, this.shedID);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(shedName + " flocks".tr),
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
                  .where('ShedID', isEqualTo: shedID)
                  .where('BranchID', isEqualTo: branchID)
                  .where('FarmID', isEqualTo: farmID)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    farmNavi: farmID,
                                    branchNavi: branchID,
                                    shedNavi: shedID,
                                    flockNavi: document.id,
                                    farmName: farmName,
                                    branchName: branchName,
                                    shedName: shedName,
                                    flockName: document['FlockName']),
                              ));
                        },
                        child: Padding(
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
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 0, left: 0, right: 0),
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

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            //alignment: Alignment.centerLeft,

                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                RichText(
                                                    text: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                    Icons.text_fields,
                                                    size: 16,
                                                  )),
                                                  TextSpan(
                                                    text:
                                                        " ${document['FlockName']}",
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
                                                    Icons.egg,
                                                    size: 16,
                                                  )),
                                                  TextSpan(
                                                    text:
                                                        " ${document['strain']}    ",
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
                                                    Icons.start,
                                                    size: 16,
                                                  )),
                                                  TextSpan(
                                                    text:
                                                        " ${document['birthDate']}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ])),
                                              ],
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
                                                      child: Icon(
                                                    Icons.numbers,
                                                    size: 16,
                                                  )),
                                                  TextSpan(
                                                    text:
                                                        " ${document['count']}",
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
                                                    Icons.warning,
                                                    size: 16,
                                                  )),
                                                  TextSpan(
                                                    text:
                                                        " ${document['Mortal']}",
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
                                                    size: 16,
                                                  )),
                                                  TextSpan(
                                                    text:
                                                        " ${document['startdays']}",
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


                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [


                                            GestureDetector(
                                              onTap: () {

                                                openDialog dialog = openDialog(id: document.id, flock_name: document['FlockName'],
                                                 starting_date: document['startdays'], birth_date: document['birthDate'], strain_type: document['strain'], num_of_chicks: document['count']);
                                                showDialog(context: context, builder: (BuildContext context) => dialog);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.file_open,
                                                color: Colors.white,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                openDialogDelete(document.id,
                                                    document['FlockName']);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ))),
                          ),
                        ));
                  }).toList(),
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
                  return FlockRegScreen(shedID, branchID, farmID);
                },
              ),
            );
          },
          child: Container(

            alignment: Alignment.center,
            width: double.infinity,
            height: 20,
            child: Text(
              "Add New Farm",
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


  Future openDialogDelete(String id, String flockName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Want to delete".tr + flockName + " flock details?".tr),
          actions: [
            TextButton(
                onPressed: () async {
                  // delete function here
                  removeFlock(id);
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
}

////////////// 2023/3 update ////////////
class openDialog extends StatefulWidget {

  final String id;
  final String flock_name;
  final String starting_date;
  final String birth_date;
  final String strain_type;
  final String num_of_chicks;




  const openDialog({Key? key, required this.id, required this.flock_name, required this.starting_date, required this.birth_date, required this.strain_type, required this.num_of_chicks}) : super(key: key);

  @override
  State<openDialog> createState() => _openDialogState();
}

class _openDialogState extends State<openDialog> {

  List<String> items = [
    'Cobb 500 - Broiler',
    'Ross 308 - Broiler',
    'Dekalb White - Layer',
    'Shaver Brown - Layer'
  ];
  String? selectedItem;

  bool _flockNameChecked = false;
  bool _sdateChecked = false;
  bool _bdateChecked = false;
  bool _strainChecked = false;
  bool _chickCountChecked = false;
  TextEditingController _flockNameController = TextEditingController();
  TextEditingController _sdateController = TextEditingController();
  TextEditingController _bdateController = TextEditingController();
  TextEditingController _strainController = TextEditingController();
  TextEditingController _chickCountController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Farm Details",
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
                Checkbox(value: _flockNameChecked,
                    onChanged: (value){
                      setState(() {
                        _flockNameChecked = value!;
                      });
                    },


                  activeColor: mPrimaryColor,
                    ),
                Expanded(child: TextField(
                  controller: _flockNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Flock Name",
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
                Checkbox(value: _bdateChecked,
                    onChanged: (value){
                      setState(() {
                        _bdateChecked = value!;
                      });
                    },
                  activeColor: mPrimaryColor,
                    ),
                Expanded(child: TextField(
                  controller: _sdateController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Birth Date",
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
                Checkbox(value: _strainChecked,
                          onChanged: (value){
                            setState(() {
                              _strainChecked = value!;
                            });
                          },
                  activeColor: mPrimaryColor,
                          ),

                Expanded(
                    child: DropdownButtonFormField<String>(

                      value: selectedItem,
                      hint: Text('Select The Strain'),
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
                Checkbox(value: _chickCountChecked,
                    onChanged: (value){
                      setState(() {
                        _chickCountChecked = value!;
                      });
                    },
                activeColor: mPrimaryColor,
                ),
                Expanded(child: TextField(
                  controller: _chickCountController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Chick Count",
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
            if (_flockNameChecked && _flockNameController.text.isNotEmpty) {
              await updateFlockName(widget.id, _flockNameController.text);
              _flockNameController.clear();
            }
            if (_sdateChecked && _sdateController.text.isNotEmpty) {
              await updatesDay(widget.id, _sdateController.text);
              _sdateController.clear();
            }
            if (_bdateChecked && _bdateController.text.isNotEmpty) {
              await updatebDay(widget.id, _bdateController.text);
              _bdateController.clear();
            }
            if (_strainChecked && selectedItem!.isNotEmpty) {
              await updateStrain(widget.id, selectedItem! );

            }
            if (_chickCountChecked && _chickCountController.text.isNotEmpty) {
              await updateCount(widget.id, _chickCountController.text);
              _chickCountController.clear();
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
