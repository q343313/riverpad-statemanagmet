

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpadstate/config/services/splashservices.dart';


class Splashscreens extends StatefulWidget {
  const Splashscreens({super.key});

  @override
  State<Splashscreens> createState() => _SplashscreensState();
}

class _SplashscreensState extends State<Splashscreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashServices.change_screen(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/riv.png"),width: 300,),
            SizedBox(height: 20,),

          ],
        ),
      ),
      floatingActionButton: Text("Splash Screens",style: TextStyle(fontFamily: "bold",fontSize: 25),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
