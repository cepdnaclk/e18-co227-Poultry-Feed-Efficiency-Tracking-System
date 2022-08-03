import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_login/constants.dart';
import 'package:sizer/sizer.dart';

class FCRManualScreen extends StatefulWidget {
  final String totalChicksNavi;
  final int mortalNavi;
  final String strainNavi;

  //const FCRManualScreen({Key? key}) : super(key: key);
  FCRManualScreen({
    Key? key,
    required this.totalChicksNavi,
    required this.mortalNavi,
    required this.strainNavi,
  }) : super(key: key);

  @override
  State<FCRManualScreen> createState() => _FCRManualScreenState();
}

class _FCRManualScreenState extends State<FCRManualScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int startCount = 0, mortal = 0;
  num avgWeight = 0, noBag = 0, avgBagWeight = 0, avgEggs = 0;
  String text = '', unit = '';

<<<<<<< HEAD
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

  final TextEditingController _avgEggWeightController = TextEditingController();
=======
  final TextEditingController _avgWeightController = TextEditingController();
>>>>>>> 2ab7fb82a3aa48aca97b0bbe113771059f0ee0dd
  final TextEditingController _numberofBagController = TextEditingController();
  final TextEditingController _bagWeightController = TextEditingController();
  // final TextEditingController _avgeggController = TextEditingController();
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    if (widget.strainNavi == "Dekalb White - Layer" ||
        widget.strainNavi == "Shaver Brown - Layer") {
      text = "Totla number of eggs per a flock";
      unit = " ";
    } else {
      text = "Avg. weight of a chick";
      unit = "g";
    }
    return Stack(
      children: [
        //DrawerMenu(),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          transform: Matrix4.translationValues(translateX, translateY, 0)
            ..scale(scale),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ClipRRect(
              borderRadius: (toggle)
                  ? BorderRadius.circular(20)
                  : BorderRadius.circular(0),
              child: Form(
                key: formKey,
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
                      },
                      //icon: Icon(Icons.menu),
                    ),
                    title: Text("FCR CALCULATION Manually"),
                    backgroundColor: mPrimaryColor,
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //reuseTextField("Mortality"),
                      SizedBox(
                        height: 30.0,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 10.0),
                        child:
                            reuseTextField(text, _avgEggWeightController, unit),
=======
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text("FCRCalculation".tr),
            backgroundColor: mPrimaryColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),

                //reuseTextField("Mortality"),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 10.0),
                  child: reuseTextField(
                      "avgWeightofChick".tr, _avgWeightController, "g"),
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 15.0),
                        child: reuseTextField(
                            "no_bags".tr, _numberofBagController, ""),
>>>>>>> 2ab7fb82a3aa48aca97b0bbe113771059f0ee0dd
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 15.0),
                        child: reuseTextField(
                            "bag_weight".tr, _bagWeightController, "kg"),
                      ),
<<<<<<< HEAD
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() ||
                                widget.strainNavi == "Dekalb White - Layer" ||
                                widget.strainNavi == "Shaver Brown - Layer") {
                              startCount = int.parse(widget.totalChicksNavi);
                              mortal = widget.mortalNavi;
                              avgEggs = num.parse(_avgEggWeightController.text);
                              noBag = num.parse(_numberofBagController.text);
                              avgBagWeight =
                                  num.parse(_bagWeightController.text);
                              // print(startCount);
                              // print(_avgWeightController.text);
                              // print(_bagWeightController.text);
                              // print(_numberofBagController.text);
                              displayEggFCRdialog(startCount, mortal, avgEggs,
                                  noBag, avgBagWeight);
                            } else {
                              startCount = int.parse(widget.totalChicksNavi);
                              mortal = widget.mortalNavi;
                              avgWeight =
                                  num.parse(_avgEggWeightController.text);
                              noBag = num.parse(_numberofBagController.text);
                              avgBagWeight =
                                  num.parse(_bagWeightController.text);
                              // print(startCount);
                              // print(_avgWeightController.text);
                              // print(_bagWeightController.text);
                              // print(_numberofBagController.text);
                              displayWeightFCRdialog(startCount, mortal,
                                  avgWeight, noBag, avgBagWeight);
                            }
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
                          child: Text("Calculate"),
                        ),
                      ),
                    ],
