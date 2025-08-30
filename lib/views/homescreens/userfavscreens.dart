
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/config/domains/appcolors.dart';
import 'package:riverpadstate/revierpad/userrivepad.dart';

class Userfavscreens extends ConsumerWidget {
   Userfavscreens({super.key});

  String name  = "Talha";

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Favorite"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Center(
          child: Column(
            children: [
              Consumer(builder: (context,ref,child){
                final userdata= ref.watch(itemproviders);
                return Expanded(child: userdata.favoritelist.isEmpty?
                    Center(child: Text("No User in Faorites",style: TextStyle(fontFamily: "bold",fontSize: 20),),)
                    :ListView.builder(itemCount: userdata.favoritelist.length,
                itemBuilder: (context,index){
                      final user = userdata.favoritelist[index];
                      return Dismissible(
                        key: ValueKey(user.id.toString()),
                        onDismissed: (Diss){
                          ref.read(itemproviders.notifier).deletefromfavoreit(user.id);
                        },
                        child: Card(
                          color: AppColors.textfieldlightmode,
                          child: ListTile(
                          title: Text(user.username,style: TextStyle(fontSize: 20,fontFamily: "bold",color: Colors.white),),
                            subtitle: Text(user.work,style: TextStyle(fontSize: 13,fontFamily: "bold",color: Colors.white),),
                            trailing: IconButton(onPressed: (){
                              ref.read(itemproviders.notifier).addinfavoreitelist(user);
                            },
                                icon:Icon(Icons.favorite,color: Colors.red,)),
                          ),
                        ),
                      );
                },));
              })
            ],
          ),
        ),
      ),
    );
  }
}
