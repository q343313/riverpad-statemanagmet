
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';
import 'package:riverpadstate/revierpad/fullriverpad.dart';
import 'package:riverpadstate/revierpad/searchrevirpad.dart';
import 'package:riverpadstate/revierpad/userrivepad.dart';
import 'package:riverpadstate/views/homescreens/userfavscreens.dart';


class Homescreens extends ConsumerWidget {
  const Homescreens({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Userfavscreens()));
          }, icon: Icon(Icons.new_label)),
         Consumer(builder: (context,ref,child){
           final items = ref.watch(itemproviders.select((val)=>val.showvisible));
           return Visibility(
             visible: items,
               child:  IconButton(
               onPressed: (){
                 ref.read(itemproviders.notifier).deleteallvalues();
                 ref.read(itemproviders.notifier).hidewidget();
               },
               icon: Icon(Icons.delete,color: Colors.red,)));
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
                final userlist = ref.watch(itemproviders);
                return Expanded(child: userlist.usertdatalist.isEmpty?
                Center(
                  child: Text("User Not Exists",style: TextStyle(fontSize: 23,fontFamily: "bold",color: Colors.white)),
                )
                    :ListView.builder(itemCount: userlist.usertdatalist.length,
                itemBuilder: (context,index){
                      final user = userlist.usertdatalist[index];
                      final exits  = userlist.favoritelist.contains(user);
                      final deleteexists  = userlist.deletelist.contains(user);
                      print(user.id);
                      return Dismissible(
                        key: ValueKey(user.id.toString()),
                        onDismissed: (Dismissi){
                          ref.read(itemproviders.notifier).deletevalues(user.id);
                        },
                        child: Card(
                          color: AppColors.textfieldlightmode,
                          child: ListTile(
                            onTap: ()=>ref.read(itemproviders.notifier).hidewidget(),
                            onLongPress: ()=>ref.read(itemproviders.notifier).showwidget(),
                            leading: Visibility(
                              visible: userlist.showvisible,
                                child: Checkbox(
                                    value: deleteexists,
                                    onChanged: (value){
                                      ref.read(itemproviders.notifier).addvaluesindeletelist(user);
                                    }
                                )),
                            title: Text(user.username,style: TextStyle(fontSize: 23,fontFamily: "bold",color: Colors.white),),
                            subtitle: Text(user.work,style: TextStyle(fontSize: 13,fontFamily: "bold",color: Colors.white),),
                            trailing: IconButton(onPressed: (){
                              ref.read(itemproviders.notifier).addinfavoreitelist(user);
                            },
                                icon: exits?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border)),
                          ),
                        ),
                      );
                },)
                );
              })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          useraddusrdialog(context, ref);
        },
      child: Icon(Icons.add),),
    );
  }
}

Future useraddusrdialog(BuildContext context,WidgetRef ref){
  final formkey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController workcontroller = TextEditingController();
  return showDialog(context: context,
      builder: (context){
        return Form(
          key: formkey,
          child: AlertDialog(
            backgroundColor: AppColors.textfieldlightmode,
            title:Text("Add User",style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: "bold"),),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
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
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: workcontroller,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter value";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        label: Text("Work"),
                        prefixIcon: Icon(Icons.account_circle)
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);

              }, child: Text("cancel",style: TextStyle(color: Colors.blue,fontFamily: "bold",fontSize: 23),)),
              TextButton(onPressed: (){
                if(formkey.currentState!.validate()){
                  ref.read(itemproviders.notifier).adduserinlist(controller.text, workcontroller.text);
                  Navigator.pop(context);
                }

              }, child: Text("Add",style: TextStyle(color: Colors.blue,fontFamily: "bold",fontSize: 23),))
            ],
          ),
        );
      });
}


