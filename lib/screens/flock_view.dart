import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:home_login/screens/flock_view.dart';
import 'package:home_login/screens/RegScreens/flockReg_screen.dart';
import 'package:home_login/screens/branch_view.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/signin_screen.dart';
import 'package:sizer/sizer.dart';
import '../constants.dart';
import '../net/flutter_fire.dart';
import 'package:home_login/screens/home_screen.dart';

/* class FlockScreen extends StatelessWidget{//StatefulWidget {
  //const BranchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(
          child: Text("Welcome to the Shed View Screen")
      )
    );
  }
} */

class FlockScreen extends StatefulWidget {
  final String shedName, branchName, farmName;
  final String branchID;
  final String farmID;
  final String shedID;
  const FlockScreen(this.shedName, this.branchName, this.farmName,
      this.branchID, this.farmID, this.shedID,
      {Key? key})
      : super(key: key);
  //const ShedScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _FlockScreen createState() =>
      _FlockScreen(shedName, branchName, farmName, farmID, branchID, shedID);
}

class _FlockScreen extends State<FlockScreen> {
  List<String> items = [
    'Cobb 500 - Broiler',
    'Ross 308 - Broiler',
    'Dekalb White - Layer',
    'Shaver Brown - Layer'
  ];
  String? selectedItem;
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String shedName, branchName, farmName;
  String branchID;
  String farmID;
  String shedID;
  _FlockScreen(this.shedName, this.branchName, this.farmName, this.branchID,
      this.farmID, this.shedID);
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _strainController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(shedName + " flocks".tr),
          backgroundColor: mPrimaryColor,
          //foregroundColor: Colors.amber,
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
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 25.0, right: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
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
                                          MediaQuery.of(context).size.height /
                                              12,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14.5),
                                        color: mSecondColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(),
                                          /*Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: ElevatedButton.icon(
                                              onPressed: () async {
                                                //print("elevated");
                                                await openDialog(document.id,
                                                    document['ShedName']);
                                              },
                                              icon: const Icon(Icons.edit),
                                              label: const Text("Edit"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: mNewColor),
                                            ),
                                          ),*/

                                          Text(
                                            " ${document['FlockName']}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          PopupMenuButton<int>(
                                              itemBuilder: (context) => [
                                                    // popupmenu item 1
                                                    PopupMenuItem(
                                                      value: 1,
                                                      // row has two child icon and text.
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.edit),
                                                          SizedBox(
                                                            // sized box with width 10
                                                            width: 10,
                                                          ),
                                                          Text("Edit Name".tr)
                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 2,
                                                      // row has two child icon and text.
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.edit),
                                                          SizedBox(
                                                            // sized box with width 10
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "Edit Starting Date"
                                                                  .tr)
                                                        ],
                                                      ),
                                                    ),

                                                    PopupMenuItem(
                                                      value: 3,
                                                      // row has two child icon and text.
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.edit),
                                                          SizedBox(
                                                            // sized box with width 10
                                                            width: 10,
                                                          ),
                                                          Text("Edit Birth Date"
                                                              .tr)
                                                        ],
                                                      ),
                                                    ),
                                                    /*PopupMenuItem(
                                                      value: 4,
                                                      // row has two child icon and text.
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.edit),
                                                          SizedBox(
                                                            // sized box with width 10
                                                            width: 10,
                                                          ),
                                                          Text("Edit Type".tr)
                                                        ],
                                                      ),
                                                    ),*/
                                                    PopupMenuItem(
                                                      value: 4,
                                                      // row has two child icon and text.
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.edit),
                                                          SizedBox(
                                                            // sized box with width 10
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "Edit Strain Type"
                                                                  .tr)
                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 5,
                                                      // row has two child icon and text.
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.edit),
                                                          SizedBox(
                                                            // sized box with width 10
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "Edit The Number Of Chickens"
                                                                  .tr)
                                                        ],
                                                      ),
                                                    ),
                                                    // popupmenu item 2
                                                    PopupMenuItem(
                                                      value: 6,
                                                      // row has two child icon and text
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.delete),
                                                          SizedBox(
                                                            // sized box with width 10
                                                            width: 10,
                                                          ),
                                                          Text("Delete".tr)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                              offset: Offset(-20, 15),
                                              color: mNewColor,
                                              elevation: 2,
                                              onSelected: (value) async {
                                                if (value == 1) {
                                                  openDialog(document.id,
                                                      document['FlockName']);
                                                } else if (value == 2) {
                                                  /*sdayUpdate(document.id,
                                                      document['startdays']);*/
                                                  var dateTime =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: date,
                                                    firstDate: DateTime(2022),
                                                    lastDate: DateTime.now(),
                                                  );
                                                  DateTime? newDate = dateTime;
                                                  if (newDate == null) return;
                                                  setState(
                                                      () => date = newDate);
                                                  updatesDay(
                                                      document.id,
                                                      date
                                                          .toString()
                                                          .substring(0, 10));
                                                } else if (value == 3) {
                                                  /*bdayUpdate(document.id,
                                                      document['birthDate']);*/
                                                  var dateTime =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: date,
                                                    firstDate: DateTime(2022),
                                                    lastDate: DateTime.now(),
                                                  );
                                                  DateTime? newDate = dateTime;
                                                  if (newDate == null) return;
                                                  setState(
                                                      () => date = newDate);
                                                  updatebDay(
                                                      document.id,
                                                      date
                                                          .toString()
                                                          .substring(0, 10));
                                                } /*else if (value == 4) {
                                                  typeUpdate(document.id,
                                                      document['type']);
                                                } */
                                                else if (value == 4) {
                                                  strainUpdate(document.id,
                                                      document['strain']);
                                                } else if (value == 5) {
                                                  countUpdate(document.id,
                                                      document['count']);
                                                } else if (value == 6) {
                                                  openDialogDelete(document.id,
                                                      document['FlockName']);
                                                }
                                              }),
                                          /*IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: mNewColor,
                                            ),
                                            alignment: Alignment.centerRight,
                                            onPressed: () async {
                                              //print("Delete Shed Dialog Box");
                                              await openDialogDelete(
                                                  document.id,
                                                  document['ShedName']);
                                            },
                                          ),*/
                                        ],
                                      ))),
                            )));
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlockRegScreen(shedID, branchID, farmID),
            ),
          );
        },
        backgroundColor: mNewColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future openDialog(String id, String flockName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Flock Name".tr),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: flockName),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updateFlockName(id, _controller.text);
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text("Change".tr))
          ],
        ),
      );

  Future sdayUpdate(String id, String sDay) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Starting Date".tr),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: sDay),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updatesDay(id, _controller.text);
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text("Change".tr))
          ],
        ),
      );

  Future bdayUpdate(String id, String bDay) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Birth Date".tr),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: bDay),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updatebDay(id, _controller.text);
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text("Change".tr))
          ],
        ),
      );

  Future typeUpdate(String id, String type) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Type".tr),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: type),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updateType(id, _controller.text);
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text("Change".tr))
          ],
        ),
      );

  /*Future strainUpdate(String id, String strain) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Strain Type".tr),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: strain),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updateType(id, _controller.text);
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text("Change".tr))
          ],
        ),
      );*/

  Future strainUpdate(String id, String strain) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Strain Type".tr),
          content: DropdownButtonFormField<String>(
            value: selectedItem = strain,
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
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updateStrain(id, selectedItem.toString());
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text("Change".tr))
          ],
        ),
      );

  Future countUpdate(String id, String count) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit The Number Of Chickens".tr),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: count),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updateType(id, _controller.text);
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text("Change".tr))
          ],
        ),
      );

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
