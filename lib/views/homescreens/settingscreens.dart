
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';
import 'package:riverpadstate/getx/usercontroller.dart';
import 'package:riverpadstate/revierpad/favoriteriverpad.dart';
import 'package:riverpadstate/views/homescreens/favoritetscrees.dart';



class Settingscreens extends ConsumerWidget {
  const Settingscreens({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    print("Rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpad"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Favoritetscrees()));
          }, icon: Icon(Icons.new_label)),
          Consumer(builder: (context,ref,child){
            final visisibel= ref.watch(favoriteriverpad.select((val)=>val.showvisible));
            return Visibility(
                visible: visisibel,
                child: IconButton(onPressed: (){
                  ref.read(favoriteriverpad.notifier).deletevalues();
                  ref.read(favoriteriverpad.notifier).hidewidget();
                }, icon: Icon(Icons.delete,color: Colors.red,)));
          }),
          SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
            Consumer(builder: (context,ref,child){
              final userlist = ref.watch(favoriteriverpad);
              return Expanded(
                  child:userlist.userdatalist.isEmpty?
                  Center(child: Text("No User Exits",style: TextStyle(fontSize: 23,fontFamily: "bold"),),)
                      : ListView.builder(
                    itemCount: userlist.userdatalist.length,
                    itemBuilder: (context,index){
                      final user = userlist.userdatalist[index];
                      final exists = userlist.favoritelistdata.contains(user);
                      final deleteexists = userlist.deletelist.contains(user);
                      return Dismissible(
                        
                        key: ValueKey(index.toString()),
                        onDismissed: (Dismissed){
                          ref.read(favoriteriverpad.notifier).deletesinglevalue(user);
                        },
                        child: Card(
                          color: AppColors.textfieldlightmode,
                          child: ListTile(
                            onLongPress: (){
                              ref.read(favoriteriverpad.notifier).visiblewidget();
                            },
                            onTap: (){
                              ref.read(favoriteriverpad.notifier).hidewidget();
                            },
                            leading: Visibility(
                              visible: userlist.showvisible,
                              child: Checkbox(
                                value: deleteexists,
                                onChanged: (value){
                                  ref.read(favoriteriverpad.notifier).adddeletevalue(user);
                                }
                            ),),
                            title: Text(user,style: TextStyle(fontFamily: "bold",fontSize: 23,color: Colors.white),),
                            subtitle: Text(""),
                            trailing: IconButton(
                                onPressed: (){
                                  ref.read(favoriteriverpad.notifier).addfavoritevalue(user);
                                }, icon:exists?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border)),
                          ),
                        ),
                      );
                    },
                  ));
            }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addusrdialog(context,ref);
        },
      child: Icon(Icons.add),),
    );
  }
}

Future addusrdialog(BuildContext context,WidgetRef ref){
  final formkey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  return showDialog(context: context,
      builder: (context){
    return Form(
      key: formkey,
      child: AlertDialog(
        backgroundColor: AppColors.textfieldlightmode,
        title:Text("Add User",style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: "bold"),),
        content: TextFormField(
          controller: controller,
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please enter value";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            label: Text("Username"),
            prefixIcon: Icon(Icons.account_circle)
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);

          }, child: Text("cancel",style: TextStyle(color: Colors.blue,fontFamily: "bold",fontSize: 23),)),
          TextButton(onPressed: (){
            if(formkey.currentState!.validate()){
              ref.read(favoriteriverpad.notifier).adduservalue(controller.text);
              Navigator.pop(context);
            }

          }, child: Text("Add",style: TextStyle(color: Colors.blue,fontFamily: "bold",fontSize: 23),))
        ],
      ),
    );
      });
}










