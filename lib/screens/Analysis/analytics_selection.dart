import 'package:flutter/material.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:sizer/sizer.dart';
import '../drawerMenu.dart';
import 'compare_active.dart';
import 'compare_ideal.dart';

class AnalyticsSelection extends StatefulWidget {
  const AnalyticsSelection({Key? key}) : super(key: key);

  @override
  State<AnalyticsSelection> createState() => _AnalyticsSelectionState();
}

class _AnalyticsSelectionState extends State<AnalyticsSelection> with TickerProviderStateMixin {
  List weightDataCobb500 = [];
  String startDate = '';
  String strainType = '';

  DateTime date =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);



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
    return Stack(
      children: [
        DrawerMenu(args.flockID),
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
                  title: Text("Analytics Selection",
                      style: TextStyle(fontSize: 22),
                  ),


                  backgroundColor: mPrimaryColor,


                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [

                      SizedBox(
                        height: 18.h,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/CompareChik2.png",
                          fit: BoxFit.fitWidth,
                          width: 50.w,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompareIdeal(id_flock: args.flockID,

                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50), backgroundColor: mPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text("Compare with Ideal Strain",
                            style: TextStyle(fontSize: 20),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            print(args.flockID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompareActive(id_flock: args.flockID,

                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50), backgroundColor: mBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide(color: mPrimaryColor),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(
                            "Compare with Active Batch",
                            style: TextStyle(
                              color: mPrimaryColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


}