=======
                    ),
                  ],
                ),

                SizedBox(
                  height: 3.h,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/1234.png",
                    fit: BoxFit.fitHeight,
                    width: 100.w,
                    // height: 420,
                    //color: Colors.purple,
>>>>>>> 2ab7fb82a3aa48aca97b0bbe113771059f0ee0dd
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'startcount'.tr,
                      style: TextStyle(
                          color: mPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        startCount.toString(),
                        style: TextStyle(
                            color: mNewColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'totalMoartal'.tr,
                      style: TextStyle(
                          color: mPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        mortal.toString(),
                        style: TextStyle(
                            color: mNewColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'totallive'.tr,
                      style: TextStyle(
                          color: mPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        (startCount - mortal).toString(),
                        style: TextStyle(
                            color: mNewColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "totalfeedweight".tr,
                      style: TextStyle(
                          color: mPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        (noBag * avgBagWeight).toString() + " kg",
                        style: TextStyle(
                            color: mNewColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 6.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: mNewColor2,
                        width: 5.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      "FCR = " +
                          (noBag *
                                  avgBagWeight *
                                  1000 /
                                  ((startCount - mortal) * avgWeight))
                              .toStringAsFixed(4),
                      style: TextStyle(
                          color: mNewColor,
                          fontSize: 4.h,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          startCount = int.parse(widget.totalChicksNavi);
                          mortal = widget.mortalNavi;
                          avgWeight = num.parse(_avgWeightController.text);
                          noBag = num.parse(_numberofBagController.text);
                          avgBagWeight = num.parse(_bagWeightController.text);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: mPrimaryColor,
                      elevation: 20,
                      shadowColor: mSecondColor,
                      textStyle: TextStyle(
                        fontSize: 3.5.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text("calculate".tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // String? validText(String? formText) {
  //   if (formText!.isEmpty) {
  //     return "Field is Empty";
  //   }
  //   return null;
  // }

  void displayWeightFCRdialog(
      int start, int mortal, num avgWeight, num noBag, num avgBagWeight) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            backgroundColor: mBackgroundColor,
            title: const Text(
              "Current FCR",
              textAlign: TextAlign.center,
            ),
            content: Text("Starting Count: " +
                start.toString() +
                "\nTotal Mortality: " +
                mortal.toString() +
                "\nTotal Chicks Live: " +
                (start - mortal).toString() +
                "\nTotal Weight of Feed: " +
                (noBag * avgBagWeight).toString() +
                " kg" +
                "\n\nFCR = " +
                (noBag * avgBagWeight / ((start - mortal) * avgWeight))
                    .toStringAsFixed(3)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _avgEggWeightController.clear();
                  _numberofBagController.clear();
                  _bagWeightController.clear();
                },
                child: Text("Close"),
              ),
            ],
            //child: ListView.separated(
            //shrinkWrap: true,
          );
        });
  }

  void displayEggFCRdialog(
      int start, int mortal, num avgEggs, num noBag, num avgBagWeight) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            backgroundColor: mBackgroundColor,
            title: const Text(
              "Current FCR",
              textAlign: TextAlign.center,
            ),
            content: Text("Starting Count: " +
                start.toString() +
                "\nTotal Mortality: " +
                mortal.toString() +
                "\nTotal Chicks Live: " +
                (start - mortal).toString() +
                "\nTotal Weight of Feed: " +
                (noBag * avgBagWeight).toString() +
                " kg" +
                "\n\nFCR = " +
                (noBag * avgBagWeight / ((start - mortal) * avgEggs))
                    .toStringAsFixed(3)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _avgEggWeightController.clear();
                  _numberofBagController.clear();
                  _bagWeightController.clear();
                },
                child: Text("Close"),
              ),
            ],
            //child: ListView.separated(
            //shrinkWrap: true,
          );
        });
  }
}

TextFormField reuseTextField(
    String text, TextEditingController controller, String unit) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return "This field is required";
      }
    },
    decoration: InputDecoration(
      suffixText: unit,
      labelText: text,
      labelStyle: TextStyle(color: Colors.black38),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            width: 2.0,
            color: mPrimaryColor,
          )),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
    ),
  );
}
