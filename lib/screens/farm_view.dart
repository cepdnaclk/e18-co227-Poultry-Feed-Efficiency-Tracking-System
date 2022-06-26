// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/branch_view.dart';
import 'package:home_login/screens/RegScreens/farmReg_screen.dart';

import '../net/flutter_fire.dart';

class FarmView extends StatefulWidget {
  FarmView({Key? key}) : super(key: key);

  @override
  _FarmViewState createState() => _FarmViewState();
}

class _FarmViewState extends State<FarmView> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Farms'),
        backgroundColor: mPrimaryColor,
        //foregroundColor: Colors.amber,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Farmers')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('Farms')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
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
                                builder: (context) =>
                                    BranchScreen(document.id)),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 25.0, right: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.5),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(5, 10),
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 5),
                              ],
                            ),
                            child: Padding(
                                padding:
                                    EdgeInsets.only(top: 0, left: 0, right: 0),
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.5),
                                      color: mSecondColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        Text(
                                          " ${document.id + " - " + document['Location']}",
                                          style: TextStyle(
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
                                                        Text("Edit")
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
                                                        Text("Delete")
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
                                                    document["Location"]);
                                              } else if (value == 2) {
                                                openDialogDelete(document.id);
                                              }
                                            }),
                                      ],
                                    ))),
                          ),
                        ));
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
              builder: (context) => FarmRegScreen(),
            ),
          );
        },
        backgroundColor: mNewColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future openDialog(String id, String location) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Farm Reg. No."),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: location),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updateFarm(id, _controller.text);
                  _controller.clear();
                  Navigator.of(context).pop();
                },
                child: Text("Change"))
          ],
        ),
      );

  Future openDialogDelete(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Want to delete $id farm details?"),
          actions: [
            TextButton(
                onPressed: () async {
                  // delete function here
                  removeFarm(id);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                "No",
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      );
}
