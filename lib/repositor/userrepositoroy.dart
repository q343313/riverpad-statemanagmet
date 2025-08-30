

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;
import 'package:riverpadstate/models/studentmodel.dart';
import 'package:riverpadstate/models/userapimodel.dart';


class UserRepository{

 String urls = "https://reqres.in/api/users?page=2";

 Future<UserApiModel?>getuserdata()async{

   try {

     final response = await http.get(Uri.parse(urls));

     if (response.statusCode == 200 || response.statusCode == 201){

       final data = jsonDecode(response.body);
       return UserApiModel.fromJson(data);

     }else{
       throw Exception("Status code throw error ${response.statusCode}");
     }

   }on SocketException{
     Get.snackbar("Internet","No internet exceptios");
     throw Exception(" No internet exceptios");
   }on TimeoutException{
     Get.snackbar("Timeout","Request timeout exceptios");
     throw Exception("Request timeout exceptios");
   }catch(e){
     Get.snackbar("Something","Something went wrong");
     throw Exception("Something went wrong");
   }
 }

 Future<List<StudentModel>>getstudentdata()async{

   try {
      String studenturls  = "https://jsonplaceholder.typicode.com/users";
     final response = await http.get(Uri.parse(studenturls));

     if (response.statusCode == 200 || response.statusCode == 201){
        List<StudentModel> studentlist = [];
       final data = jsonDecode(response.body);
       for(Map<String,dynamic> i in data){
         studentlist.add(StudentModel.fromJson(i));
       }
       return studentlist;

     }else{
       throw Exception("Status code throw error ${response.statusCode}");
     }

   }on SocketException{
     Get.snackbar("Internet","No internet exceptios");
     throw Exception(" No internet exceptios");
   }on TimeoutException{
     Get.snackbar("Timeout","Request timeout exceptios");
     throw Exception("Request timeout exceptios");
   }catch(e){
     Get.snackbar("Something","Something went wrong");
     throw Exception("Something went wrong");
   }
 }

 Future loginuseraccount(String email,String password)async{
   try{

     final response = await http.post(Uri.parse("https://reqres.in/api/login"),
         body:jsonEncode({
           "email":email,
           "password":password
         }),
     headers: {
       'Content-Type': 'application/json',
       'x-api-key': 'reqres-free-v1'
     }
     );

     if (response.statusCode == 200 || response.statusCode == 201){

       final data = jsonDecode(response.body);
       Get.snackbar("Token","${data["token"]}");
       return data;

     }else{
       throw Exception("Status code throw error ${response.statusCode}");
     }

   }catch(e){
     Get.snackbar("Something","Something went wrong");
   }
 }

}