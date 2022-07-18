import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:get/get.dart';
import 'drawerMenu.dart';
import '../net/flutter_fire.dart';

class EggScreen extends StatefulWidget {
  const EggScreen({Key? key}) : super(key: key);

  @override
  State<EggScreen> createState() => _EggScreenState();
}

class _EggScreenState extends State<EggScreen> with TickerProviderStateMixin {
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final TextEditingController _datecontroller = TextEditingController();
  final TextEditingController _numcontroller = TextEditingController();

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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Stack(children: [
      DrawerMenu(args.flockID),
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
                title: Text("UPDATE NUMBER OF EGGS".tr),
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
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Farmers")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('flock')
                            .doc(args.flockID)
                            .collection('NumberofEggs')
                            .where(FieldPath.documentId,
                                isEqualTo: date.toString().substring(0, 10))
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          num amount = -1;
                          try {
                            amount = snapshot.data?.docs[0]['Amount'];
                          } catch (e) {
                            amount = -1;
                          }
                          if (amount == -1 || amount == 0) {
                            return Center(
                              child: Text(
                                "You haven't recorded number of eggs for " +
                                    date.toString().substring(0, 10),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: mPrimaryTextColor),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                "You have already recorded ${snapshot.data?.docs[0]['Amount']} number of eggs for ${date.toString().substring(0, 10)}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: mPrimaryTextColor),
                              ),
                            );
                          }
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 10.0),
                      //child: reuseTextField1("Number of chicks"),

                      child: reusableTextField2("Enter Number of eggs".tr,
                          Icons.numbers, false, _numcontroller, null),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 15.0),
                            child: reusableTextField3(
                                date.toString().substring(0, 10),
                                Icons.date_range,
                                false,
                                _datecontroller,
                                null,
                                false),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                DateTime? ndate = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: mNewColor,
                                          onPrimary:
                                              Colors.white, // <-- SEE HERE
                                          onSurface:
                                              mSecondColor, // <-- SEE HERE
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary:
                                                mPrimaryColor, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (ndate == null) return;
                                setState(() => date = ndate);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(180, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                      width: 2.0,
                                      color: mPrimaryColor,
                                    )),
                                primary: mBackgroundColor,
                                elevation: 20,
                                shadowColor: Colors.transparent,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Text(
                                "Touch to Pick Date",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/eggs.png",
                        fit: BoxFit.fitWidth,
                        width: context.width * 0.6,
                        // height: 420,
                        //color: Colors.purple,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await addEggs(args.flockID, _numcontroller.text,
                              date.toString().substring(0, 10));
                          _numcontroller.clear();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(180, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: mPrimaryColor,
                          elevation: 20,
                          shadowColor: mSecondColor,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("Update"),
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
}
