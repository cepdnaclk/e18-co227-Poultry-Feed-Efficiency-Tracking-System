// import 'dart:html';
//import 'package:firebase_autString id, h/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/shed_view.dart';
import 'package:home_login/screens/RegScreens/branchReg_screen.dart';
import 'package:get/get.dart';
import 'package:home_login/screens/signin_screen.dart';

import '../net/flutter_fire.dart';

/* class BranchScreen extends StatelessWidget{//StatefulWidget {
  //const BranchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(
          child: Text("Welcome to the Branch View Screen")
      )
    );
  }
}
 */

class BranchScreen extends StatefulWidget {
  final String farmName;
  const BranchScreen(this.farmName, {Key? key}) : super(key: key);
  //const BranchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _BranchScreen createState() => _BranchScreen(farmName);
}

class _BranchScreen extends State<BranchScreen> {
  String farmName;
  _BranchScreen(this.farmName);
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(farmName + " branches".tr),
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
                  .collection('Branch')
                  .where('FarmName', isEqualTo: farmName)
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
                                builder: (context) => ShedScreen(
                                    document['BranchName'],
                                    farmName,
                                    document.id)),
                            // builder: (context) => ShedScreen(document.id)),
                          );
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
                                //color: mSecondColor,
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
                                                    document['FarmName']);
                                              },
                                              icon: const Icon(Icons.edit),
                                              label: Text("Edit"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: mNewColor),
                                            ),
                                          ),*/
                                          Text(
                                            //" ${document.id}"
                                            " ${document['BranchName']}",
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
                                                          Text("Edit".tr)
                                                        ],
                                                      ),
                                                    ),
                                                    // popupmenu item 2
                                                    PopupMenuItem(
                                                      value: 2,
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
                                                      document['BranchName']);
                                                } else if (value == 2) {
                                                  openDialogDelete(document.id,
                                                      document['BranchName']);
                                                }
                                              }),
                                          /*IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: mNewColor,
                                            ),
                                            alignment: Alignment.centerRight,
                                            onPressed: () async {
                                              //print("Delete Branch Dialog Box");
                                              await openDialogDelete(
                                                  document.id,
                                                  document['FarmName']);
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
              builder: (context) => BranchRegScreen(farmName),
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

  Future openDialog(String id, String branchName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Branch Name".tr),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: branchName),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updateBranch(id, _controller.text);
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text("Change".tr))
          ],
        ),
      );

  Future openDialogDelete(String id, String branchName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Want to delete".tr + branchName + " branch details?".tr),
          actions: [
            TextButton(
                onPressed: () async {
                  // delete function here
                  removeBranch(id);
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
