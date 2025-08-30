

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';
import 'package:riverpadstate/revierpad/futureproviders.dart';
import 'package:riverpadstate/revierpad/loginprovider.dart';

class Expencescreens extends ConsumerWidget {
   Expencescreens({super.key});

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider =  ref.watch(studentproviders);
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Center(
          child:Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Expanded(child:
                  provider.when(
                    skipLoadingOnRefresh: false,
                      data: (scope){
                        return ListView.builder(itemCount: provider.value!.length,
                        itemBuilder: (context,index){
                          final user = provider.value![index];
                          return Dismissible(
                            key:ValueKey(user.id.toString()),
                            child: Card(
                              color: AppColors.textfieldlightmode,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.buttonlightmode,
                                  child: Text(user.id.toString(),style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 23),),
                                ),
                                title: Text(user.name.toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "bold"),),
                                subtitle: Text(user.email.toString(),style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "bold"),),
                              ),
                            ),
                          );
                        },);
                      },
                      error: (error,stack)=>Center(child: Text(error.toString(),style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 20),),),
                      loading: ()=>Center(child: CircularProgressIndicator(color: Colors.white,),)
                  )
              )
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.invalidate(studentproviders);
        },
      child: Icon(Icons.refresh),),
    );
  }
}






// children: [
//            provider.when(
//                   data: (scope){
//                     return Expanded(child: ListView.builder(itemCount: provider.value?.data!.length,
//                    itemBuilder: (context,index){
//                       final user = provider.value!.data![index];
//                       return Card(
//                         color: AppColors.textfieldlightmode,
//                         child:ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(user.avatar.toString()),
//                           ),
//                           title: Text("${user.firstName}${user.lastName}",style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 20),),
//                           subtitle: Text(user.email.toString(),style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "bold"),),
//                         ) ,
//                       );
//                    },) );
//                   },
//                   error: (error,stack)=>Center(child: Text(error.toString(),style: TextStyle(fontSize: 20,fontFamily: "bold"),)),
//                   loading: ()=>Center(child: CircularProgressIndicator(color: Colors.white,))
//               )
//             ],























// Form(
//             key: formkey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   controller: emailcontroller,
//                   validator: (valu){
//                     if(valu == null || valu.isEmpty){
//                       return "Please enter email";
//                     }
//                     return null;
//                   },
//                   onChanged: (value)=>ref.read(loginproviders.notifier).addemail(value),
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(),
//                     label: Text("Email",style: TextStyle(color: Colors.white),)
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 TextFormField(
//                   validator: (valu){
//                     if(valu == null || valu.isEmpty){
//                       return "Please enter password";
//                     }
//                     return null;
//                   },
//                   controller: passwordcontroller,
//                   onChanged: (value)=>ref.read(loginproviders.notifier).addpassword(value),
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       enabledBorder: OutlineInputBorder(),
//                       label: Text("password",style: TextStyle(color: Colors.white),)
//                   ),
//                 ),
//                 SizedBox(height: 30,),
//
//                 ElevatedButton(
//                     onPressed: (){
//                       if(formkey.currentState!.validate()){
//                         ref.read(loginproviders.notifier).loginuser();
//                         // ref.read(loginproviders.notifier).resetstates();
//                         emailcontroller.clear();
//                         passwordcontroller.clear();
//                       }
//                     },
//                     child: Consumer(builder: (context,ref,child){
//                       final userdataa = ref.watch(loginproviders);
//                       switch(userdataa.accountStates){
//                         case AccountStates.loading:
//                          return CircularProgressIndicator(color: Colors.white,);
//                         case AccountStates.success:
//                         case AccountStates.failure:
//                         case AccountStates.initial:
//                          return Text("login",style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold"),);
//                       }
//                     })),
//
//                 SizedBox(height: 30,),
//                 Consumer(builder: (context,ref,child){
//                   final userdataa = ref.watch(loginproviders);
//                   return Card(
//                       color: AppColors.textfieldlightmode,
//                       child: Padding(padding: EdgeInsets.all(10),
//                   child: Text(userdataa.token,style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 20),),));
//                 }
//                 )
//               ],
//             ),
//           ),