// class Homescreens extends ConsumerStatefulWidget {
//   const Homescreens({super.key});
//
//   @override
//   ConsumerState<Homescreens> createState() => _HomescreensState();
// }
//
// class _HomescreensState extends ConsumerState<Homescreens> {
//   TextEditingController searchcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//
//     final seraec = ref.watch(searchprovider);
//     print("Rebuild");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home "),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 28.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Consumer(
//                   builder: (context,ref,child){
//                     final searchh = ref.watch(searchprovider.select((val)=>val.search));
//                 return TextFormField(
//                   controller: searchcontroller,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(20)),
//                       label: Text("search",style: TextStyle(color: Colors.white,fontFamily: "bold"),),
//                       suffixIcon: IconButton(onPressed: (){
//                         ref.read(searchprovider.notifier).search(searchcontroller.text);
//                       }, icon: Icon(Icons.search))
//                   ),
//                 );
//               }),
//
//               SizedBox(height: 15,),
//               Consumer(
//                   builder: (context,ref,child){
//                     final showwww = ref.watch(searchprovider.select((val)=>val.showpassword));
//                 return TextFormField(
//                   onChanged: (value)=>ref.read(searchprovider.notifier).password(value),
//                   obscureText: showwww,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(20)),
//                       label: Text("password",style: TextStyle(color: Colors.white,fontFamily: "bold"),),
//                       suffixIcon: IconButton(onPressed: (){
//                         ref.read(searchprovider.notifier).showpassword();
//                       }, icon: Icon(showwww?Icons.visibility:Icons.visibility_off))
//                   ),
//                 );
//               }),
//               SizedBox(height: 20,),
//               Consumer(builder: (context,ref,child){
//                 return Card(
//                   color: AppColors.textfieldlightmode,
//                   child: Padding(padding: EdgeInsets.all(12),
//                       child: Column(
//                         children: [
//                           Text(seraec.search,style: TextStyle(fontFamily: "bold",fontSize: 17),),
//                           Text(seraec.password,style: TextStyle(fontFamily: "bold",fontSize: 17),),
//                         ],
//                       )),
//                 );
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// class Homescreens extends ConsumerWidget {
//   const Homescreens({super.key});
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     final allref = ref.watch(allappstatess);
//     var refffff  =ref.read(allappstatess.notifier).state;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Screens"),
//       ),
//       body: Center(
//         child:Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               color: AppColors.textfieldlightmode,
//               child: Padding(padding: EdgeInsets.all(14),
//                   child: Consumer(builder: (context,ref,child){
//                     return Text(allref.counter.toString(),style: TextStyle(fontFamily: "bold",fontSize: 20),);
//                   })),
//             ),
//             SizedBox(height: 20,),
//
//             Consumer(builder: (context,ref,child){
//               return SwitchListTile(
//                   value: allref.swithchbutton,
//                   title: Text("Notification",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "bold"),),
//                   onChanged: (value)=>ref.read(allappstatess.notifier).state = refffff.copyWith(swithchbutton: !allref.swithchbutton));
//             }),
//             SizedBox(height: 20,),
//             Consumer(builder: (context,ref,child){
//               return Card(
//                 color: Colors.blueAccent.withOpacity(allref.slider),
//                 child: TextFormField(
//                   obscureText: allref.showpassword,
//                   obscuringCharacter: "-",
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       suffixIcon: IconButton(
//                           onPressed: (){
//                             ref.read(allappstatess.notifier).state= refffff.copyWith(showpassword: !allref.showpassword);
//                           },
//                           icon: Icon(allref.showpassword?Icons.visibility_off:Icons.visibility,color: Colors.white,))
//                   ),
//                 ),
//               );
//             }),
//             SizedBox(height: 20,),
//             Consumer(builder: (context,ref,child){
//               return Slider(value: allref.slider, onChanged: (value)=>ref.read(allappstatess.notifier).state  =refffff.copyWith(slider: value) );
//             })
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(
//             onPressed: (){
//              var  newcounter = allref.counter;
//               ref.read(allappstatess.notifier).state = refffff.copyWith(counter: allref.counter +1);
//             },
//             backgroundColor: AppColors.textfieldlightmode,
//             child: Icon(Icons.add),),
//           FloatingActionButton(onPressed: (){
//           ref.read(allappstatess.notifier).state = refffff.copyWith(counter:allref.counter -1 );
//           },
//             backgroundColor: AppColors.textfieldlightmode,
//             child: Icon(Icons.remove),)
//         ],
//       ),
//     );
//   }
// }


// final userdata  = StateProvider<List>((value)=>["Talha","Wali","Ali","Kali","Nali","Sali","Jali"]);
// final favoritedata = StateProvider<List>((value)=>[]);
// final slidervlue = StateProvider<double>((value)=>0.0);

// class Homescreens extends ConsumerStatefulWidget {
//   const Homescreens({super.key});
//
//   @override
//   ConsumerState<Homescreens> createState() => _HomescreensState();
// }
//
// class _HomescreensState extends ConsumerState<Homescreens> {
//   @override
//   Widget build(BuildContext context) {
//     final listdata = ref.watch(userlist);
//     final favlist  = ref.watch(favoritelist);
//     return Scaffold(
//       appBar: AppBar(
//           title: Text("Favorite App")
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 28.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 7,
//                 child: ListView.builder(itemCount: listdata.length,
//                   itemBuilder: (context,index){
//                     final exists = ref.read(favoritelist.notifier).state.contains(listdata[index]);
//                     return Card(
//                       color: AppColors.textfieldlightmode,
//                       child: ListTile(
//                         title: Text(listdata[index],style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold"),),
//                         trailing: IconButton(
//                             onPressed: (){
//                               logicfaveoriapp(ref, listdata[index]);
//                             }, icon:exists?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border) ),
//                       ),
//                     );
//                   },),
//               ),
//               Expanded(
//                   flex: 4,
//                   child:ListView.builder(itemCount:favlist.length ,
//                     itemBuilder: (context,index){
//                       return Card(
//                         color: AppColors.textfieldlightmode,
//                         child: ListTile(
//                           title: Text(listdata[index],style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold"),),
//                           trailing: IconButton(
//                               onPressed: (){
//                                 logicfaveoriapp(ref, listdata[index]);
//                               }, icon:Icon(Icons.favorite,color: Colors.red,) ),
//                         ),
//                       );
//                     },))
//             ],
//           ),
//         ),
//       ),
//     );;
//   }
// }


// class Homescreens extends ConsumerWidget {
//   const Homescreens({super.key});
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     final  listdata = ref.watch(userlist);
//     final favlist = ref.watch(favoritelist);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Favorite App")
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 28.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 7,
//                 child: ListView.builder(itemCount: listdata.length,
//                 itemBuilder: (context,index){
//                   final exists = ref.read(favoritelist.notifier).state.contains(listdata[index]);
//                   return Card(
//                     color: AppColors.textfieldlightmode,
//                     child: ListTile(
//                       title: Text(listdata[index],style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold"),),
//                       trailing: IconButton(
//                           onPressed: (){
//                             logicfaveoriapp(ref, listdata[index]);
//                       }, icon:exists?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border) ),
//                     ),
//                   );
//                 },),
//               ),
//               Expanded(
//                 flex: 4,
//                   child:ListView.builder(itemCount:favlist.length ,
//               itemBuilder: (context,index){
//                 return Card(
//                   color: AppColors.textfieldlightmode,
//                   child: ListTile(
//                     title: Text(listdata[index],style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold"),),
//                     trailing: IconButton(
//                         onPressed: (){
//                           logicfaveoriapp(ref, listdata[index]);
//                         }, icon:Icon(Icons.favorite,color: Colors.red,) ),
//                   ),
//                 );
//               },))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// class Homescreens extends ConsumerStatefulWidget {
//   const Homescreens({super.key});
//
//   @override
//   ConsumerState<Homescreens> createState() => _HomescreensState();
// }
//
// class _HomescreensState extends ConsumerState<Homescreens> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Screens"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 38.0),
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               Consumer(builder: (context,ref,child){
//                 final listdata  = ref.watch(userdata);
//                 final listfav  = ref.watch(favoritedata);
//                 final slddd  = ref.watch(slidervlue);
//                 print("rebuild22");
//                 return Expanded(child:  ListView.builder(itemCount: listdata.length,
//                   itemBuilder: (context,index){
//                     final exists = ref.read(favoritedata.notifier).state.contains(listdata[index]);
//                     return Card(
//                       color: AppColors.textfieldlightmode.withOpacity(slddd),
//                       child: ListTile(
//                         title: Text(listdata[index],style: TextStyle(fontSize: 23,fontFamily: "bold",color: Colors.white),),
//                         trailing: IconButton(
//                             onPressed: (){
//                               final currentlist = ref.read(favoritedata.notifier).state;
//                               if(exists){
//                                 final newlist = [];
//                                 for(var i in currentlist){
//                                   if(i != listdata[index]){
//                                     newlist.add(i);
//                                   }
//                                 }
//                                 ref.read(favoritedata.notifier).state =newlist;
//                                 // currentlist.where((eke)=>eke != listdata[index]).toList();
//                               }else{
//                                 ref.read(favoritedata.notifier).state = [...currentlist,listdata[index]];
//                               }
//                             }, icon:
//                            listfav.contains(listdata[index])?Icon(Icons.favorite,color: Colors.red,)
//                               :Icon(Icons.favorite_border)),
//                       ),
//                     );
//                   },));
//               }),
//               SizedBox(height: 20,),
//               Consumer(builder: (context,ref,child){
//                 final sliderdata = ref.watch(slidervlue);
//                 return Slider(value: sliderdata, onChanged: (value){
//                   ref.read(slidervlue.notifier).state = value;
//                 });
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// onPressed: (){
//                            if(exists){
//                              ref.read(favoritedata.notifier).state.remove(listdata[index]);
//                            }else{
//                              ref.read(favoritedata.notifier).state.add(listdata[index]);
//                            }
//                           }
