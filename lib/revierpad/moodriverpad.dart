



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/data/databasesave.dart';
import 'package:riverpadstate/main.dart';
import 'package:riverpadstate/models/moodmodels.dart';

final moodproviders  = StateNotifierProvider<MoodNotifier,MoodStates>((ele)=>MoodNotifier(getIt()));


class MoodNotifier extends StateNotifier<MoodStates>{
     List<MoodModels>userdatalist = [];

  final UserDataBase userDataBase;
  MoodNotifier(this.userDataBase):super(MoodStates(
      work: "",
      name: "",
      loading: false,
      visible: false,
      images: "",
    message: "",
    userlistdata: [],
    dataloading: false,
    deletedlist: [],
    deletewidget: false,
    search:  "",
    searchlist: []
  ));

  addusername(String name){
    state = state.copyWith(name: name);
  }

  addimages(String images){
    state = state.copyWith(images: images);
  }

  addwork(String work){
    state = state.copyWith(work: work);
  }

  adduserdata()async{
    state = state.copyWith(loading: true);
   try{
     MoodModels models = MoodModels(name: state.name, work: state.work, image: state.images);
     await userDataBase.adduser(models);
     userdatalist  = await userDataBase.getdata();
    state =  state.copyWith(loading: false,message: "User Data Added Succesfully",userlistdata: userdatalist);
   }catch(e){
     state = state.copyWith(loading: false,message: e.toString());
   }
  }

  getuserdata()async{
    try{
      state = state.copyWith(dataloading: true);
      userdatalist = await userDataBase.getdata();
      state = state.copyWith(dataloading: false,userlistdata: userdatalist,message: "Get user data succesfully",searchlist: userdatalist);

    }catch(e){
      state = state.copyWith(dataloading: false);
    }
  }

  resetstates(){
    state  =state.copyWith(name: "",work: "",images: "",loading: false,dataloading: false);
  }

  deleteuser(int id)async{
    await userDataBase.deleteuser(id);
    userdatalist = await userDataBase.getdata();
    state = state.copyWith(userlistdata: userdatalist);
  }

  adddeletedid(int id){
    if(state.deletedlist.contains(id)){
      state = state.copyWith(deletedlist: state.deletedlist.where((val)=>val != id).toList());
    }else{
      state = state.copyWith(deletedlist: [...state.deletedlist,id]);
    }

    print(state.deletedlist);
  }

  showwidget(){
    state = state.copyWith(deletewidget: true);
  }

  hidewidget(){
    state = state.copyWith(deletewidget: false);
  }

  deletelistuser()async{
    await userDataBase.deletelistuser(state.deletedlist);
    userdatalist = await userDataBase.getdata();
    state  =state.copyWith(userlistdata: userdatalist,deletedlist: []);
  }

  updateuserdata(MoodModels modelssss)async{
    state = state.copyWith(loading: true);
    try{
      final name = state.name == null || state.name.isEmpty?modelssss.name:state.name;
      final work = state.work == null || state.work.isEmpty?modelssss.work:state.work;
      final images = state.images == null || state.images.isEmpty?modelssss.image:state.images;
      MoodModels models = MoodModels(name: name, work: work, image: images,id:modelssss.id);
      await userDataBase.updateuserdata(models);
      userdatalist  = await userDataBase.getdata();
      state =  state.copyWith(loading: false,message: "User Data Updated Succesfully",userlistdata: userdatalist);
    }catch(e){
      state = state.copyWith(loading: false,message: e.toString());
    }
  }

  addsearch(String value)async{
    state =state.copyWith(search: value);
    if(state.search.isEmpty || state.search == ""){
      state = state.copyWith(userlistdata: state.searchlist);
    }else{
      state = state.copyWith(userlistdata: state.searchlist.where((e)=>e.name.toString().contains(state.search)).toList());
    }
  }

  searchvalue(){
    if(state.search.isEmpty || state.search == ""){
      state = state.copyWith(userlistdata: state.searchlist);
    }else{
      state = state.copyWith(userlistdata: state.searchlist.where((e)=>e.name.toString().contains(state.search)).toList());
    }
  }


}


class MoodStates {
  final String name;
  final String images;
  final String work;
  final bool loading;
  final bool visible;
  final  String message;
  final bool dataloading;
  final List<MoodModels>userlistdata;
  final List<int> deletedlist;
  final bool deletewidget;
  final  String search;
  final List<MoodModels>searchlist;
  MoodStates({
    required this.work,
    required this.message,
    required this.name,
    required this.loading,
    required this.visible,
    required this.images,
    required this.userlistdata,
   required this.dataloading,
    required this.deletedlist,
    required this.deletewidget,
    required this.search,required this.searchlist
});

  MoodStates copyWith({
     String?name,
     String?images,
     String?work,
    bool?dataloading,
     bool?loading,
     bool?visible,
    String?message,
    List<MoodModels>?userlistdata,
    List<int>?deletedlist,
    bool?deletewidget,
    String?search,
     List<MoodModels>?searchlist

}){
    return MoodStates(
        work: work??this.work,
        name: name??this.name,
        loading: loading??this.loading,
        visible: visible??this.visible,
        images: images??this.images,
      dataloading: dataloading??this.dataloading,
      message: message??this.message,
      userlistdata: userlistdata??this.userlistdata,
      deletedlist: deletedlist??this.deletedlist,
      deletewidget: deletewidget??this.deletewidget,
      search: search??this.search,
      searchlist: searchlist??this.searchlist
    );
}

}