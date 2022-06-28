import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:home_login/constants.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, mPrimaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
                backgroundColor: Colors.brown,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              accountName: Text(
                "Your Name",
                style: TextStyle(color: mPrimaryTextColor),
              ),
              accountEmail: Text(
                "email@gmail.com",
                style: TextStyle(color: mPrimaryTextColor),
              ),
            ),
            MenuList(title: "FCR", iconName: Icons.dangerous),
            MenuList(title: "Feed Intake", iconName: Icons.dangerous),
            MenuList(
                title: "Farm Registration", iconName: Icons.app_registration),
            MenuList(title: "Mortality", iconName: Icons.dangerous),
            MenuList(title: "Body Weight", iconName: Icons.dangerous),
            MenuList(title: "View Page", iconName: Icons.view_module),
            MenuList(title: "Language", iconName: Icons.language),
            MenuList(title: "Logout", iconName: Icons.logout),
          ],
        ),
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  final String title;
  final IconData iconName;

  const MenuList({required this.title, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 141, 81, 60),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          iconName,
          color: Colors.white54,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: mSecondTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
