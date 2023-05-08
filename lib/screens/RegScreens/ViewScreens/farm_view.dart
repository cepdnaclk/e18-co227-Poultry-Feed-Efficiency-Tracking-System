import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/screens/RegScreens/ViewScreens/location_view.dart';
import 'package:home_login/screens/RegScreens/farmReg_screen.dart';
import 'package:home_login/screens/selection_screen.dart';
import 'package:home_login/screens/UserRegScreens/signin_screen.dart';
import '../../../net/flutter_fire.dart';

class FarmView extends StatefulWidget {
  FarmView({Key? key}) : super(key: key);

  @override
  _FarmViewState createState() => _FarmViewState();
}

class _FarmViewState extends State<FarmView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("farm_view_yourFarms".tr),
          backgroundColor: mPrimaryColor,

          // this button is for developing purpose only
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
                            builder: (context) => LocationScreen(document['Name'], document.id),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25),
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
                            padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.5),
                                color: mSecondColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    " ${document['Name']}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                      openDialog dialog = openDialog(id: document.id, location: document["Location"]);
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
                                      openDialogDelete(document.id);
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
                            ),
                          ),
                        ),
                      ),
                    );


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
                  return FarmRegScreen();
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


  Future openDialogDelete(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Want to delete this farm details?"),
          actions: [
            TextButton(
                onPressed: () async {
                  // delete function here
                  removeFarm(id);
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



class openDialog extends StatefulWidget {

  final String id;
  final String location;


  const openDialog({Key? key, required this.id, required this.location}) : super(key: key);

  @override
  State<openDialog> createState() => _openDialogState();
}

class _openDialogState extends State<openDialog> {

  bool _farmNameChecked = false;
  bool _farmIDChecked = false;
  TextEditingController _farmNameController = TextEditingController();
  TextEditingController _farmIDController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Farm Details",
      style: TextStyle(color: mTitleTextColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Add entry and check to change",
            style: TextStyle(color: mPrimaryColor),

          ),
          Row(
            children: [
              Checkbox(value: _farmNameChecked,
                  onChanged: (value){
                     setState(() {
                       _farmNameChecked = value!;
                     });
                  }),
              Expanded(child: TextField(
                controller: _farmNameController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Farm Name",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),



            ],
          ),
          SizedBox(height: 8,),

          Row(
            children: [
              Checkbox(value: _farmIDChecked,
                  onChanged: (value){
                    setState(() {
                      _farmIDChecked = value!;
                    });
                  }),
              Expanded(child: TextField(
                controller: _farmIDController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Farm ID",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              ),

            ],
          ),

        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_farmNameChecked && _farmNameController.text.isNotEmpty) {
              await updateFarmName(widget.id, _farmNameController.text);
              _farmNameController.clear();
            }
            if (_farmIDChecked && _farmIDController.text.isNotEmpty) {
              await updateFarm(widget.id, _farmIDController.text);
              _farmIDController.clear();
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
