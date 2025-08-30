
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';
import 'package:riverpadstate/revierpad/apiuserproviders.dart';
import 'package:riverpadstate/revierpad/getfirebasedataprovider.dart';
import 'package:riverpadstate/revierpad/streamproviders.dart';


class Todoscreens extends ConsumerStatefulWidget {
  const Todoscreens({super.key});

  @override
  ConsumerState<Todoscreens> createState() => _TodoscreensState();
}

class _TodoscreensState extends ConsumerState<Todoscreens> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future((){
    //   ref.read(appuserprovider.notifier).getuserdata();
    // });
  }
  @override
  Widget build(BuildContext context) {
    final firebasedata  = ref.watch(changeproviders(10));
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo"),
      ),
      body: Padding(
        padding: const EdgeInsets.
          symmetric(horizontal: 38.0),
        child: Center(
          child: Column(
           children: [
             Text(firebasedata.toString(),style: TextStyle(fontSize: 23,fontFamily: "bold"),)
           ],
          ),
        ),
      ),
    );
  }
}


//   Expanded(
//                child: StreamBuilder(
//                    stream: firebasedata.value,
//                    builder: (context,snapshot){
//                      if(snapshot.connectionState == ConnectionState.waiting){
//                        return Center(child: CircularProgressIndicator(color: Colors.white,),);
//                      }else if(snapshot.hasError){
//                        return Center(child: Text(snapshot.error.toString()),);
//                      }else if(!snapshot.hasData){
//                        return Text("No Data foud");
//                      }else{
//                        return ListView.builder(itemCount: snapshot.data!.docs.length,
//                        itemBuilder: (context,index){
//                          final message = snapshot.data!.docs[index];
//                          return Dismissible(
//                            key: ValueKey(message.id.toString()),
//                            onDismissed: (value)async{
//                              await FirebaseFirestore.instance.collection("notifications").doc(message.id).delete();
//                            },
//                            child: Card(
//                              color: AppColors.textfieldlightmode,
//                              child: ListTile(
//                                leading: CircleAvatar(
//                                  backgroundImage: AssetImage("assets/images/riv.png"),
//                                ),
//                                title: Text(message["title"].toString(),style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 20),),
//                                subtitle: Text(message["body"].toString(),style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 12)),
//                              ),
//                            ),
//                          );
//                        },);
//                      }
//                    }),
//              )


// Consumer(builder: (context,ref,child){
//                final userlist = ref.watch(streamproviders);
//                return Card(
//                  color: AppColors.textfieldlightmode,
//                  child: Padding(padding: EdgeInsets.all(12),
//                    child:userlist.when(
//                        data: (scope){
//                          return Text(userlist.value.toString(),style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold"),);
//                        },
//                        error: (error,sace)=>Text(error.toString()),
//                        loading: ()=>CircularProgressIndicator(color: Colors.white,)
//                    ),),
//                );
//              })

//ced105cb87bc478985b183234252008

// children: [
//               SizedBox(height: 20,),
//                 Expanded(
//                   child: Consumer(builder: (context,ref,child){
//                     final userdata = ref.watch(appuserprovider);
//                     switch(userdata.userStates){
//                       case UserStates.failure:
//                         return Center(
//                           child: Text(userdata.message,style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold"),),
//                         );
//                       case UserStates.initial:
//                       case UserStates.loading:
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       case UserStates.success:
//                         return ListView.builder(itemCount: userdata.userApiModel?.data?.length,
//                         itemBuilder: (context,index){
//                           final user = userdata.userApiModel?.data![index];
//                           return Card(
//                             color: AppColors.textfieldlightmode,
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(user!.avatar.toString()),
//                               ),
//                               title:Text("${user.firstName}${user.lastName}",style: TextStyle(fontFamily: "bold",color: Colors.white),) ,
//                               subtitle: Text(user.email.toString(),style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 12),),
//                             ),
//                           );
//                         },);
//
//                     }
//                   }),
//                 )
//             ],