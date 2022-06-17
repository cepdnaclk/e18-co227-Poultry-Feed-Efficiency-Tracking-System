import 'package:flutter/material.dart';




class GridDashboard extends StatefulWidget {
  


  const GridDashboard({Key? key}) : super(key: key);

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  Items item1 = Items(
       
       title: "FCR",
       img:  "assets/icons/FCR2.png",
       routeName:'/FCR',
      

  );

   Items item2 = Items(
    title: "Feed intake",
    img: "assets/icons/feed2.png",
    routeName:'/feed',
 
  );

  Items item3 = Items(
    title: "Farm Registration",
    img: "assets/icons/reg.png",
    routeName:'/farm',
   



  );

  Items item4 = Items(
    title: "Mortality",
    img: "assets/icons/mortality2.png",
    routeName:'/mortal',
    

  );
/*
  Items item5 = Items(
    title: "To do",
    img: "assets/icons/todo.png",
    routeName:'/todo',
  
  );

  Items item6 = Items(
    title: "Settings",
    img: "assets/icons/setting.png",
    routeName:'/set',
   

  );

 */
  




  @override
  Widget build(BuildContext context) {

    List<Items> mylist = [item1,item2,item3,item4];
    //var color = 0xff453658;
    var color = 0xffd16fb2;
    
    return Flexible(

      child: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.only(left: 16,right: 16),
        childAspectRatio: 1.0,
        crossAxisSpacing: 18,
        mainAxisSpacing: 30,
        children: mylist.map((data) {

          return InkWell(

             onTap: (){
              Navigator.pushNamed(context, data.routeName);
             },


            child: Container(
              decoration: BoxDecoration(color: Color(color),borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: <Widget>[
                  Image.asset(data.img,width: 130,),
                  const SizedBox(
                    height: 14,
          
                  ),
                  Text(data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
          
                    ),
                  ),
                 
                 const SizedBox(height: 8,),
               
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


        }).toList()


        
        ),

     

    );
    
  }
}

class Items{

  late String title;
  late String img;
  late String routeName;
  
  
  Items({required this.title,required this.img,required this.routeName});
  



   
}