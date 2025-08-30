
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/domains/appcolors.dart';
import '../../revierpad/favoriteriverpad.dart';

class Favoritetscrees extends ConsumerWidget {
  const Favoritetscrees({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Screens"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 29,),
              Consumer(builder: (context,ref,child){
                final userlist = ref.watch(favoriteriverpad);
                return Expanded(child:userlist.favoritelistdata.isEmpty
                    ?Center(child: Text("Not Favorite User ",style: TextStyle(fontFamily: "bold",fontSize: 24),))
                    : ListView.builder(itemCount: userlist.favoritelistdata.length,
                  itemBuilder: (context,index){
                    final usr = userlist.favoritelistdata[index];
                    return Card(
                      color: AppColors.textfieldlightmode,
                      child: ListTile(
                        title: Text(usr,style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: "bold"),),
                        trailing: IconButton(onPressed: (){
                          ref.read(favoriteriverpad.notifier).addfavoritevalue(usr);
                        }, icon:Icon(Icons.favorite,color: Colors.red,) ),
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
