

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';
import 'package:riverpadstate/views/homescreens/homescreens.dart';
import 'package:riverpadstate/views/homescreens/profilescreens.dart';
import 'package:riverpadstate/views/homescreens/settingscreens.dart';
import 'package:riverpadstate/views/moodscreens/expencescreens.dart';
import 'package:riverpadstate/views/moodscreens/moodscreens.dart';
import 'package:riverpadstate/views/moodscreens/todoscreens.dart';

class Navscreens extends StatefulWidget {
  const Navscreens({super.key});

  @override
  State<Navscreens> createState() => _NavscreensState();
}

class _NavscreensState extends State<Navscreens> {
  var index = 1;
  List<Widget>screens = [
    Expencescreens(),
    Moodscreens(),
    Todoscreens()
    // Settingscreens(),
    // Homescreens(),
    // Profilescreens()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(CupertinoIcons.rectangle_expand_vertical),
          Icon(Icons.home),
          Icon(Icons.person),
        ],
        color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.scaffolddarkmode
        : AppColors.textfieldlightmode,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.scaffolddarkmode
            : AppColors.scaffoldlightmode,
        index: index,
        onTap: (value)=>setState(() {index = value;}),
      ),
      body: IndexedStack(
        index: index,children: screens,
      ),
    );
  }
}
