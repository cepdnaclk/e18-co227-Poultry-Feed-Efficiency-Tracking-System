// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:home_login/screens/branch_view.dart';
import 'package:home_login/screens/farmReg_screen.dart';

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
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.purple[200]),
        title: const Text('Your Farms'),
        backgroundColor: Color.fromARGB(255, 165, 53, 130),
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
                                builder: (context) => BranchScreen()),
                          );
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, left: 25.0, right: 25),
                            child: Container(
                                height: MediaQuery.of(context).size.height / 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.5),
                                  color: Color(0xffd16fb2),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          //print("elevated");
                                          await openDialog(document.id,
                                              document['Location']);
                                        },
                                        icon: Icon(Icons.edit),
                                        label: Text("Edit"),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 165, 53, 130)),
                                      ),
                                    ),
                                    Text(
                                      " ${document.id + " - " + document['Location']}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color:
                                            Color.fromARGB(255, 165, 53, 130),
                                      ),
                                      alignment: Alignment.centerRight,
                                      onPressed: () async {
                                        print("Test");
                                        await openDialogDelete(
                                            document.id, document['Location']);
                                      },
                                    ),
                                  ],
                                ))));
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
        backgroundColor: Color.fromARGB(255, 165, 53, 130),
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
          title: Text("Edit Farm Details"),
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

  Future openDialogDelete(String id, String location) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Want to delete " + id + " farm details?"),
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
