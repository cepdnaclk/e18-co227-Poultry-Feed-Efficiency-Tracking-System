import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

class GridDashboard extends StatefulWidget {
  final String flockID;
  static const routeMortal = '/mortal';
  static const routeWeight = '/weight';
  static const routeFeed = '/feed';
  static const routeView = '/view';
  static const routeFCR = '/FCR';
  const GridDashboard(this.flockID, {Key? key}) : super(key: key);

  @override
  State<GridDashboard> createState() => _GridDashboardState(flockID);
}

class _GridDashboardState extends State<GridDashboard> {
  String flockID;

  _GridDashboardState(this.flockID);
  Items item1 = Items(
    title: "FCR",
    img: "assets/images/feeding.png",
    routeName: '/FCR',
  );

  Items item2 = Items(
    title: "feedintake".tr,
    img: "assets/images/feed.png",
    routeName: '/feed',
  );

  Items item3 = Items(
    title: "farmreg".tr,
    img: "assets/images/reg.png",
    routeName: '/farm',
  );

  Items item4 = Items(
    title: "mortality".tr,
    img: "assets/images/dead.png",
    routeName: '/mortal',
  );

  Items item5 = Items(
    title: "body_weight".tr,
    img: "assets/images/weight.png",
    routeName: '/weight',
  );

  Items item6 = Items(
    title: "view".tr,
    img: "assets/images/view.png",
    routeName: '/view',
  );

  Items item7 = Items(
    title: "Monitor Eggs",
    img: "assets/images/eggs.png",
    routeName: '/eggs',
  );

  @override
  Widget build(BuildContext context) {
    String strain;
    List<Items> mylist;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Farmers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('flock')
            .where(FieldPath.documentId, isEqualTo: flockID)
            .snapshots(), // your stream url,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            //print(snapshot.toString());
            strain = snapshot.data?.docs[0]['strain'];
            // print(strain);
            if (strain == "Dekalb White - Layer" ||
                strain == "Shaver Brown - Layer") {
              mylist = [item1, item2, item3, item4, item5, item7, item6];
              print("Layer Detected");
            } else {
              mylist = [item1, item2, item3, item4, item5, item6];
              print("Not a layer");
            }
          }

          //var color = 0xff453658;
          var color = 0xffd16fb2;

          return Flexible(
            child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.only(left: 16, right: 16),
                childAspectRatio: 1.0,
                crossAxisSpacing: 18,
                mainAxisSpacing: 30,
                children: mylist.map((data) {
                  return InkWell(
                    onTap: () {
                      //if (data.routeName != '/FCR') {
                      Navigator.pushNamed(context, data.routeName,
                          arguments: ScreenArguments(flockID));
                      // } else {
                      //   popupDialog(context, data.routeName);
                      // }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(5, 10),
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.asset(
                              data.img,
                              //width: 130,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            data.title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          /* Text(data.subtitle,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    fontWeight: FontWeight.w600
          
                    ),
                  ),
          
                  const SizedBox(height: 14,),
                   Text(data.event,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600
          
                    ),
                  ),
           */
                        ],
                      ),
                    ),
                  );
                }).toList()),
          ); // Your grid code.
        });
  }

  void popupDialog(BuildContext context, String routename) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text("Checking for Update".tr),
          content: Text("Do you have updated the Mortality".tr),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No".tr)),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, routename);
                },
                child: Text("Yes".tr))
          ],
          //child: ListView.separated(
          //shrinkWrap: true,
        );
      },
    );
  }
}

class Items {
  late String title;
  late String img;
  late String routeName;

  Items({
    required this.title,
    required this.img,
    required this.routeName,
  });
}

class ScreenArguments {
  final String flockID;

  ScreenArguments(this.flockID);
}
