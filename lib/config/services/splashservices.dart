


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpadstate/views/homescreens/navscreens.dart';

class SplashServices{
  static change_screen(BuildContext context){
    Timer.periodic(Duration(seconds: 4), (_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Navscreens()));
    });
  }
}