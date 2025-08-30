


import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/models/usermodels.dart';

final itemproviders = StateNotifierProvider<ItemNotifiers,UserStates>((val)=>ItemNotifiers());


class ItemNotifiers extends StateNotifier<UserStates>{
  ItemNotifiers():super(UserStates(
      favoritelist: [],
      usertdatalist: [],
    id: 0,
    deletelist: [],
    showvisible: false
  ));

  adduserinlist(String username,String work){
    var id  = Random().nextInt(100);
    UserModels userModels  = UserModels(username: username, id: id, work: work);
    state = state.copyWith(usertdatalist: [...state.usertdatalist,userModels]);
  }


  addinfavoreitelist(UserModels usermodels){
    if(state.favoritelist.contains(usermodels)){
      state = state.copyWith(favoritelist: state.favoritelist.where((val)=>val != usermodels).toList());
    }else{
      state = state.copyWith(favoritelist: [...state.favoritelist,usermodels]);
    }
  }

deletevalues(int id){
    state  =state.copyWith(usertdatalist: state.usertdatalist.where((user)=>user.id != id).toList());
}

addvaluesindeletelist(UserModels usermodels){
    if(state.deletelist.contains(usermodels)){
      state = state.copyWith(deletelist: state.deletelist.where((user)=>user != usermodels).toList());
    }else{
      state = state.copyWith(deletelist: [...state.deletelist,usermodels]);
    }
}

showwidget(){
    state = state.copyWith(showvisible:  true);
}
hidewidget(){
    state = state.copyWith(showvisible: false);
}

deleteallvalues(){
    state = state.copyWith(usertdatalist: state.usertdatalist.where((user)=>!state.deletelist.contains(user)).toList());
}

deletefromfavoreit(int id){
    state = state.copyWith(favoritelist: state.favoritelist.where((user)=>user.id != id).toList());
}

}

class UserStates {
  final List<UserModels>usertdatalist ;
 final List<UserModels>  favoritelist;
 final List<UserModels>deletelist;
 final bool showvisible;
 final int id;
 UserStates({required this.favoritelist,
   required this.usertdatalist,
   required this.id,
   required this.deletelist,
   required this.showvisible
 });
 UserStates copyWith({
   List<UserModels>?usertdatalist ,
   List<UserModels>? favoritelist,
   List<UserModels>?deletelist,
   int?id,
   bool?showvisible
}){
   return UserStates(
       favoritelist: favoritelist??this.favoritelist,
       usertdatalist: usertdatalist??this.usertdatalist,
       deletelist: deletelist??this.deletelist,
       showvisible: showvisible??this.showvisible,
       id: id??this.id);
 }
}