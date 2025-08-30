


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:riverpadstate/revierpad/fullriverpad.dart';

class UserController extends GetxController{

  RxList userdata = [].obs;
  RxList favoreitelist = [].obs;

  final usernamecontroller = TextEditingController().obs;

  adduservalur(){
    userdata.add(usernamecontroller.value.text);
    usernamecontroller.value.clear();
  }

  addfavoriteuser(String value){
   if(favoreitelist.contains(value)){
     favoreitelist.remove(value);
   }else{
     favoreitelist.add(value);
   }
  }



}