// class Settingscreens extends StatefulWidget {
//    Settingscreens({super.key});
//
//   @override
//   State<Settingscreens> createState() => _SettingscreensState();
// }
//
// class _SettingscreensState extends State<Settingscreens> {
//   final UserController userController = Get.put(UserController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Getx"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 38.0),
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               Expanded(
//                 child: Obx(() {
//                   if (userController.userdata.isEmpty) {
//                     return Center(
//                       child: Text(
//                         "No User Exists",
//                         style: TextStyle(fontSize: 23, fontFamily: "bold"),
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     itemCount: userController.userdata.length,
//                     itemBuilder: (context, index) {
//                       final user = userController.userdata[index];
//                       return Card(
//                         color: AppColors.textfieldlightmode,
//                         child: ListTile(
//                           title: Text(
//                             user,
//                             style: TextStyle(
//                               fontFamily: "bold",
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                           trailing: Obx(() {
//                             final isFav = userController.favoreitelist.contains(user);
//                             return IconButton(
//                               onPressed: () => userController.addfavoriteuser(user),
//                               icon: isFav
//                                   ? Icon(Icons.favorite, color: Colors.red)
//                                   : Icon(Icons.favorite_border),
//                             );
//                           }),
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ),
//
//               SizedBox(height: 20,),
//               Obx(()=>Expanded(child:userController.favoreitelist.isEmpty?
//               Center(child: Text("",style: TextStyle(fontSize: 23,fontFamily: "bold"),),)
//                   : ListView.builder(itemCount: userController.favoreitelist.length,
//                 itemBuilder: (context,index){
//                   final user = userController.favoreitelist[index];
//                   final exists = userController.favoreitelist.contains(user);
//                   return Card(
//                     color: AppColors.textfieldlightmode,
//                     child: ListTile(
//                       title: Text(user,style: TextStyle(fontFamily: "bold",color: Colors.white,fontSize: 20),),
//                       trailing: Obx((){
//                         final exists = userController.favoreitelist.contains(user);
//                         return IconButton(
//                             onPressed: (){
//                               userController.addfavoriteuser(user);
//                             },
//                             icon:exists?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border) );
//                       })
//                     ),
//                   );
//                 },))),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: (){
//         addusrdialog(context,userController);
//       },
//       child: Icon(Icons.add),),
//     );
//   }
// }









// final username = Provider<String>((value)=>"Talha Afridi");
// final age = Provider((value)=>25);
// final email  = Provider((email)=>"ptii05125@gmail.com");
//
// final counter  = StateProvider<int>((valu)=>0);
// final notification = StateProvider((valu)=>false);
//
// class Settingscreens extends ConsumerStatefulWidget {
//   const Settingscreens({super.key});
//
//   @override
//   ConsumerState<Settingscreens> createState() => _SettingscreensState();
// }
//
// class _SettingscreensState extends ConsumerState<Settingscreens> {
//   @override
//   Widget build(BuildContext context) {
//     print("Rebuild");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("",style: TextStyle(fontSize: 23,fontFamily: "bold"),),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               color: AppColors.textfieldlightmode,
//               child: Padding(padding: EdgeInsets.all(15),
//               child: Consumer(builder: (context,ref,child){
//                 final digi = ref.watch(counter);
//                 return Text(digi.toString(),style: TextStyle(fontSize: 24,fontFamily: "bold"),);
//               },),
//             ),),
//             SizedBox(height: 20,),
//             Consumer(builder: (context,ref,child){
//               final showno = ref.watch(notification);
//               return SwitchListTile(
//                   value: showno,
//                   title: Text("Notification",style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 20),),
//                   onChanged: (value){
//                     ref.read(notification.notifier).state = ! ref.read(notification.notifier).state;
//                   });
//             })
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(onPressed: (){
//            if(ref.read(notification) == true){
//              print(ref.watch(notification));
//              ref.read(counter.notifier).state += 5;
//            }else{
//              ref.read(counter.notifier).state ++;
//            }
//           },backgroundColor:AppColors.textfieldlightmode,child: Icon(Icons.add),),
//           FloatingActionButton(onPressed: (){
//             ref.read(counter.notifier).state -- ;
//           },backgroundColor:AppColors.textfieldlightmode,child: Icon(Icons.remove),),
//         ],
//       ),
//     );
//   }
// }
//


// class Settingscreens extends ConsumerStatefulWidget {
//   const Settingscreens({super.key});
//
//   @override
//   ConsumerState<Settingscreens> createState() => _SettingscreensState();
// }
//
// class _SettingscreensState extends ConsumerState<Settingscreens> {
//   @override
//   Widget build(BuildContext context) {
//     final na = ref.watch(username);
//     final ag = ref.watch(age);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(na + ag.toString()),
//       ),
//     );
//   }
// }


// class Settingscreens extends ConsumerWidget {
//   const Settingscreens({super.key});
//
//   @override
//   Widget build(BuildContext context,ref) {
//     final name = ref.watch(username);
//     final useage = ref.watch(age);
//     final useremail = ref.watch(email);
//     var coun = ref.watch(counter);
//     print("Rebuild");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name + " " + useage.toString(),),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(coun.toString(),style: TextStyle(fontFamily: "bold",fontSize: 26),)
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(onPressed: (){
//             ref.read(counter.notifier).state ++ ;
//             print(coun);
//             print(ref.read(counter.notifier).state);
//           },
//             backgroundColor: AppColors.textfieldlightmode,
//             child: Icon(Icons.add),),
//           FloatingActionButton(onPressed: (){
//             ref.read(counter.notifier).state --;
//           },
//             backgroundColor: AppColors.textfieldlightmode,
//           child: Icon(Icons.remove),)
//         ],
//       )
//     );
//   }
// }
