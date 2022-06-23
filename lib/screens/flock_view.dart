import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
//import 'package:home_login/screens/flock_view.dart';
//import 'package:home_login/screens/RegScreens/shedReg_screen.dart';

import '../net/flutter_fire.dart';

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
  final String shedName;
  const FlockScreen(this.shedName, {Key? key}) : super(key: key);
  //const ShedScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _FlockScreen createState() => _FlockScreen(shedName);


}


class _FlockScreen extends State<FlockScreen> {
  String shedName;
  _FlockScreen(this.shedName);
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.purple[200]),
        title: Text('$shedName Flocks'),
        backgroundColor: const Color.fromARGB(255, 165, 53, 130),
        //foregroundColor: Colors.amber,
      ),
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
                  .collection('Shed').where('shedName',isEqualTo: shedName)
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
                        /* onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlockScreen()),
                          );
                        }, */
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 25.0, right: 25),
                            child: Container(
                                height: MediaQuery.of(context).size.height / 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.5),
                                  color: const Color(0xffd16fb2),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          //print("elevated");
                                          await openDialog(document.id,
                                              document['ShedName']);
                                        },
                                        icon: const Icon(Icons.edit),
                                        label: const Text("Edit"),
                                        style: ElevatedButton.styleFrom(
                                            primary: const Color.fromARGB(
                                                255, 165, 53, 130)),
                                      ),
                                    ),
                                    Text(
                                      " ${document.id}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color:
                                            Color.fromARGB(255, 165, 53, 130),
                                      ),
                                      alignment: Alignment.centerRight,
                                      onPressed: () async {
                                        //print("Delete Shed Dialog Box");
                                        await openDialogDelete(
                                            document.id, document['ShedName']);
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
          /* Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShedRegScreen(shedName),
            ),
          );*/
        }, 
        backgroundColor: const Color.fromARGB(255, 165, 53, 130),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }


  Future openDialog(String id, String shedName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Edit Shed Details"),
          content: TextField(
            //controller: _controller,
            autofocus: true,
            decoration: InputDecoration(hintText: shedName),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //_controller.text = location;
                  await updateFarm(id, _controller.text);
                  _controller.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: const Text("Change"))
          ],
        ),
      );

  Future openDialogDelete(String id, String shedName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Want to delete $id flock details?"),
          actions: [
            TextButton(
                onPressed: () async {
                  // delete function here
                  removeFarm(id);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text(
                "No",
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      );
}
