



import 'package:flutter_riverpod/flutter_riverpod.dart';

final counter = StateProvider((value)=>0);

final switchtbutton = StateProvider((val)=>false);

final slider = StateProvider((val)=>0.0);
final showpassword = StateProvider((val)=>false);

final userlist = StateProvider<List<String>>((user)=>["Talha","Wal","Khan","Shah","Nouman","Jan","Suliman"]);
final favoritelist = StateProvider<List>((fav)=>[]);


final allappstatess  = StateProvider<NewAppStates>((val)=>
    NewAppStates(
        showpassword: false,
        slider: 0.0,
        counter: 0,
        userlist: ["Talha","Wal","Khan","Shah","Nouman","Jan","Suliman"],
        favoritelist: [],
        swithchbutton: false
    ));


class NewAppStates{

  final int counter;
  final bool swithchbutton;
  final double slider;
  final bool showpassword;
  final List<String> userlist;
  final List favoritelist;

  NewAppStates({
    required this.showpassword,
    required this.slider,
    required this.counter,
    required this.userlist,
    required this.favoritelist,
    required this.swithchbutton,
});

  NewAppStates copyWith({
     int?counter,
     bool?swithchbutton,
     double?slider,
     bool?showpassword,
     List<String>?userlist,
     List?favoritelist,
}){
    return NewAppStates(
        showpassword: showpassword??this.showpassword,
        slider: slider??this.slider,
        counter: counter??this.counter,
        userlist: userlist??this.userlist,
        favoritelist: favoritelist??this.favoritelist,
        swithchbutton: swithchbutton??this.swithchbutton
    );
  }

  NewAppStates.fromJson(Map<String,dynamic>json):
   counter = json["counter"],
  swithchbutton = json["swithchbutton"],
  slider = json["slider"],
  userlist = json["userlist"],
  favoritelist = json["favoritelist"],
  showpassword = json["showpassword"];

  Map<String,dynamic>toMap()=>{
    "counter":counter,
    "swithchbutton":swithchbutton,
    "slider":slider,
    "userlist":userlist,
    "favoritelist":favoritelist,
    "showpassword":showpassword
  };

}


void logicfaveoriapp(WidgetRef ref,value){
  final exists = ref.read(favoritelist.notifier).state.contains(value);
  final firstlist = ref.read(favoritelist.notifier).state;
  final favlist = ref.watch(favoritelist);
  if(exists){
    var  newlist = [];
    for (var i in favlist){
      if(i != value){
        newlist.add(i);
      }
    }
    ref.read(favoritelist.notifier).state  =favlist.where((ele)=>ele!= value).toList();
  }else{
    ref.read(favoritelist.notifier).state = [...firstlist,value];
  }
}