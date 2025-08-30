


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/bloc/imagesbloc/image_bloc.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';
import 'package:riverpadstate/data/databasesave.dart';
import 'package:riverpadstate/revierpad/moodriverpad.dart';

import '../../config/components/customimageswidgets.dart';
import '../../models/moodmodels.dart';

class Moodscreens extends ConsumerStatefulWidget {
  const Moodscreens({super.key});

  @override
  ConsumerState<Moodscreens> createState() => _MoodscreensState();
}

class _MoodscreensState extends ConsumerState<Moodscreens> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future((){
      ref.read(moodproviders.notifier).getuserdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mood App"),
        actions: [
          Consumer(builder: (context,ref,child){
            final user = ref.watch(moodproviders.select((val)=>val.deletewidget));
            return Visibility(
              visible: user,
                child:
                IconButton(
                    onPressed: (){
                      ref.read(moodproviders.notifier).deletelistuser();
                      ref.read(moodproviders.notifier).hidewidget();
                    }, icon: Icon(Icons.delete,color: Colors.red,)) );
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                onChanged: (value){
                  ref.read(moodproviders.notifier).addsearch(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),),
                  prefixIcon: Icon(Icons.search),
                  label: Text("Search",style: TextStyle(color: Colors.white,fontFamily: "bold"),),
                ),
              ),
              SizedBox(height: 20,),
              Consumer(builder: (context,ref,child){
                final userdata = ref.watch(moodproviders);
                print(userdata.userlistdata);
                return Expanded(
                    child: userdata.dataloading == true?
                        Center(child: CircularProgressIndicator(color: Colors.white,))
                        :userdata.userlistdata.isEmpty?
                        Center(
                          child: Text("No Data Exists",style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 24),),
                        ):ListView.builder(itemCount: userdata.userlistdata.length,
                    itemBuilder: (context,index){
                          final user = userdata.userlistdata[index];
                          final exists = userdata.deletedlist.contains(user.id);
                         return Dismissible(
                           key: ValueKey(user.id.toString()),
                           onDismissed: (Disss){
                             ref.read(moodproviders.notifier).deleteuser(user.id!);
                           },
                           child: Card(
                             color: AppColors.textfieldlightmode,
                             child: ListTile(
                               onLongPress: (){
                                 ref.read(moodproviders.notifier).showwidget();
                               },
                               onTap: (){
                                 ref.read(moodproviders.notifier).hidewidget();
                               },
                               leading: CircleAvatar(
                                 backgroundImage: FileImage(File(user.image.toString())),
                               ),
                               title: Text(user.name.toString(),style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 23),),
                               subtitle: Text(user.work,style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: "bold"),),
                               trailing:Row(
                                 mainAxisSize: MainAxisSize.min,
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Visibility(
                                     visible: userdata.deletewidget,
                                     child: IconButton(onPressed: (){
                                       editmoodusrdialog(context,ref,user);
                                       ref.read(moodproviders.notifier).hidewidget();
                                     }, icon: Icon(Icons.edit)),),
                                   Visibility(
                                       visible: userdata.deletewidget,
                                       child: Checkbox(
                                           value: exists,
                                           onChanged: (value)=>ref.read(moodproviders.notifier).adddeletedid(user.id!))),
                                 ],
                               )
                             ),
                           ),
                         ) ;
                    },));
              })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          moodaddusrdialog(context, ref);
        },
      child: Icon(Icons.add),),
    );
  }
}


Future editmoodusrdialog(BuildContext context,WidgetRef ref,MoodModels moodmdels){
  final formkey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController workcontroller = TextEditingController();
  controller.text = moodmdels.name.toString();
  workcontroller.text = moodmdels.work.toString();

  return showDialog(context: context,
      builder: (context){
        return Form(
          key: formkey,
          child: AlertDialog(
            backgroundColor: AppColors.textfieldlightmode,
            title:Text("Update User",style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: "bold"),),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  BlocListener<ImageBloc, ImageStates>(
                    listener: (context, state) {
                      if(state.imagepath!.path.isNotEmpty&& state.imagepath != null){
                        ref.read(moodproviders.notifier).addimages(state.imagepath!.path.toString());
                        print(state.imagepath!.path.toString());
                      }
                    },
                    child: BlocBuilder<ImageBloc,ImageStates>(builder: (context,state){
                      final image = state.imagepath;
                      print("Images$image");
                      return InkWell(
                        onTap: ()=>showimagedialog(context),
                        child:image != null && image.path.isNotEmpty?
                        Customimagewidget(image: image.path.toString(),)
                            : Customimagewidget(image: moodmdels.image,),
                      );
                    }),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: controller,
                    onChanged: (value)=>ref.read(moodproviders.notifier).addusername(value),
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
                    onChanged: (value)=>ref.read(moodproviders.notifier).addwork(value),
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
              Consumer(builder: (context,ref,child){
                final userloading = ref.watch(moodproviders.select((val)=>val.loading));
                return TextButton(onPressed: ()async{
                  if(formkey.currentState!.validate()){
                    ref.read(moodproviders.notifier).updateuserdata(moodmdels);
                    ref.read(moodproviders.notifier).resetstates();
                    context.read<ImageBloc>().add(DeleteImages());
                    Navigator.pop(context);
                  }

                }, child:userloading?CircularProgressIndicator(): Text("Update",style: TextStyle(color: Colors.blue,fontFamily: "bold",fontSize: 23),));
              })
            ],
          ),
        );
      });
}

Future moodaddusrdialog(BuildContext context,WidgetRef ref){
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
                  BlocListener<ImageBloc, ImageStates>(
                  listener: (context, state) {
                    if(state.imagepath!.path.isNotEmpty&& state.imagepath != null){
                      ref.read(moodproviders.notifier).addimages(state.imagepath!.path.toString());
                      print(state.imagepath!.path.toString());
                    }
                  },
                  child: BlocBuilder<ImageBloc,ImageStates>(builder: (context,state){
                    final image = state.imagepath;
                    print("Images$image");
                    return InkWell(
                      onTap: ()=>showimagedialog(context),
                      child:image != null && image.path.isNotEmpty?
                          Customimagewidget(image: image.path.toString(),)
                          : Customimagewidget(),
                    );
                  }),
),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: controller,
                    onChanged: (value)=>ref.read(moodproviders.notifier).addusername(value),
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
                    onChanged: (value)=>ref.read(moodproviders.notifier).addwork(value),
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
              Consumer(builder: (context,ref,child){
                final userloading = ref.watch(moodproviders.select((val)=>val.loading));
                return TextButton(onPressed: ()async{
                  if(formkey.currentState!.validate()){
                    ref.read(moodproviders.notifier).adduserdata();
                    ref.read(moodproviders.notifier).resetstates();
                   context.read<ImageBloc>().add(DeleteImages());
                    Navigator.pop(context);
                  }

                }, child:userloading?CircularProgressIndicator(): Text("Add",style: TextStyle(color: Colors.blue,fontFamily: "bold",fontSize: 23),));
              })
            ],
          ),
        );
      });
}
