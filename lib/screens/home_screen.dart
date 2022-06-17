

import 'package:flutter/material.dart';

import 'griddashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(




      //backgroundColor: const Color(0xff392850),
      backgroundColor: Colors.white,
      body: Column(
        children:<Widget> [

          const SizedBox(height: 110,),
          Padding(

            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget> [
                    Text(
                      "Shamil khan",
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,


                      ),
                    ),

                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),




                  ],
                ),
                /*
                IconButton(

                  icon: Image.asset("assets/notification.png",width: 24,),
                  alignment: Alignment.topCenter,
                  onPressed: (){},
                ),
                */
              ],
            ),
          ),

          const SizedBox(

            height: 40,

          ),

          const GridDashboard()

        ],
      ),
    );
  }
}
