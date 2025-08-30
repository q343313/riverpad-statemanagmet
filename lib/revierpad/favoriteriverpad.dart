


import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteriverpad = StateNotifierProvider<FavoriteNotifier,FaovireitStats>((val)=>FavoriteNotifier());


class FavoriteNotifier extends StateNotifier<FaovireitStats>{
  FavoriteNotifier():super(FaovireitStats(
      userdatalist: [],
      favoritelistdata: [],
    username: "",
    deletelist: [],
    showvisible: false,
    hidevisible: false
  ));

  addusername(String name){
   state  = state.copyWith(username: name);
  }

  adduservalue(String vl){
   state =  state.copyWith(userdatalist: [...state.userdatalist,vl]);
  }

  addfavoritevalue(String value){
    if(state.favoritelistdata.contains(value)){
      List<String> newlist = state.favoritelistdata;
     state =  state.copyWith(favoritelistdata: newlist.where((ele)=>ele!=value).toList());
    }else{
     state  = state.copyWith(favoritelistdata: [...state.favoritelistdata,value]);
    }
  }

  visiblewidget(){
    state  =state.copyWith(showvisible: true);
  }

  hidewidget(){
    state =  state.copyWith(showvisible: false);
  }

  adddeletevalue(String value){
    if(state.deletelist.contains(value)){
      state = state.copyWith(deletelist: state.deletelist.where((ele)=>ele != value).toList());
    }else{
      state = state.copyWith(deletelist: [...state.deletelist,value]);
    }
  }

  deletevalues(){
    state  =state.copyWith(userdatalist: state.userdatalist.where((name)=>!state.deletelist.contains(name)).toList());
  }

  deletesinglevalue(String value){
    state = state.copyWith(userdatalist: state.userdatalist.where((name)=>name!= value).toList());
  }

}

class FaovireitStats{
  final List<String> userdatalist;
  final List<String> favoritelistdata;
  final List<String>deletelist;
  final String username;
  final bool showvisible;
  final bool hidevisible;

  FaovireitStats({
    required this.userdatalist,
    required this.favoritelistdata,
    required this.username,
    required this.deletelist,
    required this.showvisible,
    required this.hidevisible
  });
  FaovireitStats copyWith({
    List<String>?userdatalist,
    List<String>?favoritelistdata,
    String?username,
    List<String>?deletelist,
    bool?showvisible,
     bool?hidevisible,
}){
    return FaovireitStats(
        userdatalist: userdatalist??this.userdatalist,
        favoritelistdata: favoritelistdata??this.favoritelistdata,
      username: username??this.username,
      deletelist: deletelist??this.deletelist,
      showvisible: showvisible??this.showvisible,
      hidevisible: hidevisible??this.hidevisible

    );
  }
}